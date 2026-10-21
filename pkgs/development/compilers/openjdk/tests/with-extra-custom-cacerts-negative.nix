{
  stdenv,
  jdk,
}:

let
  dummyCert = stdenv.mkDerivation {
    pname = "${jdk.pname}-with-extra-custom-cacerts-negative-test-cert";
    version = jdk.version;
    dontUnpack = true;
    buildPhase = ''
      runHook preBuild

      ${jdk}/bin/keytool \
        -genkeypair \
        -alias nixpkgs-java-test-ca-negative \
        -keyalg RSA \
        -validity 3650 \
        -dname "CN=nixpkgs-java-test-ca-negative" \
        -ext bc=ca:true \
        -ext ku=keyCertSign \
        -storetype PKCS12 \
        -keystore keystore.p12 \
        -storepass changeit \
        -keypass changeit

      ${jdk}/bin/keytool \
        -exportcert \
        -rfc \
        -alias nixpkgs-java-test-ca-negative \
        -storetype PKCS12 \
        -keystore keystore.p12 \
        -storepass changeit \
        -file dummy-cert.pem

      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      install -Dm644 dummy-cert.pem $out
      runHook postInstall
    '';
  };
in
stdenv.mkDerivation {
  pname = "${jdk.pname}-with-extra-custom-cacerts-negative-test";
  version = jdk.version;
  dontUnpack = true;
  buildPhase = ''
    runHook preBuild

    cat > VerifyExtraCertTrusted.java <<'EOF'
    import java.io.InputStream;
    import java.nio.file.Files;
    import java.nio.file.Path;
    import java.lang.reflect.Method;
    import java.security.KeyStore;
    import java.security.cert.CertificateFactory;
    import java.security.cert.X509Certificate;
    import java.util.Enumeration;

    public class VerifyExtraCertTrusted {
      public static void main(String[] args) throws Exception {
        if (args.length != 1) {
          throw new IllegalArgumentException("expected path to PEM cert");
        }

        X509Certificate expected;
        try (InputStream in = Files.newInputStream(Path.of(args[0]))) {
          expected = (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(in);
        }

        Class<?> trustStoreManager = Class.forName("sun.security.ssl.TrustStoreManager");
        Method getTrustedKeyStore = trustStoreManager.getDeclaredMethod("getTrustedKeyStore");
        getTrustedKeyStore.setAccessible(true);
        KeyStore ks = (KeyStore) getTrustedKeyStore.invoke(null);

        byte[] expectedEncoded = expected.getEncoded();
        Enumeration<String> aliases = ks.aliases();
        while (aliases.hasMoreElements()) {
          String alias = aliases.nextElement();
          var cert = ks.getCertificate(alias);
          if (cert instanceof X509Certificate x509Cert) {
            if (java.util.Arrays.equals(expectedEncoded, x509Cert.getEncoded())) {
              return;
            }
          }
        }

        throw new IllegalStateException("extra certificate was not trusted");
      }
    }
    EOF

    ${jdk}/bin/javac VerifyExtraCertTrusted.java
    if ${jdk}/bin/java --add-opens java.base/sun.security.ssl=ALL-UNNAMED VerifyExtraCertTrusted ${dummyCert}; then
      echo "unexpected success: unwrapped OpenJDK trusted extra certificate" >&2
      exit 1
    fi

    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    touch $out
    runHook postInstall
  '';
}
