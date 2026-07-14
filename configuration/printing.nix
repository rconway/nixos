{ config, pkgs, lib, ... }:

{
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # But disable printer auto-discovery.
  systemd.services.cups-browsed.enable = false;

  hardware.printers.ensurePrinters = [
    {
      name = "BrotherLaser";
      description = "Brother HL-L3230CDW";
      location = "Office";
      deviceUri = "ipp://192.168.0.11";
      model = "everywhere";
      ppdOptions = {
        PageSize = "A4";
        Duplex = "DuplexNoTumble";
      };
    }
  ];
}
