type tTaskList = {id: string, title: string}
type tTaskListRes = {items: array<tTaskList>}

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

@react.component
let make = () => {
  let {session} = Session.useContext()
  let (lists, setLists) = React.useState(_ => None)

  Js.log("R::TasksList")

  React.useEffect0(() => {
    if lists->Belt.Option.isNone {
      let _ = getTaskLists(session.accessToken)->Promise.thenResolve(res => {
        Js.log2("getTaskLists", res.items)
        setLists(_ => Some(res.items))
      })
    }
    None
  })

  switch lists {
  | None => "Loading..."->React.string
  | Some(ls) =>
    ls
    ->Js.Array2.map(list =>
      <div className="border-2 p-2 my-1 rounded-md bg-gray-50" key={list.id}>
        {list.title->React.string}
      </div>
    )
    ->React.array
  }
}
