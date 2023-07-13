{ config, ... }:

{
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    screenSection = ''
        Option         "metamodes" "1920x1080_144 +0+0 {ForceFullCompositionPipeline=On}"
        Option         "AllowIndirectGLXProtocol" "off"
        Option         "TripleBuffer" "on"
      '';
  };
}
