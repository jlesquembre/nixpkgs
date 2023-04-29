{ lib, stdenv, fetchurl, jdk, makeWrapper, nixosTests }:

stdenv.mkDerivation rec {
  pname = "pulsar";
  version = "2.11.0";

  src = fetchurl {
    url = "mirror://apache/pulsar/${pname}-${version}/apache-${pname}-${version}-bin.tar.gz";
    hash = "sha256-oZ29xS1FCT4RK8LcF8gMYQlOvglrBGD7KMMybizfCTg=";
  };

  buildInputs = [ makeWrapper jdk ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    mkdir -p $out
    rm bin/*.cmd
    cp -R bin instances lib conf $out
    patchShebangs $out/bin
    for i in $out/bin/*; do
      if [ -f $i ]; then
        wrapProgram $i --set JAVA_HOME "${jdk}"
      fi
    done
  '';

  passthru.tests.pulsar-single-node = nixosTests.pulsar-single-node;
  passthru.tests.pulsar-multi-node = nixosTests.pulsar-multi-node;

  meta = with lib; {
    homepage = "https://pulsar.apache.org";
    description = "An open-source distributed pub-sub messaging system, part of the Apache Software Foundation";
    license = licenses.asl20;
    maintainers = with maintainers; [ samdroid-apps ];
    platforms = platforms.unix;
  };
}
