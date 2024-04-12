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
# could do this with systemd-networkd
  networking.wg-quick.interfaces = {
    wg0 = {
      privateKey = "0Em455d9O9EzQxcoevQdeb0MSzzsYebbUyJ1sZOymFg=";
      address = ["10.66.184.231/32" "fc00:bbbb:bbbb:bb01::3:b8e6/128"];
      dns = [ "10.64.0.1" ];

      peers = [
        {
          publicKey = "zfNQqDyPmSUY8+20wxACe/wpk4Q5jpZm5iBqjXj2hk8=";
          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
          endpoint = "138.199.6.233:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };

}
