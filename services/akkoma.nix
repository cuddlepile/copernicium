{...}:
{
  services.akkoma.enable = true;
  services.akkoma.config = {
   ":pleroma" = {
     "instance" = {
       name = "meow.";
       description = "it's just another cat on the internet :3";
       email = "polygon+akko@systemli.org";
       registration_open = false;
     };
     "Pleroma.Web.Endpoint" = {
       url.host = "akko.gaykitty.lol";
     };
   };
  };
  services.akkoma.nginx = {
    enableACME = true;
    forceSSL = true;
  };
}
