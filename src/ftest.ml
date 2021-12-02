open Gfile
open Tools
open Ford_Fulkerson
open Graph



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
  let graph = from_file infile in
  let newgraph = gmap graph (int_of_string) in
  let graphModified = add_arc newgraph 3 1 100 in
  let res = find_path graphModified _source _sink in print_out_arcs res ;
  let outgraph = gmap graphModified (string_of_int) in
  export outgraph "./graphs/graph.dot";






  (* Rewrite the graph that has been read. *)
  let () = write_file outfile outgraph in

  ()

