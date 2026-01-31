{
  lib,
  stdenv,
  archinfo,
  buildPythonPackage,
  cargo,
  cachetools,
  capstone,
  cffi,
  claripy,
  cle,
  cxxheaderparser,
  fetchFromGitHub,
  gitpython,
  keystone-engine,
  lmdb,
  makeWrapper,
  msgspec,
  mulpyplexer,
  networkx,
  opentelemetry-api,
  pypcode,
  protobuf,
  psutil,
  pycparser,
  pyformlang,
  pydemumble,
  python,
  pythonOlder,
  pyvex,
  rich,
  rustPlatform,
  rustc,
  setuptools,
  setuptools-rust,
  sortedcontainers,
  sqlalchemy,
  sympy,
  typing-extensions,
  unicorn-angr,
  unique-log-filter,
}:

buildPythonPackage rec {
  pname = "angr";
  version = "9.2.196";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "angr";
    repo = "angr";
    tag = "v${version}";
    hash = "sha256-yE/JFsPn9mOESw1RJCECFEnxgh4flu99nJ8ggDGJsp8=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = "sha256-98DOl1POmqvKYHd490EOnEUSwzdUj8HGF78pD8scbPI=";
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    cargo
    rustc
    makeWrapper
  ];

  build-system = [
    setuptools
    setuptools-rust
    pyvex
  ];

  dependencies = [
    archinfo
    cachetools
    capstone
    cffi
    claripy
    cle
    cxxheaderparser
    gitpython
    lmdb
    msgspec
    mulpyplexer
    networkx
    pypcode
    protobuf
    psutil
    pycparser
    pyformlang
    pydemumble
    pyvex
    rich
    sortedcontainers
    sympy
    typing-extensions
    unique-log-filter
  ];

  pythonRelaxDeps = [
    "capstone"
  ];

  optional-dependencies = {
    angrdb = [ sqlalchemy ];
    keystone = [ keystone-engine ];
    telemetry = [ opentelemetry-api ];
    unicorn = [ unicorn-angr ];
  };

  setupPyBuildFlags = lib.optionals stdenv.hostPlatform.isLinux [
    "--plat-name"
    "linux"
  ];

  postFixup = ''
    wrapProgram $out/bin/angr \
      --set PYTHONPATH "${python.pkgs.makePythonPath dependencies}:$out/${python.sitePackages}"
  '';

  # Tests have additional requirements, e.g., pypcode and angr binaries
  # cle is executing the tests with the angr binaries
  doCheck = false;

  pythonImportsCheck = [
    "angr"
    "claripy"
    "cle"
    "pyvex"
    "archinfo"
  ];

  meta = {
    description = "Powerful and user-friendly binary analysis platform";
    homepage = "https://angr.io/";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ fab ];
  };
}
