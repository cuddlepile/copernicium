{ config, pkgs, ... }:
{
  zramSwap.enable = true;

  boot = {
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    kernel.sysctl."net.ipv6.conf.all.forwarding" = "1";
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [ neovim git tmux htop ];
  programs.zsh.enable = true;

  system.stateVersion = "23.11";
}
