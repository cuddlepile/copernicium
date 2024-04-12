{ ... }:

{

  services.nginx.virtualHosts."cloud.gry.sh" = {
    useACMEHost = "cloud.gry.sh";
    addSSL = true;
    acmeRoot = "/var/lib/acme/challenges-cloud";
    listen = [{ addr = "0.0.0.0"; port = 443; ssl = true; } { addr = "[::0]"; port = 443; ssl = true; }];
    locations."/" = {
      proxyPass = "http://127.0.0.1:8080";
      proxyWebsockets = true;
    };
  };

}
