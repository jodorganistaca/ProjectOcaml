open Graph

let rec traiter_arc_sortants arcs_sortants graph idp = 
  match arcs_sortants with
  |[]->None
  |(id,lbl)::tail-> let res = find_path graph id idp in 
    match res with 
    |None -> traiter_arc_sortants tail graph idp
    |Some arc -> Some [(id,arc)]


(*ajouter une liste forbidden des noeuds déja visités pour éviter les récurssions infinies *)
and find_path graph ids idp =
  let rec loop graph idp acu ids =
    let a_path = (Graph.find_arc graph ids idp) in 
    match (a_path) with
    |Some arc -> let acu = (ids,arc)::acu in Some acu
    |None -> let neighbor = Graph.out_arcs graph ids in let acu = (traiter_arc_sortants neighbor graph idp)@acu

      in 
      loop graph idp [] ids

























