let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    ccls
    pyright
    ltex-ls
    ollama
  ];
  shellHook = ''
    export EMACS_LSP="enabled"
    export EMACS_LLM="enabled"

    # auto-run background programs
    # + exit them when emacs exits
    emacs & p0=$!
    ollama serve & p1=$!
    ollama run mistral &
    
    wait $p0
    kill $p1
    exit
  '';
}
