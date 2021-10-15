.PHONY: build
build:
	dune build
	ln -sf _build/install/default/bin/sexp-fmt .

.PHONY: clean
clean:
	dune clean
	rm -f sexp-fmt
