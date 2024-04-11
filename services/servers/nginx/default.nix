{...}:

{
  imports = [
    ./nextcloud.nix
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
  };
}