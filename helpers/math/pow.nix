
let
  pow = b: e :
    if e == 0 then 1
    else if e == 1 then b
    else b * pow b ( e - 1);
in
  pow
