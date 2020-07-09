{ pkgs ? import <nixpkgs> {
    config = { allowBroken = true; };
  }
}:

with pkgs;

let
  python = python38Full;

  pelican_custom = import ./pelican.nix {};
in
{
  my_blog = stdenv.mkDerivation rec {
    name = "my-blog";
    src = fetchFromGitHub {
      owner = "ScorpionResponse";
      repo = "pelican_blog";
      rev = "master";
      sha256 = "06rnys66cqr5psb9v62hgbggx9q6nmaibm7a63d574b6yl0ndly3";
    };

    buildInputs = [ pelican_custom ];
    buildPhase = ''
      make html
    '';
    installPhase = ''
      cp -r output $out
    '';
    meta = {
      homepage = "https://scorpionresponse.com/";
      maintainers = [ "Paul Moss me@scorpionresponse.com" ];
      license = stdenv.lib.licenses.cc-by-sa-40;
    };
  };
}
