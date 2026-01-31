{
  lib,
  backports-strenum,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "archinfo";
  version = "9.2.196";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "angr";
    repo = "archinfo";
    tag = "v${version}";
    hash = "sha256-k6pfQmGvOKrtQ6HLwY8+6yCK7N8yzH0aD/GWix/9VBM=";
  };

  build-system = [ setuptools ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "archinfo" ];

  meta = {
    description = "Classes with architecture-specific information";
    homepage = "https://github.com/angr/archinfo";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ fab ];
  };
}
