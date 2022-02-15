type tTaskList = {id: string, title: string}
type tTaskListRes = {items: array<tTaskList>}

// let getTaskLists = (authToken: string) => {
//   let baseURL = "https://tasks.googleapis.com/tasks/v1"
//   Request.make(
//     ~url=`${baseURL}/users/@me/lists`,
//     ~responseType=(JsonAsAny: Request.responseType<tTaskListRes>),
//     ~method=#GET,
//     ~headers=Js.Dict.fromArray([
//       ("Authorization", `Bearer ${authToken}`),
//       ("content-type", "application/json"),
//       ("cache-control", "no-cache"),
//     ]),
//     (),
//   )->FuturePromise.toPromise
// }

@react.component
let make = () => {
  // let {session} = Session.useContext()
  let (lists, _setLists) = React.useState(_ => [])

  // React.useEffect1(() => {
  //   let _ = getTaskLists(session.accessToken)->Promise.thenResolve(res => {
  //     switch res {
  //     | Ok({response: Some({items})}) => setLists(_ => items)
  //     | _ => ()
  //     }
  //   })
  //   None
  // }, [session])

  lists
  ->Js.Array2.map(list =>
    <div className="border-2 p-2 my-1 rounded-md bg-gray-50" key={list.id}>
      {list.title->React.string}
    </div>
  )
  ->React.array
}
