{ pkgs, sshKeys, ... }:


{

  users.users.greyhash = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    initialPassword = "changeme123!";
    shell = pkgs.zsh;
    createHome = true;
    openssh.authorizedKeys.keys = [
     sshKeys.gryhsh
    ];
  };

}