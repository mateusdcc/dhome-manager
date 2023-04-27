let
  opts = import ./values.nix;
  types = import ./types.nix;
  typeChecker = (import ../../typeHandler.nix).assertValues;
  checkedOpts = typeChecker types opts;
in checkedOpts
