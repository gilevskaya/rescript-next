module Header = {
  @react.component
  let make = (~user) => {
    <div className="h-10 px-5 bg-gray-200 flex items-center justify-between">
      <div className="uppercase font-bold text-lg text-gray-600"> {"appname"->React.string} </div>
      <UserInfo user />
      <Button
        title="logout"
        href="/api/auth/signout"
        onClick={_e => {
          let _ = %raw(`_e.preventDefault()`)
          NextAuth.React.signOut()
        }}
      />
    </div>
  }
}

@react.component
let make = () => {
  let {session} = Session.use()
  let router = Next.Router.useRouter()

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

  // React.useEffect(() => {
  //   if (session?.user) {
  //     fetch("https://tasks.googleapis.com/tasks/v1/users/@me/lists", {
  //       method: "GET",
  //       headers: {
  //         Authorization: `Bearer ${session.accessToken}`,
  //         "content-type": "application/json"
  //       }
  //     }).then(response => response.json())
  //       .then(json => console.log(json))
  //   }
  // }, [session])

  React.useEffect2(() => {
    switch session {
    // Force sign in to hopefully resolve error
    | Some({error: Some("RefreshAccessTokenError")}) => NextAuth.React.signIn(["google"])
    | None => router->Next.Router.push("/")
    | _ => ()
    }
    None
  }, (session, router))

  switch session {
  | None => React.null
  | Some(session) => <>
      <Next.Head> <title key="title"> {"App"->React.string} </title> </Next.Head>
      <div>
        <Header user=session.user />
        <div className="p-5"> {React.string("Logged content...")} </div>
      </div>
    </>
  }
}
