{ config, pkgs, ... }:

with pkgs;

let
  phpPackages = php74Packages;

in
stdenv.mkDerivation rec {
  name = "cypht";
  src = fetchFromGitHub {
    owner = "jasonmunro";
    repo = "cypht";
    rev = "v1.2.0-rc1";
    sha256 = "176j5haazpi885cg60v6dbyc66d8klqnpkqncrnazyp9iag3q2a2";
  };

  buildInputs = [ phpPackages.composer ];

  buildPhase = ''
    composer install
    find . -type -d -print | xargs chmod 755
    find . -type -f -print | xargs chmod 644
  '';

  installPhase = ''
    mkdir $out
    cp -r * $out/
  '';

  meta = {
    homepage = "https://cypht.org/";
    maintainers = [ "Jason Munro jason@cypht.org" ];
    license = stdenv.lib.licenses.lgpl21;
  };
}
