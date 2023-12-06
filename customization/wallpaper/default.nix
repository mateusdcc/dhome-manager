{type ? "onecolor", pkgs ? <nixpkgs>, ...}:

let
  ddef = arg:
  ''
    magick -size 60x60 pattern:${arg} -auto-level -rotate 45 -set colorspace RGB +level-colors "${colors.foreground}","${colors.background}" -compose ModulusAdd $out/bg.png
  '';
  vdef = arg:
  ''
    magick -size 60x60 pattern:${arg} -auto-level -set colorspace RGB +level-colors "${colors.foreground}","${colors.background}" -compose ModulusAdd $out/bg.png
  '';
  types = {
    "dcheck" = ddef "checkboard";
    "vcheck" = vdef "checkboard";
    "dbricks" = ddef "bricks";
    "vbricks" = vdef "bricks";
    "dcrosshatch" = ddef "crosshatch";
    "vcrosshatch" = vdef "crosshatch";
    "dhexagons" = ddef "hexagons";
    "vhexagons" = vdef "hexagons";
    "doctagons" = ddef "octagons";
    "voctagons" = vdef "octagons";
    "gradient" = ''
    magick -size 1366x768 gradient:"${colors.foreground}"-"${colors.background}" \
        -colorspace RGB \
        -rotate 90 \
        +distort Polar '36.5,0,.5,.5' +repage \
        -transverse \
        -resize 2000x2000 \
        -quality 100 $out/bg.png
      '';
  };
  colors = (import ../../variables.nix).colors;
  images = pkgs.stdenv.mkDerivation {
    name = "customCustom";
    unpackPhase = "true";
    buildInputs = [ pkgs.imagemagick ];
    installPhase = ''
      mkdir $out
      ${types.${type}}
      '';
  };
in
  images
