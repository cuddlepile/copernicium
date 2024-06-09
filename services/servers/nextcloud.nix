{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    webfinger = true;
    hostName = "cloud.gry.sh";
    package = pkgs.nextcloud28;
    config.adminpassFile = "/etc/keys/nextcloud-adminpass.secret";
    database.createLocally = true;
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    enableACME = true;
    forceSSL = true;
  };
}
