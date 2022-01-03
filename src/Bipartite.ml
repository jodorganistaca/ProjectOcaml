open String 


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

let export_to_graph path = 
  let infile = open_in path in
  let test = all_hosts infile in
  print_list_hosts test







