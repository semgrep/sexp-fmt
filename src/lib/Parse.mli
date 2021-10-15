(*
   Parse an S-expression that doesn't contain comments.
*)

(*
   The default regexp used to match an atom. Any non-matching input that's
   not a parenthesis will be treated as whitespace and discarded silently.
*)
val default_atom_regexp : string

(* Parse a string representing an S-expression. *)
val string : ?atom_regexp:string -> string -> AST.t

(* Parse an S-expression read from an input channel. *)
val channel : ?atom_regexp:string -> in_channel -> AST.t
