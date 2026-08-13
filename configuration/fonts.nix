{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # Microsoft core web fonts (Arial, Times New Roman, Verdana, etc.)
      corefonts

      # Office-compatible metric substitutes (Calibri/Cambria equivalents)
      carlito
      caladea

      # Broad compatibility fallbacks for common document families
      liberation_ttf
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Caladea" "Liberation Serif" "DejaVu Serif" ];
        sansSerif = [ "Carlito" "Liberation Sans" "DejaVu Sans" ];
        monospace = [ "Liberation Mono" "DejaVu Sans Mono" ];
      };
    };
  };
}
