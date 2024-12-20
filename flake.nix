{
  description = "Contains all depedencies to write, compile, and run Fragment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    , rust-overlay
    , ...
    } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        libPath = with pkgs; lib.makeLibraryPath [
          libGL
          libxkbcommon
          wayland
        ];
      in
      {
        devShells.default = pkgs.mkShell rec {
          buildInputs = with pkgs; [
            pre-commit
            rust-analyzer
            rust-bin.stable.latest.default
          ];
          nativeBuildInputs = with pkgs; [];
          LD_LIBRARY_PATH = libPath;
        };
      }
    );
}
