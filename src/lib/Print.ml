(*
   Pretty-print an S-expression how the author likes it.
*)

open Printf

let rec print_seq buf indent (ast : AST.node list) =
  match ast with
  | [] -> ()
  | [node] ->
      print_node buf indent node;
      bprintf buf ")"
  | node :: l ->
      print_node buf indent node;
      bprintf buf "\n";
      print_seq buf indent l

and print_node buf indent (node : AST.node) =
  bprintf buf "%s" indent;
  match node with
  | Atom s ->
      bprintf buf "%s" s
  | List [] ->
      bprintf buf "()"
  | List [Atom s] ->
      bprintf buf "(%s)" s
  | List (Atom s :: l) ->
      bprintf buf "(%s\n" s;
      print_seq buf (indent ^ "  ") l
  | List l ->
      bprintf buf "(";
      print_seq buf indent l

let to_string ast =
  let buf = Buffer.create 1000 in
  List.iter (fun node ->
    print_node buf "" node;
    bprintf buf "\n"
  ) ast;
  Buffer.contents buf

let to_channel oc ast =
  to_string ast
  |> output_string oc
