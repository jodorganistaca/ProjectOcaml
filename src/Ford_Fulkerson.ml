open Tools
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

let rec print_costs =
  function
  | [] -> ()
  | (a, b) :: rest ->
    Printf.printf "%d, %d; \n" a b;
    print_costs rest

let rec print_paths =
  function
  | [] -> ()
  | (a, b) :: rest ->
    Printf.printf "node : %d \n" a;
    List.iter (Printf.printf "%d, \n") b;
    print_paths rest

let initiliaze_cost graph ids =
  let loop graph ids acu = n_fold graph (fun acu id -> if(id = ids) then acu@[(id,0)] else acu@[(id,Int.max_int)]) [] in
  loop graph ids []

let initiliaze_path graph = n_fold graph (fun acu id -> acu@[(id,[id])]) [] 

let rec update_cost_path id arcs_sortants cost_list path_list =
  match (arcs_sortants) with 
  |[]->(cost_list,path_list)
  |(idv,(cap,cost))::tail-> 
    let actual_cost = List.assoc idv cost_list in
    let cost_visit = List.assoc id cost_list in
    let actual_path = List.assoc id path_list in
    if (actual_cost > cost + cost_visit) then
      let cost_list = (idv, cost + cost_visit) :: List.remove_assoc idv cost_list in
      let path_list = (idv, actual_path@[idv]) :: List.remove_assoc idv path_list in
      update_cost_path id tail cost_list path_list
    else
      update_cost_path id tail cost_list path_list

let rec make_bellmand_ford_it nodes graph cost_list path_list =
  match (nodes) with
  |[] -> (cost_list,path_list)
  |id::tail -> 
    let arcs_sortants = Graph.out_arcs graph id in 
    let cost_path = update_cost_path id arcs_sortants cost_list path_list in 
    let new_cost = (fun (c,p) -> c) cost_path in 
    let new_path = (fun (c,p) -> p) cost_path in
    make_bellmand_ford_it tail graph new_cost new_path

let rec bellman_ford nodes graph cost_list path_list len_nodes = 
  match (len_nodes) with
  |0 -> path_list
  |_ -> 
    let cost_path = make_bellmand_ford_it nodes graph cost_list path_list  in 
    let new_cost = (fun (c,p) -> c) cost_path in 
    let new_path = (fun (c,p) -> p) cost_path in
    bellman_ford nodes graph new_cost new_path (len_nodes-1)

let find_minimum_path graph ids =
  let cost_list = initiliaze_cost graph ids in (*print_costs cost_list;*)
  let path_list = initiliaze_path graph in (*print_paths path_list*)
  let nodes = n_fold graph (fun acu id -> acu@[id]) [] in
  let len_nodes = (List.length nodes - 1) in 
  let path_list = bellman_ford nodes graph cost_list path_list (len_nodes-1)
in path_list

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
        if(arc = aug) then
          let newgraph = remove_arc graph node_id (List.hd tail) in 
          let newgraph = add_arc newgraph (List.hd tail) node_id arc
          in update_flow aug (Some tail) newgraph 
        else
          let newgraph = add_arc graph (List.hd tail) node_id aug in 
          let newgraph = remove_arc newgraph node_id (List.hd tail) in 
          let newgraph = add_arc newgraph node_id (List.hd tail) (arc - aug) in
          update_flow aug (Some tail) newgraph 
      |None -> graph
    else graph

let flow_max graph _source _sink =
  let rec flow_max_loop graph _source _sink max_flow =
  let rec exist_path = find_path graph _source _sink [] in (*print_out_solution exist_path ; print_paths (find_minimum_path graph _source _sink);*)
  match exist_path with 
  |None-> graph 
  |Some [] -> graph
  |Some path -> 
    let aug = (augmentation graph exist_path) in (*Printf.printf "augmentation: %d \n" aug;*)
    let updated_graph = update_flow aug exist_path graph in
    let max_flow = max_flow + aug in Printf.printf "sol: %d \n" max_flow ;
    flow_max_loop updated_graph _source _sink max_flow
  in flow_max_loop graph _source _sink 0
