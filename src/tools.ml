(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes gr = n_fold gr (new_node) empty_graph ;;

let gmap gr f = let addArcModified bgr id1 id2 edg =  new_arc bgr id1 id2 (f edg) in 
  e_fold gr (addArcModified) (clone_nodes gr)

let add_arc gr n1 n2 w = 
  let edg = find_arc gr n1 n2 in 
  match edg with
  |None -> new_arc gr n1 n2 w
  |Some e -> new_arc gr n1 n2 (e+w)