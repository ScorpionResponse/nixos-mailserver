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

      $config['default_host'] = 'tls://mail.scorpionresponse.email';
      $config['default_port'] = 143;
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

    extraConfig = ''
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

      # Enable CSP for your services.
      add_header Content-Security-Policy "script-src 'self' 'unsafe-inline' 'unsafe-eval'; object-src 'none'; base-uri 'none';" always;

      # Prevent injection of code in other mime types (XSS Attacks)
      add_header X-Content-Type-Options nosniff;

      # Enable XSS protection of the browser.
      # May be unnecessary when CSP is configured properly (see above)
      add_header X-XSS-Protection "1; mode=block";

      # Never expose this
      proxy_hide_header x-powered-by;
      add_header X-Powered-By Roundcube;
    '';
  };

  networking.extraHosts = ''
    45.79.225.181 mail.scorpionresponse.email
  '';
}
