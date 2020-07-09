{ config, pkgs, ... }:

let
  blog = import ./blog.nix;
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

  # networking.firewall.allowedTCPPorts = [ 80 443 ];
}
