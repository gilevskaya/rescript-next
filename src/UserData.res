module Task = {
  type t = {id: string, title: string}
}
type tTaskListRes = {items: array<Task.t>}

module Response = {
  type t<'data>
  @send external json: t<'data> => Promise.t<'data> = "json"
}

@val @scope("globalThis")
external fetch: (string, 'params) => Promise.t<Response.t<tTaskListRes>> = "fetch"

let getTaskLists = (accessToken: string) => {
  let baseURL = "https://tasks.googleapis.com/tasks/v1"
  fetch(
    `${baseURL}/users/@me/lists`,
    {
      "method": "GET",
      "headers": {
        "Authorization": `Bearer ${accessToken}`,
        "Content-Type": "application/json",
      },
    },
  )->Promise.then(res => {
    Response.json(res)
  })
}

module Context = {
  module State = {
    type t = {taskLists: array<Task.t>}
  }

  let context = React.createContext(None)

  module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~children) => {
      let mounted = React.useRef(false)
      let {session} = Session.useContext()
      let (taskLists, setTaskLists) = React.useState(_ => None)

      React.useEffect1(() => {
        mounted.current = true
        if taskLists->Belt.Option.isNone {
          let _ = getTaskLists(session.accessToken)->Promise.thenResolve(res => {
            if mounted.current {
              setTaskLists(_ => Some(res.items))
            }
          })
        }
        Some(() => mounted.current = false)
      }, [session])

      switch taskLists {
      | None => React.null
      | Some(taskLists) =>
        let state: State.t = {
          taskLists: taskLists,
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
