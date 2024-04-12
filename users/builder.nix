{ config, pkgs, sshKeys, ... }:

{

  users.users.builder = {
    isNormalUser = true;
    createHome = false;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = [
     sshKeys.gryhsh
     sshKeys.fairydust
     sshKeys.twinkpad
    ];
  };

}