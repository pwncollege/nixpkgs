{
  lib,
  buildPythonPackage,
  cmake,
  fetchPypi,
  nanobind,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pypcode";
  version = "3.3.3";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-N4uNOxVSwyUSQ7QhEU3WfMtJZg/nYsYPsZ3t4Sec8ww=";
  };

  build-system = [
    setuptools
    nanobind
  ];

  nativeBuildInputs = [
    cmake
  ];

  dontUseCmakeConfigure = true;

  doCheck = false;

  pythonImportsCheck = [ "pypcode" ];

  meta = {
    description = "Machine code disassembly and IR translation library";
    homepage = "https://api.angr.io/projects/pypcode/en/latest/";
    license = lib.licenses.bsd3;
  };
}
