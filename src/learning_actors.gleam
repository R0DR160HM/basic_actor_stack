import gleam/erlang/process
import stack

pub fn main() {
  let assert Ok(my_actor) = stack.new()

  process.send(my_actor, stack.Push("Airam"))
  process.send(my_actor, stack.Push("Wilhelm"))
  process.send(my_actor, stack.Push("Daniel"))

  let assert Ok("Daniel") = process.call(my_actor, stack.Pop, 10)
  let assert Ok("Wilhelm") = process.call(my_actor, stack.Pop, 10)
  let assert Ok("Airam") = process.call(my_actor, stack.Pop, 10)

  let assert Error(Nil) = process.call(my_actor, stack.Pop, 10)
}
