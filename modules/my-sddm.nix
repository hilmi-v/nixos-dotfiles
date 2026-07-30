{ stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "sddm-theme";
  version = "1.0.0";
  src = ../my-sddm;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/my-sddm
    cp -r $src/* $out/share/sddm/themes/my-sddm/
  '';
}
