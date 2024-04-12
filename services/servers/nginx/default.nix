{ ... }:

{
  imports = [
    ./nextcloud.nix
    ./jellyfin.nix
  ];

  users.users.nginx.extraGroups = [ "acme" ];
  services.nginx.enable = true;
  security.acme = {
    acceptTerms = true;
    defaults.email = "security@vollpfosten.party";
    defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    certs."cloud.gry.sh" = {
      webroot = "/var/lib/acme/challenges-cloud";
      group = "nginx";
    };
    certs."media.gaykitty.lol" = {
      webroot = "/var/lib/acme/challenges-jellyfin";
      group = "nginx";
    };
  };
}
