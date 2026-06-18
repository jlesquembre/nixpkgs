{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-puppet";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-puppet";
    tag = "v${finalAttrs.version}";
    hash = "sha256-qwLq9OVrSyGQdFGhYgzO1x0B7lTVTnDv24wvo1OLlMs=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Puppet";
    homepage = "https://github.com/hashicorp/packer-plugin-puppet";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
