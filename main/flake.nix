{
  description = ''onnxruntime C Api wrapped for nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-onnxruntime-main.flake = false;
  inputs.src-onnxruntime-main.owner = "YesDrX";
  inputs.src-onnxruntime-main.ref   = "refs/heads/main";
  inputs.src-onnxruntime-main.repo  = "onnxruntime-nim";
  inputs.src-onnxruntime-main.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-onnxruntime-main"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-onnxruntime-main";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}