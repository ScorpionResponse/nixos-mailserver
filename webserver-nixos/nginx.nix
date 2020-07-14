{ config, pkgs, ... }:

let
  blog = import ./pelican-blog.nix { pkgs = pkgs; };
in
{
  services.nginx = {
    enable = true;
    virtualHosts."scorpionresponse.com" = {
      locations."/".root = "${blog}";
      enableACME = true;
      forceSSL = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
