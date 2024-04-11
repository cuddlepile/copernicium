{sshKeys, ... }:
{
users.users.root = {
  openssh.authorizedKeys.keys = [
     sshKeys.gryhsh
     sshKeys.fairydust
     sshKeys.twinkpad
  ];
};
}