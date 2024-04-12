{ config, pkgs, ... }:

{
  home.username = "polygon";
  home.homeDirectory = "/home/polygon";
  home.packages = with pkgs; [
    hugo
  ];
  home.stateVersion = "23.11";
}
