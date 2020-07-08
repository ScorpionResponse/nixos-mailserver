{ pkgs ? import <nixpkgs> {
    config = { allowBroken = true; };
  }
}:

with pkgs;

let
  python = python38Full;

in
{
  pelican_custom = with python.pkgs; pelican.overridePythonAttrs (
    old: rec {
      doCheck = false;
    }
  );
}
