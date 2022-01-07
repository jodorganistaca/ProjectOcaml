
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native
format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile

clean:
	-rm -rf _build/
	-rm ftest.native

clean:
	-rm -rf *.cmo ftest *.cmi

test:
	./ftest.native ./graphs/graph_cycle 0 5 ./graphs/graph_cycle_out

clean_graphs:
	-rm -rf ./graphs/*.dot ./graphs/*.svg

bip:
	./ftest.native ./pb_bp/confbp -b

exp:
	./ftest.native ./graphs/$N -e

dot:
	dot -Tsvg ../graphs/$N.dot > ../graphs/$N.svg