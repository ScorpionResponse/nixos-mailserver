{ pkgs ? import <nixpkgs> {
    config = { allowBroken = true; };
  }
}:

with pkgs;

let
  python = python38Full;

  pelican_custom = with python.pkgs; pelican.overridePythonAttrs (
    old: rec {
      doCheck = false;
    }
  );
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
  };
}
