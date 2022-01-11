open String 
open Graph
open Gfile
open Tools


type path = string


type host = (string*string*string*string*string*string)
type hacker = (string*string*string*string*string)
type hosts = host list
type hackers = hacker list


let all_hackers data_file =  
  let rec loop res=
    try
      let line = input_line data_file in 
      let line = String.trim line in

      if (line=="")then (loop res)

      else

        let h_feature = String.split_on_char ' ' line in 
        if (equal (List.nth h_feature 0) "ha") then
          let hacker = ((List.nth h_feature 1),(List.nth h_feature 2),(List.nth h_feature 3),(List.nth h_feature 4),(List.nth h_feature 5)) in
          let res = hacker :: res in 
          loop res

        else 
          loop res
    with End_of_file -> res (* Done *)
  in
  loop []

let all_hosts data_file =  
  let rec loop res=
    try
      let line = input_line data_file in 
      let line = String.trim line in

      if (line=="")then (loop res)

      else

        let h_feature = String.split_on_char ' ' line in 
        if (equal (List.nth h_feature 0) "ho") then
          let host = ((List.nth h_feature 1),(List.nth h_feature 2),(List.nth h_feature 3),(List.nth h_feature 4),(List.nth h_feature 5), (List.nth h_feature 6)) in
          let res = host :: res in 
          loop res

        else 
          loop res
    with End_of_file -> res (* Done *)
  in
  loop []

let rec print_list_hackers hackers = 
  match hackers with 
  |[]->Printf.printf " \n"
  |(gender, day, pet, smoke, mixg)::t->Printf.printf "---- sex : %s ; day : %s ; pet : %s ; smoke : %s ; mixg : %s ----\n" gender day pet smoke mixg ; print_list_hackers t

let rec print_list_hosts hosts = 
  match hosts with 
  |[]->Printf.printf " \n"
  |(gender, day, pet, smoke, mixg, number)::t->Printf.printf "---- sex : %s ; day : %s ; pet : %s ; smoke : %s ; mixg : %s ; number : %s ----\n" gender day pet smoke mixg number; print_list_hosts t

let give_number_to_h list_of_h =
  let rec loop list_of_h acu =
    match list_of_h with 
    |[]->failwith "Error, this case should never occur"
    |h::[]->(acu,h)::[]
    |h::t-> let acu2=acu+1 in (acu,h)::(loop t acu2)
  in 
  loop list_of_h 0

let add_one_if cond n = if (cond) then n else n+1

let evaluate_cost ha (g,d,p,s,m,n) = 
  match ha with
  |(gender,day,pet,smoke,mixg)->
    let res = 0 in 
    let res = add_one_if ((String.equal d day)||(String.equal d "both")) res in
    let res = add_one_if (String.equal p pet) res in
    let res = add_one_if (String.equal s smoke) res in 
    let res = add_one_if (((String.equal m "mixed")&&(String.equal mixg "mixed"))||(((String.equal m "nomixed")||(String.equal mixg "nomixed"))&&(String.equal gender g))) res in
    res

let create_nodes list_ha list_ho = 
  let rec loop list_ha list_ho graph id =
    match (list_ha, list_ho) with
    |([], [])->let graph = new_node graph (-1) in let graph = new_node graph (-2) in graph
    |(h::t,_)-> let graph = new_node graph id in loop t list_ho graph (id+1)
    |([], h::t)-> let graph = new_node graph id in loop [] t graph (id+1)
  in 
  loop list_ha list_ho empty_graph 0

let create_arcs graph list_ha list_ho = 
  let rec loop graph list_ha list_ho len_ha len_ho =
    match (list_ha) with
    |([])->graph
    |(ha::tha)-> 
      let rec loop2 graph ha list_ho len_ha len_ho =
        match (list_ho) with
        |([])->graph
        |(ho::tho)-> let cost = evaluate_cost ha ho in
          let graph = new_arc graph (len_ha - List.length list_ha) ((len_ha + len_ho) - List.length list_ho) ("1",cost) in loop2 graph ha tho len_ha len_ho
      in
      let graph = loop2 graph ha list_ho len_ha len_ho
      in loop graph tha list_ho len_ha len_ho
  in 
  loop graph list_ha list_ho (List.length list_ha) (List.length list_ho)
let add_source_to_graph graph list_ha =
  let rec loop graph list_ha len_ha =
    match (list_ha) with 
    |[]->graph
    |ha::t->let new_graph = (new_arc graph (-1) (len_ha-List.length list_ha) ("1",0)) in loop new_graph t len_ha
  in 
  loop graph list_ha (List.length list_ha)

let add_sink_to_graph graph list_ho len_ha=
  let rec loop graph list_ho len_ho len_ha =
    match (list_ho) with 
    |[]->graph
    |(gender, day, pet, smoke, mixg, number)::t->let new_graph = (new_arc graph (len_ha+(len_ho-List.length list_ho)) (-2) (number,0)) in loop new_graph t len_ho len_ha
  in 
  loop graph list_ho (List.length list_ho) len_ha

let remove_specific_arcs_from_nodes graph id = 
  let outa = out_arcs graph id in 
  let rec loop graph id outa = 
    match outa with 
    |[]->graph
    |(idn,lbl)::t-> 
      if(idn == -1 || idn == -2) then let new_graph = remove_arc graph id idn in loop new_graph id t 
      else if (id<idn) then let new_graph = remove_arc graph id idn in loop new_graph id t else loop graph id t
  in 
  loop graph id outa 


let clear_graph graph = n_fold graph remove_specific_arcs_from_nodes graph

(*let clear_graph gr = let addArcModified bgr id1 id2 edg = if(id1 > id2) then new_arc bgr id1 id2 edg else bgr  in 
  e_fold gr (addArcModified) (clone_nodes gr) 
*)

let string_of_tuple (lbl,cost)= "("^lbl^","^(string_of_int cost)^")"



let export_to_graph path = 
  let infile = open_in path in
  let test = all_hosts infile in
  print_list_hosts test ;
  let infile = open_in path in
  let testH = all_hackers infile in  
  print_list_hackers testH;

  let path_bip = open_in path in
  let hosts_list = all_hosts path_bip in
  let path_bip = open_in path in
  let hacker_list = all_hackers path_bip in  
  let graph_init = create_nodes hacker_list hosts_list in 
  let graph_init = create_arcs graph_init hacker_list hosts_list in 
  let graph_init = add_sink_to_graph graph_init hosts_list (List.length hacker_list) in 
  let graph_init = add_source_to_graph graph_init hacker_list in
  let graph_init = gmap graph_init string_of_tuple in
  let () = write_file "./graphs/graph_init" graph_init in export graph_init "./graphs/graph_init.dot";









