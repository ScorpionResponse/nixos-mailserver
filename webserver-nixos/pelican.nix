{ pkgs ? import <nixpkgs> {
    config = { allowBroken = true; };
  }
}:

with pkgs.python38Full.pkgs;

pelican.overridePythonAttrs (
  old: rec {
    doCheck = false;
  }
)
