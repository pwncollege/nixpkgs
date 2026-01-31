{
  lib,
  bitstring,
  buildPythonPackage,
  buildPackages,
  cffi,
  fetchFromGitHub,
  pycparser,
  pythonOlder,
  # build-system
  scikit-build-core,
  cmake,
  ninja,
}:

buildPythonPackage rec {
  pname = "pyvex";
  version = "9.2.196";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "angr";
    repo = "pyvex";
    tag = "v${version}";
    hash = "sha256-DiH5pDU4BsHBqN1DVrXrpkOaXp7dZ3GTEdQpDIGYo04=";
    fetchSubmodules = true;
  };

  build-system = [
    scikit-build-core
    cmake
    ninja
    cffi
  ];

  dontUseCmakeConfigure = true;

  dependencies = [
    bitstring
    cffi
    pycparser
  ];

  depsBuildBuild = [ buildPackages.stdenv.cc ];

  # No tests are available on PyPI, GitHub release has tests
  # Switch to GitHub release after all angr parts are present
  doCheck = false;

  pythonImportsCheck = [ "pyvex" ];

  meta = {
    description = "Python interface to libVEX and VEX IR";
    homepage = "https://github.com/angr/pyvex";
    license = with lib.licenses; [
      bsd2
      gpl3Plus
      lgpl3Plus
    ];
    maintainers = with lib.maintainers; [ fab ];
  };
}
