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
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rust-analyzer
            rust-bin.stable.latest.default
          ];
          nativeBuildInputs = with pkgs; [];
        };
      }
    );
}
