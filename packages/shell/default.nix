{pkgs, ...}:

let
  organizeFiles = pkgs.writeShellScriptBin "organize-files" ''
    bash -c "ls" | awk -v file=$1 '{ if (match($0, file)) { print $0 } }'| awk -F. '{ print $NF }' | uniq | xargs -I {} bash -c "mkdir -p {} && [ ! -f *.{} ] || mv *.{} {}"
  '';
in
  {
    organizeFiles = organizeFiles;
  }
