sexp-fmt
==

Quick and dirty S-expression formatter.

This is suitable for formatting test cases for tree-sitter grammars
such as
[this](https://github.com/tree-sitter/tree-sitter-javascript/blob/master/test/corpus/statements.txt).

Sample input:
```
(program (command (command_name (concatenation (expansion (variable_name)) (word))) (word) (word)))
```
Output:
```
(program
  (command
    (command_name
      (concatenation
        (expansion
          (variable_name))
        (word)))
    (word)
    (word)))
```

Installation
--

You'll need OCaml and `dune` for the build. You can install them with
`opam install dune`.

From this repo, run `make`. The executable `sexp-fmt` is all you need
after this.
