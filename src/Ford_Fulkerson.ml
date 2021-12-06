open Graph
open Tools

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


let augmentation graph path =

  let rec loop graph path comp = 
    match path with 
    |None -> failwith "ERROR : No path"
    |Some ([]) -> comp
    |Some (p::[])->comp
    |Some (p::tail) -> let value_label = Graph.find_arc graph p (List.nth tail 0) in 
      match value_label with 
      |None -> failwith "ERROR : we should have an arc between nodes in our solution"
      |Some v -> if v < comp then loop graph (Some tail) v else loop graph (Some tail) comp
  in
  match path with 
  |None -> failwith "ERROR : No path"
  |Some p -> let first_arc = (Graph.find_arc graph (List.nth p 0) (List.nth p 1)) in 
    match first_arc with
    |None->failwith "ERROR : no first arc"
    |Some fa -> loop graph path fa



(* Penser à faire un e_fold*)
let rec update_flow graph path aug = 
  let loop graph path aug final_graph = 
    match path with 
    |None -> final_graph
    |Some (n::[])-> final_graph
    |Some ([])-> failwith "We  should never have an empty path"
    |Some (n1::tail) -> 






























