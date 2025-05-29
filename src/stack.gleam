import gleam/erlang/process.{type Subject}
import gleam/otp/actor

pub type Stack(e) = Subject(Message(e))

pub opaque type Message(element) {
  Shutdown
  Push(push: element)
  Pop(reply_with: Subject(Result(element, Nil)))
}

fn handle_message(message: Message(e), stack: List(e)) {
  case message {
    Shutdown -> actor.Stop(process.Normal)
    Push(value) -> actor.continue([value, ..stack])
    Pop(client) ->
      case stack {
        [] -> {
          process.send(client, Error(Nil))
          actor.continue([])
        }
        [first, ..rest] -> {
          process.send(client, Ok(first))
          actor.continue(rest)
        }
      }
  }
}

pub fn push(into stack: Stack(e), value value: e) {
    process.send(stack, Push(value)) 
}

pub fn pop(from stack: Stack(e)) {
    process.call_forever(stack, Pop)
}

pub fn new() {
  actor.start([], handle_message)
}
