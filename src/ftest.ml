open Gfile
open Tools
open Ford_Fulkerson
open Graph
open Bipartite



let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)

  let () = export_to_graph "../pb_bp/confbp" in 
  let path_bip = open_in "../pb_bp/confbp" in
  let hosts_list = all_hosts path_bip in
  let path_bip = open_in "../pb_bp/confbp" in
  let hacker_list = all_hackers path_bip in  
  let graph_init = create_nodes hacker_list hosts_list in 
  let graph_init = create_arcs graph_init hacker_list hosts_list in 
  let () = write_file "../graphs/graph_init" graph_init in export graph_init "../graphs/graph_init.dot";
  let graph = from_file infile in export graph "../graphs/graph1.dot";
  let newgraph = gmap graph (int_of_string) in
  let updated_graph = flow_max newgraph _source _sink in
  let outgraph = gmap updated_graph (string_of_int) in  
  export outgraph "../graphs/updated_graph.dot";
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile outgraph in

  ()
