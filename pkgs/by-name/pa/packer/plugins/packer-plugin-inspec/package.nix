{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-inspec";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-inspec";
    tag = "v${finalAttrs.version}";
    hash = "sha256-XUzPdKAJQa/hXKlQ66+k+X1bAki3yb1GFBRS6NY/dWU=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for InSpec";
    homepage = "https://github.com/hashicorp/packer-plugin-inspec";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
