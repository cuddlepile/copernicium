{ ... }: {
  imports = [
    ./openssh.nix
    ./mailserver.nix
    ./nginx
    ./jellyfin.nix
  ];
}