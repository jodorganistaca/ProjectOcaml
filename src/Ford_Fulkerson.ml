open Tools
open Graph

let rec traiter_arc_sortants arcs_sortants graph idp forbidden_nodes = 
  match arcs_sortants with
  |[]->[]
  |(id,lbl)::tail-> let forbidden_nodes = id::forbidden_nodes in 
    let res = find_path graph id idp forbidden_nodes in 
    match res with 
    |None -> traiter_arc_sortants tail graph idp forbidden_nodes
    |Some list_id -> list_id


(*ajouter une liste forbidden des noeuds déja visités pour éviter les récurssions infinies *)
and neighbor_not_in_forbidden_nodes list_forbidden (id,lbl)=
  if List.mem id list_forbidden then false else true

and find_path graph ids idp forbidden_nodes =
  let rec loop graph ids idp acu forbidden_nodes =
    let a_path = (Graph.find_arc graph ids idp) in 
    match (a_path) with
    |Some arc -> let acu = ids::acu in Some (acu@[idp])
    |None -> let neighbor = List.filter (neighbor_not_in_forbidden_nodes forbidden_nodes ) (Graph.out_arcs graph ids) in 
      let acu = (traiter_arc_sortants neighbor graph idp forbidden_nodes)@acu in
      match acu with
      |[]-> None
      |res-> Some ([ids]@res)

  in 
  loop graph ids idp [] forbidden_nodes

let rec augmentation graph path =
  match path with 
  |None-> Int.max_int
  |Some [] -> Int.max_int
  |Some (node_id :: tail) -> 
    if (List.length tail > 0) then
    let a_path = (Graph.find_arc graph node_id (List.hd tail)) in 
    match a_path with 
    |Some arc -> if (arc < (augmentation graph (Some tail))) then arc else augmentation graph (Some tail)
    |None -> Int.max_int
    else Int.max_int

let rec update_flow aug path graph =
  match path with 
  |None-> graph
  |Some [] -> graph
  |Some (node_id :: tail) -> 
    if (List.length tail > 0) then
    let a_path = (Graph.find_arc graph node_id (List.hd tail)) in 
    match a_path with 
    |Some arc -> 
      if((int_of_string arc) = aug) then
      let newgraph = gmap graph (int_of_string) in
      let newgraph = remove_arc newgraph node_id (List.hd tail) in 
      let newgraph = gmap (add_arc newgraph (List.hd tail) node_id (int_of_string arc)) (string_of_int)
      in update_flow aug (Some tail) newgraph 
      else  
      let newgraph = gmap graph (int_of_string) in
      let newgraph = (add_arc newgraph (List.hd tail) node_id aug) in 
      let newgraph = remove_arc newgraph node_id (List.hd tail) in 
      let newgraph = gmap (add_arc newgraph node_id (List.hd tail) ((int_of_string arc) - aug)) (string_of_int) in Printf.printf "arc : %d - aug: %d res: %d\n" (int_of_string arc) aug ((int_of_string arc) - aug);
      update_flow aug (Some tail) newgraph 
    |None -> graph
    else graph