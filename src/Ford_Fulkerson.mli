open Tools
open Graph

(*Find a path form the source node to the sink node *)
val find_path: 'a graph -> id -> id ->'a out_arcs option

(*Find the minimum label value in a paht
  val augmentation: 'a out_arcs -> 'a

  (*Update the flows in the a graph after finding a path *)
  val update_flow: 'a graph -> 'a graph

  (*Give the flow max of the graph *)
  val flow_max: 'a graph -> 'a
*)