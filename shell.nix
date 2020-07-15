{ nixpkgs ? <nixpkgs>, system ? builtins.currentSystem }:

with (import nixpkgs { inherit system; }); stdenv.mkDerivation rec {
  name = "nixos-mailserver-env";

  env = buildEnv { name = name; paths = buildInputs; };

  buildInputs = with pkgs; [
    bind.dnsutils
    figlet
    jq
    nixops
  ];

  shellHook = ''
    figlet -w200 "Welcome, ScorpionResponse!"
    if [ -f ~/TODO ]; then
      cat ~/TODO
    fi
  '';
}
