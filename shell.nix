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
    export PS1="\n\[\033[1;32m\][nix-shell:\[\033[01;34m\]\w\[\033[1;32m\]]\[\033[0m\]\[\033[36m\]`__git_ps1`\[\033[0m\]\$ "
    figlet -w200 "Welcome, ScorpionResponse!"
    if [ -f ~/TODO ]; then
      cat ~/TODO
    fi
  '';
}
