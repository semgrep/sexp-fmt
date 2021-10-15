.PHONY: build
build:
	dune build
	ln -sf _build/install/default/bin/sexp-fmt .

.PHONY: test
test: build
	./sexp-fmt < test/test.sexp > test/test.sexp.out
	diff -u test/test.sexp.out.expected test/test.sexp.out

.PHONY: clean
clean:
	dune clean
	rm -f sexp-fmt
