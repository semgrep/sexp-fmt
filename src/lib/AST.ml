(*
   Abstract representation of an S-expression.
*)

type node =
  | Atom of string
  | List of node list

type t = node list
