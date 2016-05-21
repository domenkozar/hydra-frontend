with import (fetchTarball https://github.com/NixOS/nixpkgs/archive/6b9c67333fe62c38f1231dd5339b776c7c3d7172.tar.gz) {};

stdenv.mkDerivation {
 name = "hydra-frontend";

 src = ./.;

 buildInputs = [ elmPackages.elm nodejs ];

 patchPhase = ''
   patchShebangs node_modules/webpack
 '';

 buildPhase = ''
   npm run build
 '';

 installPhase = ''
   mkdir $out
   cp dist/* $out/
 '';
}
