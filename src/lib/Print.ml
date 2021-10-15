(*
   Pretty-print an S-expression how the author likes it.

   See /test/* for examples of the desired output.
*)

open Printf

let rec print_seq buf is_first indent (ast : AST.node list) =
  match ast with
  | [] -> ()
  | [node] ->
      print_node buf is_first indent node;
      bprintf buf ")"
  | node :: l ->
      print_node buf is_first indent node;
      bprintf buf "\n";
      print_seq buf false indent l

and print_node buf is_first indent (node : AST.node) =
  if not is_first then
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
      print_seq buf false (indent ^ "  ") l
  | List l ->
      bprintf buf "(";
      print_seq buf true (indent ^ " ") l

let to_string ast =
  let buf = Buffer.create 1000 in
  List.iter (fun node ->
    print_node buf false "" node;
    bprintf buf "\n"
  ) ast;
  Buffer.contents buf

let to_channel oc ast =
  to_string ast
  |> output_string oc
