{ nixpkgs ? import <nixpkgs> { config = { allowBroken = true; }; } }:

nixpkgs.stdenv.mkDerivation rec {
  name = "my-blog";
  src = nixpkgs.fetchFromGitHub {
    owner = "ScorpionResponse";
    repo = "pelican_blog";
    rev = "master";
    sha256 = "06rnys66cqr5psb9v62hgbggx9q6nmaibm7a63d574b6yl0ndly3";
  };

  buildInputs = [ nixpkgs.python38Packages.pelican ];
  buildPhase = ''
    make html
  '';
  installPhase = ''
    cp -r output $out
  '';
}
