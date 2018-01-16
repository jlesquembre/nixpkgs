{ mkDerivation, fetchgit, aeson, aeson-pretty, base, bytestring, directory
, filepath, hspec, hspec-core, HUnit, mtl, optparse-applicative
, parsec, process, pureMD5, QuickCheck, shelly, stdenv, text
, transformers, unix
}:
mkDerivation {
  pname = "super-user-spark";
  version = "0.4.0.0-dev";
  src = fetchgit {
    url = "https://github.com/NorfairKing/super-user-spark";
    sha256 = "0b7x4nz4d78rc49xjccmafnw9mcss8fd2kv92s93r8c5awsdngy4";
    rev = "be7625dcaa76e38ccbca37b59ff473d3b4bbf6d7";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson aeson-pretty base bytestring directory filepath mtl
    optparse-applicative parsec process pureMD5 shelly text
    transformers unix
  ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [
    aeson aeson-pretty base bytestring directory filepath hspec
    hspec-core HUnit mtl optparse-applicative parsec process pureMD5
    QuickCheck shelly text transformers unix
  ];
  jailbreak = true;
  description = "Configure your dotfile deployment with a DSL";
  license = stdenv.lib.licenses.mit;
  homepage = https://github.com/NorfairKing/super-user-spark;
  maintainers = [ stdenv.lib.maintainers.badi ];
}
