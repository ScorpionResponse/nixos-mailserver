{ config, pkgs, ... }:

with pkgs;

let
  phpPackages = php74Packages;

in
{
  services.roundcube = {
    enable = true;
    hostName = "webmail.scorpionresponse.email";

    extraConfig = ''
      $config['archive_type'] = 'year';
      $config['skin'] = 'elastic';
    '';

    plugins = [
      "archive"
      "attachment_reminder"
      "emoticons"
      "help"
      "managesieve"
      "password"
      "zipdownload"
    ];
  };

  services.nginx.virtualHosts."webmail.scorpionresponse.email" = {
    locations."/".root = "${services.roundcube}";
    enableACME = false;
    forceSSL = false;
  };
}
