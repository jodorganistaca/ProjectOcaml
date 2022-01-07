
build:
	@echo "\n==== COMPILING ====\n"
	# ocamlbuild ftest.native
	ocamlc -c graph.mli graph.ml gfile.mli gfile.ml tools.mli tools.ml Ford_Fulkerson.mli Ford_Fulkerson.ml Bipartite.mli Bipartite.ml
	ocamlc -o ftest graph.cmo gfile.cmo tools.cmo Ford_Fulkerson.cmo Bipartite.cmo ftest.ml
	#
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
	./ftest ../graphs/graph1 0 5 ../graphs/graph1_out

clean_graphs:
	-rm -rf ../graphs/*.dot ../graphs/*.svg

bip:
	./ftest "../pb_bp/confbp" -b

exp:
	./ftest ../graphs/$N -e

dot:
	dot -Tsvg ../graphs/$N.dot > ../graphs/$N.svg
