{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-amazon";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-amazon";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Wq8Vs9Kuu8WRyt9OkfNnlWO0GDR8cejjBuZgAgKpLVM=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Amazon";
    homepage = "https://github.com/hashicorp/packer-plugin-amazon";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
