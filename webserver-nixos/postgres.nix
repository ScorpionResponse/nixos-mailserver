{ config, pkgs, ... }:

let
  databases = [ "roundcube" ];

  makePerms = dbs: map (
    x: {
      name = x;
      ensurePermissions = {
        "DATABASE ${x}" = "ALL PRIVILEGES";
      };
    }
  ) dbs;

  superuserPerms = [
    {
      name = "superuser";
      ensurePermissions = {
        "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
      };
    }
  ];
in

{
  services.postgresql = {
    enable = true;
    enableTCPIP = false;
    package = pkgs.postgresql_12;
    dataDir = "/var/lib/postgresql/12";
    authentication = ''
      local all all peer
      host all all ::1/128 trust
    '';
    ensureDatabases = databases;
    ensureUsers = makePerms databases ++ superuserPerms;
  };
}
