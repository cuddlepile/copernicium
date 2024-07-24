{
  description = "nix flake for copernicium";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixpkgsUnstable, home-manager, ... } @ inputs: 
    let 
      system = "x86_64-linux";
      hostPkgs = import nixpkgs { inherit system; };
      unstablePkgs = import nixpkgsUnstable { inherit system; };
    in {
      formatter.${system} = hostPkgs.legacyPackages.${system}.nixpkgs-fmt;

      # Development shell to deploy to the server
      devShell.${system} = with hostPkgs; mkShell {
        buildInputs = [ colmena just ];
      };

      colmena = {
        meta = {
          nixpkgs = hostPkgs;
          specialArgs = {
            inherit inputs;
            pkgsUnstable = unstablePkgs;
          };
        };

        copernicium = { name, nodes, pkgs, pkgsUnstable, inputs, ... }: {
          # Ensure a matching entry in your SSH config
          deployment = {
            targetHost = "grysh";
            targetUser = "builder";
            privilegeEscalationCommand = [ "sudo" "--" ];
            buildOnTarget = true;

            keys = {
              "nextcloud-adminpass.secret" = {
                keyFile = ./secrets/nextcloud-adminpass.secret;
                user = "nextcloud";
                group = "nextcloud";
                destDir = "/etc/keys";
              };
	      };


            };
          };

          imports = [
            ./system
            ./services
            ./users
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.polygon = import ./home/polygon/home.nix;
            }
          ];
        };
      };
}
