{ config, pkgs, ... }:

let 
  secrets = import ./secrets.nix;
in
{
  imports = [
    (builtins.fetchTarball {
      url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/289f71efe2250e1155b0c74d188699397ba641d8/nixos-mailserver-289f71efe2250e1155b0c74d188699397ba641d8.tar.gz";
      sha256 = "0lpz08qviccvpfws2nm83n7m2r8add2wvfg9bljx9yxx8107r919";
    })
  ];

  mailserver = {
    enable = true;
    fqdn = "mail.scorpionresponse.email";
    domains = [ 
      "evaleone.com" 
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
              "scorpionresponse.me"
              "sickassdragons.com"
            ];
        };
    };

    certificateScheme = 3;

    enableImap = true;
    enableImapSsl = true;

    virusScanning = true;
  };
}

