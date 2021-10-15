(*
   S-expression pretty-printer.
*)

(* Pretty-print an S-expression into a string. *)
val to_string : AST.t -> string

(* Write a pretty-printed S-expression to a channel. *)
val to_channel : out_channel -> AST.t -> unit
