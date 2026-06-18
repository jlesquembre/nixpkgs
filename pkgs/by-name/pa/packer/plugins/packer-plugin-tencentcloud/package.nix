{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-tencentcloud";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-tencentcloud";
    tag = "v${finalAttrs.version}";
    hash = "sha256-WFbcHEWsuuAU++2xZYHJU/KiSSQRWXjS2fCED6ixpEs=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Tencent Cloud";
    homepage = "https://github.com/hashicorp/packer-plugin-tencentcloud";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
