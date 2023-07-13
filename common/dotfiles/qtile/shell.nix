with import <nixpkgs> {};

let
    pythonEnv = python310.withPackages (ps: [
        ps.qtile
    ]);

in mkShell {
    packages = [
        pythonEnv
    ];
}
