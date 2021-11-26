type 'a label = ('a * 'a)

type qhead = int
type 'a queue = (qhead * ('a label) list)


let empty_queue = function
  |(_,[])->true
  |_->false

let add_element_to_queue (h,l) e = let new_l = l@[e] in (h,new_l)


let queue_next_element (h,l) = 
  match l with
  |[]->failwith "no more elements"
  |_-> let next_element = h+1 in (next_element,l)

let create_queue = (0,[])


let find_path graph ids idp =
  let q = create_queue in 
  let q = add_element_to_queue q (ids,ids) in

















