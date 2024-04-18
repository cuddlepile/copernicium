{
  description = "nix flake for copernicium";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { self
    , nixpkgsUnstable
    , nixpkgs
    , home-manager
    , ...
    } @ inputs:
    let hostPkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      # dev shell to deploy to the server
      devShell."x86_64-linux" = with hostPkgs;
        mkShell {
          buildInputs = [ colmena just ];
        };
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ ];
          };
          specialArgs = {
            inherit inputs nixpkgsUnstable;
            pkgsUnstable = import nixpkgsUnstable {
              system = "x86_64-linux";
              overlays = [ ];
            };
          };
        };

        copernicium =
          { name
          , nodes
          , pkgs
          , pkgsUnstable
          , inputs
          , ...
          }: {
            # you want to have a matching entry in your ssh config
            deployment = {
              targetHost = "grysh";
              targetUser = "builder";
              privilegeEscalationCommand = [
                "sudo"
                "--"
              ];
              buildOnTarget = true;

              keys."nextcloud-adminpass.secret" = {
                keyFile = ./secrets/nextcloud-adminpass.secret;
                user = "nextcloud";
                group = "nextcloud";
                destDir = "/etc/keys";
              };
              keys."radicale_users.secret" = {
                keyFile = ./secrets/radicale_users.secret;
                user = "radicale";
                group = "radicale";
                destDir = "/etc/keys";
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
    };
}
