open String 

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

let rec print_list_hackers hackers = 
  match hackers with 
  |[]->Printf.printf " \n"
  |(gender, day, pet, smoke, mixg)::t->Printf.printf "sex : %s, day : %s, pet : %s, smoke : %s, mixg : %s" gender day pet smoke mixg ; print_list_hackers t


let export_to_graph path = 
  let infile = open_in path in
  let test = all_hackers infile in
  print_list_hackers test 







