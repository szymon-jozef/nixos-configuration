{ pkgs, ... }:

{
  boot = {
    initrd.systemd.enable = true;
    loader.limine = {
      enable = true;
      efiSupport = false;
      biosSupport = true;
      biosDevice = "/dev/sda";
    };

    plymouth.enable = true;

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    loader.timeout = 5;

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
