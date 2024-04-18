{...}:

{
  services.nginx.virtualHosts."cal.gaykitty.lol" = {
    enableACME = true;
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:5232";
    };
  };
}