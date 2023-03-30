{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    pishrink = {
      url = "github:drewsif/pishrink";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    utils,
    ...
  }@inputs:
    utils.lib.eachDefaultSystem (
      system: let
        name = "tag";
        pkgs = import nixpkgs {
          inherit system;
        };

        pishrink = pkgs.writeShellScriptBin "pishrink" (builtins.readFile "${inputs.pishrink}/pishrink.sh");
      in rec {
        devShells.default = pkgs.mkShell {
          name = "${name}-devshell";
          packages = with pkgs; [
            parted
            util-linux
            e2fsprogs
            coreutils
            gzip
            xz
            pigz

            pishrink
          ];
        };
      }
    );
}
