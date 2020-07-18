{ config, pkgs, ... }:

let
  blog = import ./pelican-blog.nix { pkgs = pkgs; };
in
{
  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedTlsSettings = true;

    # appendConfig = ''
    #  types_hash_max_size: 2048;
    # '';

    virtualHosts."scorpionresponse.com" = {
      locations."/".root = "${blog}";
      enableACME = true;
      forceSSL = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
