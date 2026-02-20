{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.system.virtualisation.enable = lib.mkEnableOption "Enable virtualisation";
  config = lib.mkIf config.system.virtualisation.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
      };
    };

    services.spice-vdagentd.enable = true;
    users.users.rami.extraGroups = [
      "libvirtd"
    ];
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      # win-virtio
      # win-spice
    ];
  };
}
