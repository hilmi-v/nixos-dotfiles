{ stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "sddm-theme";
  version = "1.0.0";
  src = ../sddm-theme/just-listen;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/just-listen
    cp -r $src/* $out/share/sddm/themes/just-listen/
  '';
}
