(*
   Simplified S-expression parser.
*)

let default_atom_regexp = "[^() \t\r\n]+"

(* Lexer. *)
let split_string ?(atom_regexp = default_atom_regexp) str =
  str
  |> Str.full_split (Str.regexp ("[()]\\|" ^ atom_regexp))
  |> List.filter_map (function
      | Str.Delim s -> Some s
      | Str.Text _blank -> None
  )

let parse tokens : AST.node list =
  let rec parse tokens =
    match tokens with
    | [] -> [], []
    | "(" :: tokens ->
        let children, tokens = parse tokens in
        let siblings, tokens = parse tokens in
        ((AST.List children :: siblings), tokens)
    | ")" :: tokens ->
        ([], tokens)
    | atom :: tokens ->
        let siblings, tokens = parse tokens in
        ((AST.Atom atom :: siblings), tokens)
  in
  let ast, tokens = parse tokens in
  assert (tokens = []);
  ast

let string ?atom_regexp str : AST.t =
  str
  |> split_string ?atom_regexp
  |> parse

let read_channel ic : string =
  let lines = ref [] in
  try
    while true do
      lines := input_line ic :: !lines
    done;
    assert false
  with End_of_file ->
    List.rev !lines |> String.concat "\n"

let channel ?atom_regexp ic : AST.t =
  read_channel ic |> string ?atom_regexp
