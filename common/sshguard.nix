{ config, lib, pkgs, ... }:

{
  services.sshguard = rec {
    enable = true;
    services = with lib; with config.services; []
    ++ (optional openssh.enable "sshd")
    ++ (optional dovecot2.enable "dovecot2")
    ++ (optional postfix.enable "postfix")
    ;
    blacklist_threshold = 120;
    blocktime = 600;
    whitelist = [ "mailserver.scorpionresponse.website" "webserver.scorpionresponse.website" ];
  };
}
