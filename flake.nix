{
  description = "mtkclient flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  inputs.nixpkgs2211.url = "github:nixos/nixpkgs";

  outputs = { self, nixpkgs, nixpkgs2211, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs2211 = nixpkgs2211.legacyPackages.${system};
    in
    {
      packages.${system}.default = pkgs.callPackage ./default.nix { fmt = pkgs2211.fmt_7; };
    };
}
