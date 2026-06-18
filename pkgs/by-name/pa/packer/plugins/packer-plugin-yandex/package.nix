{
  lib,
  mkPackerPlugin,
  fetchFromGitHub,
}:

mkPackerPlugin (finalAttrs: {

  pname = "packer-plugin-yandex";
  version = "1.1.3";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "packer-plugin-yandex";
    tag = "v${finalAttrs.version}";
    hash = "sha256-MM4GgXiUQMSch1oZfFLE9UHotVOFFvdaSA+QLBPV6ao=";
  };

  vendorHash = lib.fakeHash;

  meta = {
    description = "Packer plugin for Yandex Cloud";
    homepage = "https://github.com/hashicorp/packer-plugin-yandex";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
  };
})
