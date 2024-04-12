{ ... }:

{
  networking = {
    hostName = "copernicium";
    domain = "";

    firewall = {
      enable = true;
      trustedInterfaces = [ "docker0" "ens18" ];
    };
    nftables.enable = true;
    nftables.flushRuleset = false;
    useNetworkd = true;
    useDHCP = false;
  };

  systemd.network = {
    enable = true;
    networks."10-wan" = {
      matchConfig.Name = "ens18";
      address = [
        "173.212.230.176/32"
        "2a02:c207:2047:8280:0000:0000:0000:0001/64"
      ];
      routes = [
        { routeConfig.Gateway = "173.212.230.176"; }
        { routeConfig.Gateway = "fe80::1"; }
      ];
    };
  };

}
