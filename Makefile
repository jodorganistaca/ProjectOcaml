
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

test1:
	./ftest.native ./graphs/graph1 0 5 ./graphs/graph1_out

test2:
	./ftest.native ./graphs/graph2 0 5 ./graphs/graph2_out

test_cycle:
	./ftest.native ./graphs/graph_cycle 0 9 ./graphs/graph_cycle_out

test_no_solution:
	./ftest.native ./graphs/simple_graph 0 3 ./graphs/simpl_graph_out

clean_graphs:
	-rm -rf ./graphs/*.dot ./graphs/*.svg ./graphs/*_out ./graphs/graph_init

bip:
	./ftest.native ./pb_bp/confbp -b

dot:
	./ftest.native ./graphs/$N -e

svg:
	dot -Tsvg ./graphs/$N.dot > ./graphs/$N.svg