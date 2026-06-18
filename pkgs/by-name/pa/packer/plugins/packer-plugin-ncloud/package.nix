{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-ncloud";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-ncloud";
    tag = "v${finalAttrs.version}";
    hash = "sha256-y/eagxmVLBi4JviWHRsJmDcCR2droP6Eoo4Z8JiLfUc=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Naver Cloud";
    homepage = "https://github.com/hashicorp/packer-plugin-ncloud";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
