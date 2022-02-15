module Task = {
  type t = {id: string, title: string}
}

module Context = {
  module State = {
    type t = {tasks: array<string>}
  }

  let context = React.createContext(None)

  module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~children) => {
      switch Some([]) {
      | None => React.null
      | Some(tasks) =>
        let state: State.t = {
          tasks: tasks,
        }
        React.createElement(
          provider,
          {
            "value": Some(state),
            "children": children,
          },
        )
      }
    }
  }
}

let useContext = () => {
  let ctx = React.useContext(Context.context)
  switch ctx {
  | Some(value) => value
  | None => Js.Exn.raiseError("UserData Context must be used withing a context provider")
  }
}
