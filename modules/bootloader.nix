{
  pkgs,
  hostConfig,
  lib,
  ...
}:

{
  boot = {
    initrd.systemd.enable = true;
    plymouth.enable = true;

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];

    loader = {
      timeout = 5;

      efi.canTouchEfiVariables = hostConfig.bootType == "gpt";

      limine = {
        enable = true;

        efiSupport = hostConfig.bootType == "gpt";
        biosSupport = hostConfig.bootType == "mbr";

      }
      // lib.optionalAttrs (hostConfig.bootType == "mbr") {
        biosDevice = "/dev/sda";
      };
    };

    kernelPackages = pkgs.linuxKernel.packagesFor pkgs.cachyosKernels.linux-cachyos-latest;
  };
}
