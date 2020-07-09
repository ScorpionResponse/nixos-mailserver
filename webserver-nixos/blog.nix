{ config, pkgs, ... }:

let
  blog = import ./pelican-blog.nix { pkgs = pkgs; };

in
{
  blog = blog;
}
