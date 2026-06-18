{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-oracle";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-oracle";
    tag = "v${finalAttrs.version}";
    hash = "sha256-wSJ+gFS3DDTi77/zRMyficw0xjdOrKMyrcH9lG/RnD0=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Oracle Cloud";
    homepage = "https://github.com/hashicorp/packer-plugin-oracle";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
