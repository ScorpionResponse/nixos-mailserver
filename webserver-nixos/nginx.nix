{ config, pkgs, ... }:

let
  blog = import ./pelican-blog.nix { pkgs = pkgs; };
in
{
  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."scorpionresponse.com" = {
      locations."/".root = "${blog}";
      enableACME = true;
      forceSSL = true;

      serverAliases = [ "www.scorpionresponse.com" ];

      extraConfig = ''
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

        # Enable CSP for your services.
        add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

        # Minimize information leaked to other domains
        add_header 'Referrer-Policy' 'origin-when-cross-origin';

        # Disable embedding as a frame
        add_header X-Frame-Options DENY;

        # Prevent injection of code in other mime types (XSS Attacks)
        add_header X-Content-Type-Options nosniff;

        # Enable XSS protection of the browser.
        # May be unnecessary when CSP is configured properly (see above)
        add_header X-XSS-Protection "1; mode=block";

        # Never expose this
        proxy_hide_header X-Powered-By;
        add_header X-Powered-By Pelican;
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
