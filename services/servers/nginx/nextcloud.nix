{ ... }:

{

  services.nginx.virtualHosts."cloud.gry.sh" = {
    serverName = "cloud.gry.sh";
    enableACME = true;
    addSSL = true;
    listen = [{ addr = "0.0.0.0"; port = 443; ssl = true; } { addr = "[::0]"; port = 443; ssl = true; } { addr = "[::0]"; port = 80; ssl = false; } { addr = "0.0.0.0"; port = 80; ssl = false; }];
    locations."/" = {
      recommendedProxySettings = true;
      proxyPass = "http://127.0.0.1:8080";
      proxyWebsockets = true;
    };
  };
}
