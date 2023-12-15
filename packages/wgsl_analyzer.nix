{ fetchFromGitHub, rustPlatform }:

let
  wgsl-analyzer-src = fetchFromGitHub {
    owner = "wgsl-analyzer";
    repo = "wgsl-analyzer";
    rev = "v0.8.1";
    sha256 = "sha256-bhosTihbW89vkqp1ua0C1HGLJJdCNfRde98z4+IjkOc=";
  };
in

rustPlatform.buildRustPackage {
  pname = "wgsl-analyzer";
  version = "v0.8.1";

  src = wgsl-analyzer-src;
  doCheck = false;

  cargoLock = {
    lockFile = wgsl-analyzer-src + "/Cargo.lock";
    allowBuiltinFetchGit = true;
  };
}
