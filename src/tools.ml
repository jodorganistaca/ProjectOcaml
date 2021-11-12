(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes gr = List.map (fun (a,b) graph -> (a) graph) (gr);;
let gmap gr f = assert false
let add_arc gr n1 n2 w = assert false