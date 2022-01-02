
type host = (string, string, string, string, string, string)
type hacker = (string, string, string, string, string)
type hosts = host list
type hackers = hacker list

let all_hackers data_file =  
  let rec loop res=
    try
      let line = input_line data_file in 
      let line = Sring.trim line in

      if (line=="")then (loop res)

      else

        let h_feature = String.split_on_char " " line in 
        if (equal (h_feature.[0]) "ha") then
          let hacker = ((h_feature.[1]),(h_feature.[2]),(h_feature.[3]),(h_feature.[4]),(h_feature.[5]),(h_feature.[6])) in
          let res = hacker :: res in 
          loop res

        else 
          loop res
    with End_of_file -> res (* Done *)
  in
  loop []


let export_to_graph path = ()



