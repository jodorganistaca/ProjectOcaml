open Gfile
open Tools
open Ford_Fulkerson
open Graph
open Bipartite

let description_usage = 
  Printf.printf "\nUsage: \n";
  Printf.printf "for export a file to dot file: \n" ;
  Printf.printf "%s infile -e\n" Sys.argv.(0);
  Printf.printf "for run the ford-fulkerson: \n" ;
  Printf.printf "%s infile source sink outfile\n" Sys.argv.(0) ;
  Printf.printf "for run the bipartite problem: \n"; 
  Printf.printf "%s configfile -b \n\n%!"  Sys.argv.(0) 

let () =

  (* Check the number of command-line arguments *)
  if (Array.length Sys.argv <> 5 && Array.length Sys.argv <> 3) then
    begin
      description_usage ;
      exit 0
    end ;

  (* Export a graph to dot format*)
  (* Arguments are : infile(1) -e(2) *)
  if (Array.length Sys.argv == 3 && Sys.argv.(2) = "-e") then
    begin
      let infile = Sys.argv.(1) in
      let graph = from_file infile in export graph (infile ^ ".dot");
      exit 0
    end ;
  
  (* Use ford fulkerson to solve bipartite problem*)
  (* Arguments are : configuration-file(1) -b(2) *)
  if (Array.length Sys.argv == 3 && Sys.argv.(2) = "-b") then
    begin
      let configfile = Sys.argv.(1) in
      let () = export_to_graph configfile in 
      let graph = from_file "../graphs/graph_init" in export graph (configfile ^ ".dot");
      let newgraph = gmap graph (int_of_string) in
      let updated_graph = flow_max newgraph (-1) (-2) in
      let updated_graph = clear_graph updated_graph in
      let outgraph = gmap updated_graph (string_of_int) in  
      export outgraph ("../graphs/graph_init_out" ^ ".dot");
      exit 0
    end ;
  
  (* FordFulkerson *)
  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file  and export to dot*)
  let graph = from_file infile in export graph (infile ^ ".dot");

  (* Create new graph to prepare the input graph. A int graph*)
  let newgraph = gmap graph (int_of_string) in

  (* Compute the ford fulkerson algorith. *)
  let updated_graph = flow_max newgraph _source _sink in

  (* Create new graph to prepare the output graph. A String graph*)
  let outgraph = gmap updated_graph (string_of_int) in  
  (* Export output graph to dot format*)
  export outgraph (outfile ^ ".dot");
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile outgraph in

  ()
