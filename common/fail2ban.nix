{ config, pkgs, ... }:

with pkgs;

{
  services.fail2ban = {
    enable = true;
    ignoreIP = [ "mailserver.scorpionresponse.website" "webserver.scorpionresponse.website" ];
  };
}
