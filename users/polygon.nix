{ sshKeys, pkgs, ... }:


{

  users.users.polygon = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    initialPassword = "changeme123!";
    shell = pkgs.zsh;
    createHome = true;
    openssh.authorizedKeys.keys = [
      sshKeys.fairydust
      sshKeys.twinkpad
    ];
  };

}