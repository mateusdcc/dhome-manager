let
  inherit (builtins) all attrValues typeOf tryEval throw isBool boolToString;
  assertSetValues = assertAllAttrs: valuesSet:
    let
      assertOneAttr = attr:
        let result = tryEval (assertAllAttrs.${attr} valuesSet.${attr});
        in if result.value && result.success then
          true
        else
          throw "Assertion failed for attribute ${attr}: ${
            if isBool valuesSet.${attr} then
              boolToString valuesSet.${attr}
            else if typeOf valuesSet.${attr} == "string" then
              ''"${valuesSet.${attr}}"''
            else
              toString valuesSet.${attr}
          } does not satisfy the defined type";
    in if builtins.all (attr: assertOneAttr attr)
    (builtins.attrNames valuesSet) then
      valuesSet
    else
      throw "Assertion failed";
in { assertValues = assertSetValues; }
