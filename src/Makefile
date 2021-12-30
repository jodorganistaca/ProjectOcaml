
build:
	@echo "\n==== COMPILING ====\n"
	# ocamlbuild ftest.native
	ocamlc -c graph.mli graph.ml gfile.mli gfile.ml tools.mli tools.ml Ford_Fulkerson.mli Ford_Fulkerson.ml
	ocamlc -o ftest graph.cmo gfile.cmo tools.cmo Ford_Fulkerson.cmo ftest.ml
	#dot -Tsvg ../graphs/graph.dot > ../graph/graphDotToSvg.svg
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
	-rm -rf *.cmo ftest *.cmi

test:
	./ftest ../graphs/graph_cycle 2 1 ../graphs/graph_cycle_out
