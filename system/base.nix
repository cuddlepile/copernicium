{ config, pkgs, ... }:
{
  zramSwap.enable = true;
  
  boot = {
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    kernel.sysctl."net.ipv6.conf.all.forwarding" = "1";
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false; # if we ever want to use swarm mode this is important
    daemon.settings = {
      fixed-cidr-v6 = "fd00::/80";
      ipv6 = false;
      dns = ["8.8.8.8"];
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [ neovim git tmux htop ];
  programs.zsh.enable = true;

  system.stateVersion = "23.11";
}