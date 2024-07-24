{ lib, pkgs, config, ... }:

let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
  {
    
    services.nginx.virtualHosts.${srv.DOMAIN} = {
      forceSSL = true;
      enableACME = true;
      extraConfig = ''
        client_max_body_size 1024M;
      '';
      locations."/".proxyPass = "http://localhost:${toString srv.HTTP_PORT}";
    };

    services.forgejo = {
      enable = true;
      database.type = "postgres";
      lfs.enable = true;
      settings = {
        server = {
	  DOMAIN = "git.gaykitty.lol";
	  ROOT_URL = "https://${srv.DOMAIN}/";
	  HTTP_PORT = 3000;
	};
	service.DISABLE_REGISTRATION = true;
      };
    };

  }

