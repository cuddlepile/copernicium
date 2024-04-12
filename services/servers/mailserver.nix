{ inputs, ... }: {
  imports = [ inputs.simple-nixos-mailserver.nixosModule ];

  mailserver = {
    enable = true;
    fqdn = "mail.vollpfosten.party";
    domains = [ "vollpfosten.party" "gry.sh" ];

    # A list of all login accounts. To create the password hashes, use
    # nix-shell -p mkpasswd --run 'mkpasswd -sm bcrypt'
    loginAccounts = {
      "greyhash@vollpfosten.party" = {
        hashedPasswordFile = "/secrets/mail/vollpfosten_party_greyhash";
      };

      "catchall@vollpfosten.party" = {
        hashedPasswordFile = "/secrets/mail/vollpfosten_party_catchall";
        aliases = [ "@vollpfosten.party" ];
      };
      "me@gry.sh" = {
        hashedPasswordFile = "/secrets/mail/gry_sh_me";
        aliases = [ "greyhash@gry.sh" ];
      };

      "catchall@gry.sh" = {
        hashedPasswordFile = "/secrets/mail/gry_sh_catchall";
        aliases = [ "@gry.sh" ];
      };
    };

    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    certificateScheme = "acme-nginx";
    openFirewall = true;
  };
}
