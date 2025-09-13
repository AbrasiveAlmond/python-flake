{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

      in
      with pkgs;
      {
        devShells.default = mkShell {
          packages = [
            (pkgs.python3.withPackages (python-pkgs: [
              python-pkgs.numpy
              python-pkgs.matplotlib
              python-pkgs.uv
              python-pkgs.uv-build
              python-pkgs.ruff
            ]))
            pkgs.ty
          ];
        };
      }
    );
}
