{ config, pkgs, ... }:

{

  services.nginx.virtualHosts."cloud.gry.sh" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8080";
      proxyWebsockets = true;
    };
  };

}