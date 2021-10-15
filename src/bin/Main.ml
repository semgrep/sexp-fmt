(*
   Entry point.
*)

open Printf

let run () =
  Sexp_fmt.Parse.channel stdin
  |> Sexp_fmt.Print.to_channel stdout

let main () =
  match Sys.argv with
  | [| _ |] -> run ()
  | _ ->
      eprintf "\
%s - pretty-print a lisp-like S-expression.
Usage: ./sexp < input
"
        (Filename.basename Sys.argv.(0))

let () = main ()
