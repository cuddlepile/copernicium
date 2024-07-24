{ ... }: {
  imports = [
    ./openssh.nix
    ./mailserver.nix
    ./nginx
    ./nextcloud.nix
  ];
}
