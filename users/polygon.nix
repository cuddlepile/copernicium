{ config, pkgs, ... }:


{

  users.users.polygon = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    initialPassword = "changeme123!";
    shell = pkgs.zsh;
    createHome = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJa7SNW7HhplKe95r9i4hyf9Sf/wUgOsYlQtqVhR8hNE polygon"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWXLbHGz3IZ9bqO0x/xct2SG3aVL0EFcqDrU8A7tll8 polygon"
    ];
  };

}