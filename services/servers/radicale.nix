{...}:

{

services.radicale = {
  enable = true;
  settings = {
    server.hosts = [ "0.0.0.0:5232" ];
    auth = {
      type = "htpasswd";
      htpasswd_filename = "/etc/secrets/radicale_users";
      htpasswd_encryption = "bcrypt";
    };
  };
};

}