
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
	dot -Tsvg ./graphs/graph1.dot > ./graphs/graph1.svg
	dot -Tsvg ./graphs/graph1_out.dot > ./graphs/graph1_out.svg

test2:
	./ftest.native ./graphs/graph2 0 5 ./graphs/graph2_out
	dot -Tsvg ./graphs/graph2.dot > ./graphs/graph2.svg
	dot -Tsvg ./graphs/graph2_out.dot > ./graphs/graph2_out.svg

test_cycle:
	./ftest.native ./graphs/graph_cycle 0 9 ./graphs/graph_cycle_out
	dot -Tsvg ./graphs/graph_cycle.dot > ./graphs/graph_cycle.svg
	dot -Tsvg ./graphs/graph_cycle_out.dot > ./graphs/graph_cycle_out.svg

test_no_solution:
	./ftest.native ./graphs/simple_graph 0 3 ./graphs/simple_graph_out
	dot -Tsvg ./graphs/simple_graph.dot > ./graphs/simple_graph.svg
	dot -Tsvg ./graphs/simple_graph_out.dot > ./graphs/simple_graph_out.svg

clean_graphs:
	-rm -rf ./graphs/*.dot ./graphs/*.svg ./graphs/*_out ./graphs/graph_init

bip:
	./ftest.native ./pb_bp/confbp -b
	dot -Tsvg ./graphs/graph_init.dot > ./graphs/graph_init.svg
	dot -Tsvg ./graphs/graph_init_out.dot > ./graphs/graph_init_out.svg

dot:
	./ftest.native ./graphs/$N -e

svg:
	dot -Tsvg ./graphs/$N.dot > ./graphs/$N.svg