{ config, pkgs, ... }:

with pkgs;

let
  phpPackages = php74Packages;

in
{
  services.roundcube = {
    enable = true;
    hostName = "webmail.scorpionresponse.email";
    package = pkgs.roundcube.withPlugins (plugins: [ plugins.persistent_login ]);

    extraConfig = ''
      $config['db_dsnw'] = 'pgsql://roundcube@localhost/roundcube';
      $config['archive_type'] = 'year';
      $config['skin'] = 'elastic';

      $config['default_host'] = 'mail.scorpionresponse.email';
      $config['smtp_server'] = 'tls://%h';
      $config['smtp_user'] = '%u';
      $config['smtp_pass'] = '%p';

      $config['identities_level'] = 0;
    '';

    plugins = [
      "archive"
      "attachment_reminder"
      "emoticons"
      "help"
      "managesieve"
      "password"
      "persistent_login"
      "zipdownload"
    ];
  };

  services.nginx.virtualHosts."webmail.scorpionresponse.email" = {
    enableACME = true;
    forceSSL = true;
  };
}
