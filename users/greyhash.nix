{ config, pkgs, ... }:


{

  users.users.greyhash = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    createHome = true;
    openssh.authorizedKeys.keys = [
     "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGtY0VATETxBhp7DU5iXqXMEDjsvE05nF+j+5qmPz11 gryhsh"
    ];
  };

}