module Header = {
  @react.component
  let make = (~logout) => {
    <div className="h-10 px-5 bg-gray-200 flex items-center justify-between">
      <div className="uppercase font-bold text-lg text-gray-600"> {"appname"->React.string} </div>
      <Button
        title="logout"
        href="/api/auth/signout"
        onClick={_e => {
          let _ = %raw(`_e.preventDefault()`)
          logout()
        }}
      />
    </div>
  }
}

@react.component
let make = (~logout) => {
  let {session} = Session.use()

  Js.log2("session", session)

  React.useEffect0(() => {
    if session->Belt.Option.isSome {
      let _ = %raw(`
        fetch("https://tasks.googleapis.com/tasks/v1/users/@me/lists", {
          method: "GET",
          headers: {
            Authorization: "Bearer " + session.accessToken,
            "content-type": "application/json"
          }
        }).then(response => response.json())
          .then(json => console.log(json))`)
    }
    None
  })

  <>
    <Next.Head> <title key="title"> {"App"->React.string} </title> </Next.Head>
    <div> <Header logout /> <div className="p-5"> {React.string("Logged content...")} </div> </div>
  </>
}
