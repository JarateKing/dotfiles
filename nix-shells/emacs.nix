let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    ccls
    pyright
    ltex-ls
  ];
  shellHook = ''
    export EMACS_LSP="enabled"
  '';
}
