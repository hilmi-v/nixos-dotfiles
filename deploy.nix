{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "nix-deploy" ''
      set -e

      FLAKE_DIR="/home/hilmi/nixos-dotfiles/"
      cd "$FLAKE_DIR"

      git add .

      # 2. Ambil pesan commit kustom atau gunakan waktu saat ini
      COMMIT_MSG="''${1:-"rebuild: system update $(date +'%Y-%m-%d %H:%M:%S')"}"

      echo "=== Memulai Rebuild Sistem ==="

      # 3. Jalankan rebuild
      if sudo nixos-rebuild switch --flake .; then
        echo "=== Rebuild Sukses! Melakukan Commit & Push ==="
        git commit -m "$COMMIT_MSG" || echo "Tidak ada perubahan kode untuk dicommit."
        git push origin main
      else
        echo "❌ Rebuild gagal. Proses Git commit dan push dibatalkan."
        exit 1
      fi
    '')
  ];
}
