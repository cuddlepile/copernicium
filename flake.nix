{
  description = "nix flake for copernicium";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-23.11";
  };
  outputs = {
    self,
    nixpkgsUnstable,
    nixpkgs,
    ...
  } @ inputs: let hostPkgs = import nixpkgs {system = "x86_64-linux";};
  in {
    # dev shell to deploy to the server
    devShell."x86_64-linux" = with hostPkgs;
      mkShell {
        buildInputs = [colmena];
      };
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [];
          };
          specialArgs = {
            inherit inputs nixpkgsUnstable; 
            pkgsUnstable = import nixpkgsUnstable {
              system = "x86_64-linux";
              overlays = [];
            };
          };
        };

        copernicium = {
          name,
          nodes,
          pkgs,
          pkgsUnstable,
          inputs,
          ...
        }: {
          # you want to have a matching entry in your ssh config
          deployment = {
            targetHost = "grysh";
            buildOnTarget = true;
          };
          imports = [
            ./hardware-configuration.nix
            ./base.nix
            ./services
            ./users
          ];
        };
      };
    };
    }