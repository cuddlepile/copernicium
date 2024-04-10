{ config, pkgs, ... }:
{
  zramSwap.enable = true;
  
  boot = {
    tmp.cleanOnBoot = true;
    initrd.systemd.enable = true;
  };

  powerManagement.cpuFreqGovernor = mkDefault "performance";


  networking = {
    hostName = "copernicium";
    domain = "";

    firewall.enable = true;
    nftables.enable = true;
    nftables.flushRuleset = false;
    useNetworkd = true;
    # disable useDHCP as it will dhcp on all interfaces
    useDHCP = false;
  };
  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "ens18";
      networkConfig.DHCP = "ipv4";
      address = [
        # replace this address with the one assigned to your instance
        "2a02:c207:2047:8280:0000:0000:0000:0001/64"
      ];
      routes = [
      { routeConfig.Gateway = "fe80::1"; }
      ];
    };
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false; # if we ever want to use swarm mode this is important
  };

  environment.systemPackages = with pkgs; [ neovim git tmux htop ];
  programs.zsh.enable = true;

  system.stateVersion = "23.11";
}