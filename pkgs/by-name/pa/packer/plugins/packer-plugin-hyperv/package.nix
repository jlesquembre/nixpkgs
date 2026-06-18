{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-hyperv";
  version = "1.1.5";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-hyperv";
    tag = "v${finalAttrs.version}";
    hash = "sha256-dxwbsdNvzJcqQa2B9cEXwFq3IUIAEeWjoklAKyii64I=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Hyper-V";
    homepage = "https://github.com/hashicorp/packer-plugin-hyperv";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
