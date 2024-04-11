{config, pkgs, ... }:
{
users.users.root = {
  openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJa7SNW7HhplKe95r9i4hyf9Sf/wUgOsYlQtqVhR8hNE polygon"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWXLbHGz3IZ9bqO0x/xct2SG3aVL0EFcqDrU8A7tll8 polygon"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGtY0VATETxBhp7DU5iXqXMEDjsvE05nF+j+5qmPz11 gryhsh"
  ];
};
};