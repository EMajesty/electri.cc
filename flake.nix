{
  description = "electri.cc - Hugo static site";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.stdenv.mkDerivation {
          pname = "electri-cc";
          version = self.shortRev or self.dirtyShortRev or "dev";
          src = ./.;
          nativeBuildInputs = [ pkgs.hugo ];
          buildPhase = ''
            hugo --minify
          '';
          installPhase = ''
            cp -r public $out
          '';
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [ pkgs.hugo ];
        };
      });
    };
}
