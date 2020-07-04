let
  secrets = import ./secrets.nix;
in
{
  network = {
    description = "Mailserver for scorpionresponse.email";
    enableRollback = true;
  };

  mailserver =
    { config, pkgs, ... }:
    {
      deployment = {
        targetHost = "mail.scorpionresponse.email";
        # targetUser = "paul"; # TODO: Not available yet.  Next nixops release
      };

      imports =
        [ # Include configuration.nix
          ./mailserver-nixos/configuration.nix
          (builtins.fetchTarball {
            url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/289f71efe2250e1155b0c74d188699397ba641d8/nixos-mailserver-289f71efe2250e1155b0c74d188699397ba641d8.tar.gz";
            sha256 = "0lpz08qviccvpfws2nm83n7m2r8add2wvfg9bljx9yxx8107r919";
          })
        ];

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [
          25 465 587 #SMTP
          143 993 # IMAP
        ];
      };

      mailserver = {
        enable = true;
        fqdn = "mail.scorpionresponse.email";
        domains = [
          "evaleone.com"
          "fakeendaround.com"
          "feelfreepodcast.com"
          "freelancefinder.work"
          "justfeelfreepodcast.com"
          "scorpionresponse.com"
          "scorpionresponse.email"
          "scorpionresponse.me"
          "scorpionresponse.ninja"
          "scorpionresponse.online"
          "scorpionresponse.space"
          "scorpionresponse.website"
          "scorpionresponse.work"
          "scorpionresponse.zone"
          "sickassdragons.com"
          "sociallist.us"
        ];
        loginAccounts = {
          "moss.paul@scorpionresponse.email" = {
            hashedPassword = secrets.mailserver.loginAccounts."moss.paul@scorpionresponse.email".hashedPassword;

            aliases = [
              "info@scorpionresponse.email"
              "postmaster@scorpionresponse.email"
            ];

            catchAll = [
              "scorpionresponse.com"
              "scorpionresponse.email"
              "scorpionresponse.ninja"
              "scorpionresponse.online"
              "scorpionresponse.space"
              "scorpionresponse.website"
              "scorpionresponse.work"
              "scorpionresponse.zone"
              "sickassdragons.com"
              "sociallist.us"
            ];
          };
          "me@scorpionresponse.me" = {
            hashedPassword = secrets.mailserver.loginAccounts."me@scorpionresponse.me".hashedPassword;

            catchAll = [
              "scorpionresponse.me"
            ];
          };
          "me@freelancefinder.work" = {
            hashedPassword = secrets.mailserver.loginAccounts."me@freelancefinder.work".hashedPassword;

            catchAll = [
              "freelancefinder.work"
            ];
          };
          "me@fakeendaround.com" = {
            hashedPassword = secrets.mailserver.loginAccounts."me@fakeendaround.com".hashedPassword;

            catchAll = [
              "fakeendaround.com"
            ];
          };
          "alicia@evaleone.com" = {
            hashedPassword = secrets.mailserver.loginAccounts."alicia@evaleone.com".hashedPassword;

            catchAll = [
              "evaleone.com"
              "feelfreepodcast.com"
              "justfeelfreepodcast.com"
            ];
          };
        };

        certificateScheme = 3;

        enableImap = true;
        enableImapSsl = true;

        virusScanning = true;
      };

    };
}
