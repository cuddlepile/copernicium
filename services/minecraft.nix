{pkgs, ...}: 

{
  services.minecraft-server = {
    enable = false;
    declarative = true;
    eula = true;
    package = pkgs.papermc;
    openFirewall = true;
    serverProperties = {
      max-players = 15;
      motd = "woem";
      enable-rcon = true;
      "rcon.password" = "HQy3dqVurz3pLjmI"; 
      "rcon.port" = 25575;
    };
  };
}
