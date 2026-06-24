{
  lib,
  python3Packages,
  fetchPypi,
  nix-update-script,
  versionCheckHook,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "c7n";
  version = "0.9.51";

  format = "wheel";
  __structuredAttrs = true;

  src = fetchPypi {
    inherit (finalAttrs) pname version;
    hash = "sha256-AxbsOBP8ctSMZIfKEsrxzYVCeZ68+NA1SKKXtxC+a4g=";
    dist = "py3";
    python = "py3";
    format = "wheel";
  };

  # Wheel pins exact dependency versions; allow newer ones
  dontCheckRuntimeDeps = true;

  dependencies = with python3Packages; [
    argcomplete
    boto3
    cryptography
    jsonschema
    python-dateutil
    pyyaml
    tabulate
    urllib3

  ];

  pythonImportsCheck = [
    "c7n"
  ];

  nativeInstallCheckInputs = [ versionCheckHook ];
  versionCheckProgramArg = "version";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Cloud Custodian - Policy Rules Engine";
    homepage = "https://cloudcustodian.io";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ jlesquembre ];
    mainProgram = "custodian";
  };
})
