{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-sdk";
  version = "0.6.9";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-sdk";
    tag = "v${finalAttrs.version}";
    hash = "sha256-shbo6S45EVH2z/yfTlUdKmzAP5udV5i6zzWmf8dM6Ds=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for the Packer SDK";
    homepage = "https://github.com/hashicorp/packer-plugin-sdk";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
