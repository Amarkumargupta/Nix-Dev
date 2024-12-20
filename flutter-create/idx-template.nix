{pkgs, sample ? "none", template ? "app", blank ? false, platforms ? "web,android", ...}: {
    packages = [
        pkgs.curl
        pkgs.gnutar
        pkgs.xz
        pkgs.git
        pkgs.busybox
        pkgs.flutter
        pkgs.python3
        pkgs.python311Packages.pip
        pkgs.python311Packages.fastapi
        pkgs.python311Packages.uvicorn
    ];
    bootstrap = ''
        flutter create "$out" --template="${template}" --platforms="${platforms}" ${if sample == "none" then "" else "--sample=${sample}"} ${if blank then "-e" else ""}
        mkdir "$out"/.idx
        cp ${./dev.nix} "$out"/.idx/dev.nix
        install --mode u+rw ${./dev.nix} "$out"/.idx/dev.nix
        chmod -R u+w "$out"
    '';
}
