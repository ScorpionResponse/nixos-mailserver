{ config, pkgs, ... }:

{
  services.postfix.submissionOptions.smtpd_sender_restrictions = "reject_unauthenticated_sender_login_mismatch";
}
