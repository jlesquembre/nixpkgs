{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "istioctl";
  version = "1.3.0";
  # Values defined at
  # https://github.com/istio/istio/blob/master/bin/get_workspace_status.sh
  rev = "c2bd59595ce699b31d0f931885f023028ff7902b";

  src = fetchFromGitHub {
    owner = "istio";
    repo = "istio";
    rev = "${version}";
    sha256 = "1sqq7456ynyn1hm663d84l6jnigqypkrlpmmx4crhbqapn3hjani";
  };

  preBuild = ''
    export buildFlagsArray+=(
      "-ldflags=
        -extldflags -static -s -w
        -X istio.io/istio/vendor/istio.io/pkg/version.buildVersion=${version}
        -X istio.io/istio/vendor/istio.io/pkg/version.buildGitRevision=${rev}}")
  '';

  goPackagePath = "istio.io/istio";
  subPackages = [ "istioctl/cmd/istioctl" ];
  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Connect, secure, control, and observe services";
    homepage = https://istio.io/;
    license = licenses.asl20;
    maintainers = with maintainers; [ jlesquembre ];
    platforms = platforms.all;
  };
}
