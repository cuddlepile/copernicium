{...}:

{
  imports = [
    ./nextcloud.nix
  ];

  services.nginx.enable = true;
  security.acme = {
    acceptTerms = true;
    defaults.email = "polygon+acme@systemli.org";
  }:
}