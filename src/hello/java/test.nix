{ outputs = { self, ... }: builtins.trace (builtins.attrNames self) self; }
