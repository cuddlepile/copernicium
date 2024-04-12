{ ... }:
{

  virtualisation.docker = {
    enable = true;
    liveRestore = false; # if we ever want to use swarm mode this is important
    daemon.settings = {
      fixed-cidr-v6 = "fd00::/80";
      ipv6 = false;
      dns = [ "8.8.8.8" ];
    };
  };


}

