{
  lib,
  config,
  hostConfig,
  ...
}:

{
  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
    amdgpu.overdrive.enable = lib.mkIf (!hostConfig.isNvidia && hostConfig.overclock.enable) true;

    nvidia = lib.mkIf hostConfig.isNvidia {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
