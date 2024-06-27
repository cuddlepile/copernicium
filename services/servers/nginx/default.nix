{ ... }:

{
  users.users.nginx.extraGroups = [ "acme" ];
  services.nginx.enable = true;
  security.acme = {
    acceptTerms = true;
    defaults.email = "security@vollpfosten.party";
  };

  imports = [
  ];

}
