
open Tools
open Graph
open Ford_Fulkerson

type path = string 

(*create a matching bipartite graph at the text format and save it in graphs repository *)
val export_to_graph : path -> unit 