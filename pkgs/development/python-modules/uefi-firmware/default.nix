{
  lib,
  buildPythonPackage,
  fetchPypi,
}:

buildPythonPackage rec {
  pname = "uefi-firmware";
  version = "1.11";
  format = "setuptools";

  src = fetchPypi {
    pname = "uefi_firmware";
    inherit version;
    hash = "sha256-MOKp0TisFgi9/BeDqTaTHrb0KScjkZ8dssFQnsGKYEE=";
  };

  # "future" is only needed for Python 2 compatibility; on Python 3 it is unused.
  pythonRemoveDeps = [ "future" ];

  doCheck = false;

  pythonImportsCheck = [ "uefi_firmware" ];

  meta = {
    description = "Data structures and parsing tools for UEFI firmware";
    homepage = "https://github.com/theopolis/uefi-firmware-parser";
    license = lib.licenses.bsd3;
  };
}
