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

let rec print_list = function 
[] -> ()
| e::l -> print_int e ; print_string " " ; print_list l    

let rec augmentation graph path =
  match path with 
  |None-> 0
  |Some [] -> 0
  |Some (node_id :: tail) -> 
    if (List.length tail > 0) then
    let a_path = (Graph.find_arc graph node_id (List.hd tail)) in 
    match a_path with 
    |Some arc -> if (arc > (augmentation graph (Some tail))) then arc else augmentation graph (Some tail)
    |None -> 0
    else 0
  