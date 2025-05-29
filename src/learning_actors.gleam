import stack

pub fn main() {
  let assert Ok(my_stack) = stack.new()

  stack.push(my_stack, "Airam")
  stack.push(my_stack, "Wilhelm")
  stack.push(my_stack, "Daniel")

  let assert Ok("Daniel") = stack.pop(my_stack)
  let assert Ok("Wilhelm") = stack.pop(my_stack)
  let assert Ok("Airam") = stack.pop(my_stack) 

  let assert Error(Nil) = stack.pop(my_stack) 
}
