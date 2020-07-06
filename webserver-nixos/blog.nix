{ config, pkgs, ... }:

let

  fetchGitHashless = args: stdenv.lib.overrideDerivation
    # Use a dummy hash, to appease fetchgit's assertions
    (fetchgit (args // { sha256 = hashString "sha256" args.url; }))

    # Remove the hash-checking
    (
      old: {
        outputHash = null;
        outputHashAlgo = null;
        outputHashMode = null;
        sha256 = null;
      }
    );

  blog = import ./pelican-blog.nix { nixpkgs = pkgs; };

in
{
  blog = blog;
}
