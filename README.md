Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml* extension in VSCode. Other extensions might work as well but make sure there is only one installed.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - automatic indentation on file save

How to use the algorithm :
To use the algortithm start by using the command `make` to compile (you have to make sure you are in the folder : `ProjectOcaml`). Then, you can use one of the make (`test1`, `test2`...) below to run the test you want. It will automatically generate the svg files corresponding to the input on the algorithm and the output (`_out`).

For the bipartite problem, the objective is to know with which host the hacker is going, knowing that the hacker and the host have specific requirments. The input data are in the file 'confbp' in the folder 'pb_bp'. You can write the data in of the problem by using the following format : 
- if it's a hacker : ha [friday/saturday/both] [pets/nopets] [smoke/nosmoke] [mixed/nomixed]
- if it's a host : ho [friday/saturday/both] [pets/nopets] [smoke/nosmoke] [mixed/nomixed] [number_of_people_he_can_host]
For each hacker or host you need to write on the next line.

To execute the algorithm manually do :
-`ocamlbuild ftest.native`
If you want to run Ford-Fulkerson then do :
-`./ftest.native [path to the input graph] [source] [sink] [path to the output graph]`
If you want to run the bipartite then do :
-`./ftest.native [path to the configuration file of the problem] -b`
To export manually a graph in .dot format do :
-`./ftest.native [path to the graph]`
To export manually a dot file to .svg format do :
-`dot -Tsvg [path to the dot file] > [path to the svg file]`

A makefile provides some useful commands:
 - `make build` to compile. This creates an ftest.native executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts
 
 - `make test1` to run the Ford-Fulkerson algorithm with graph1
 - `make test2`  to run the Ford-Fulkerson algorithm with graph2
 - `make test_cycle` to run the Ford-Fulkerson algorithm with a graph with a cycle
 - `make test_no_solution`  to run the Ford-Fulkerson algorithm with a graph where the source and the sing are not linked 
 - `make clean_graphs` to remove all the .dot and .svg files
 - `make bip` to run the algorithm solving the hosting problem with Ford-Fulkerson
 - `make dot N=[graph-to-export]` to export a graph in .dot
 - `make svg N=[graph-to-export]` to export a graph in .svg but you need to generate .dot first

in case of trouble with a `make` command test do a `make clean`, then a `make clean_graphs` and a `make`.  

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

