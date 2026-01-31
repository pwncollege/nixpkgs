{
  lib,
  buildPythonPackage,
  fetchurl,
  fetchPypi,
  pythonOlder,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pyxdia";
  version = "0.1.0";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-r5XRznBAfnoPctArp302bA37DtWPszb4clrI80k7fmg=";
  };

  xdiaZip = fetchurl {
    url = "https://github.com/mborgerson/xdia/releases/download/v${version}/xdia.zip";
    hash = "sha256-rtKcSZoL8OUo2l1B/WJYACIu+DFEqahfTvbjeNsmq8s=";
  };

  xdialdrTar = fetchurl {
    url = "https://github.com/mborgerson/xdia/releases/download/v${version}/xdialdr.tar.xz";
    hash = "sha256-rXL7uVl+TJYYhKrqzkF7YK0nZ+rwSnGKsTyxAN/mlYQ=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail 'f"{xdia_release_url}/v{version}/xdia.zip"' '"file://${xdiaZip}"' \
      --replace-fail 'f"{xdia_release_url}/v{version}/xdialdr.tar.xz"' '"file://${xdialdrTar}"'
  '';

  build-system = [
    setuptools
  ];

  pythonImportsCheck = [ "pyxdia" ];

  meta = {
    description = "Extract useful program information from PDB files";
    homepage = "https://github.com/mborgerson/xdia";
    license = lib.licenses.mit;
  };
}
