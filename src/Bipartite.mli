
open Tools
open Graph
open Ford_Fulkerson

type path = string 

type host = (string*string*string*string*string*string)

type hacker = (string*string*string*string*string)

(*create a matching bipartite graph at the text format and save it in graphs repository *)
val export_to_graph : path -> unit 

val all_hosts: in_channel -> host list

val all_hackers: in_channel -> hacker list

val create_nodes: hacker list -> host list -> 'a graph

val create_arcs: string Graph.graph -> hacker list -> host list -> string Graph.graph
