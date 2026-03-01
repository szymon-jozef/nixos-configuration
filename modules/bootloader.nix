{ pkgs, hostConfig, ... }:

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

      limine =
        if hostConfig.bootType == "mbr" then
          {
            enable = true;
            efiSupport = false;
            biosSupport = true;
            biosDevice = "/dev/sda";
          }
        else
          {
            enable = false;
          };

      systemd-boot = {
        enable = hostConfig.bootType == "gpt";

        configurationLimit = 10;
      };
    };

    kernelPackages = pkgs.linuxKernel.packagesFor pkgs.cachyosKernels.linux-cachyos-latest;
  };
}
