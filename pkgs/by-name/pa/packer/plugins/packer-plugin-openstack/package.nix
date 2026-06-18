{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-openstack";
  version = "1.1.3";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-openstack";
    tag = "v${finalAttrs.version}";
    hash = "sha256-+QcEsp8yDfEdjWnu3CYiNU12ZvLtRgBX0pW6k7MRSgc=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for OpenStack";
    homepage = "https://github.com/hashicorp/packer-plugin-openstack";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
