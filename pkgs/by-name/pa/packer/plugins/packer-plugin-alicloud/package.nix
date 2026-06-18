{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-alicloud";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-alicloud";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ycDGDgLdqCmq41/ApuRecQWSOz+W+QMVDp0f7pWVkPA=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Alicloud";
    homepage = "https://github.com/hashicorp/packer-plugin-alicloud";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
