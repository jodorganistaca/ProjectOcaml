open Gfile
open Tools
open Queue
open Graph

let iter_out_arcs = 

let find_path graph ids idp =
  let q = Queue.create () in
  let a = Queue.add ids q in 
  let rec loop graph id acu =
    match Queue.is_empty q with
    | true -> acu
    | false -> let e = Queue.take q in
      let find_arc = Graph.find_arc graph e idp in 
      match find_arc with
      | Some arc -> a::acu
      | None -> e::acu ; loop graph (iter_out_arcs (Graph.out_arcs graph e)) acu


(***)
(*
let bfs graph node goal = 
  let q = Queue.create () in
  let s = Set.empty ();
  Set.add node s ;
  Queue.add node q in 
  let resp = [] in
  let rec f resp = 
    if !Queue.is_empty q 
    then 
      let v = Queue.take q in
        Printf.printf "%d" v ;
        if v == goal
        then resp
        else List.iter (Queue.add e q) (List.filter (fun x -> Set.mem x s) graph.out_arcs v);
  f resp
*)