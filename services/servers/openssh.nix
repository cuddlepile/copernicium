{ ... }:

{
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    openFirewall = true;
  };
}
