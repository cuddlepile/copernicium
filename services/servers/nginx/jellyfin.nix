{ config, pkgs, ... }:

{

  services.nginx.virtualHosts."media.gaykitty.lol" = {
    useACMEHost = "media.gaykitty.lol";
    addSSL = true;
    acmeRoot = "/var/lib/acme/challenges-jellyfin";
    listen = [ { addr = "0.0.0.0"; port = 443; ssl = true;} { addr = "[::0]"; port = 443; ssl = true;} ];
    locations."/" = {
      proxyPass = "http://127.0.0.1:8096";
      proxyWebsockets = true;
    };
  };

}