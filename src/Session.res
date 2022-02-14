module Data = {
  type user = {
    id: string,
    email: string,
    image: string,
    name: string,
  }
  type t = {
    error: option<string>,
    accessToken: string,
    expires: string,
    user: user,
  }
}

type t = {
  session: option<Data.t>,
  status: string,
}

let use = () => {
  let {data, status}: NextAuth.React.session<Js.Nullable.t<Data.t>> = NextAuth.React.useSession()
  let session = switch data {
  | None => None
  | Some(s) => Js.Nullable.toOption(s)
  }
  {session: session, status: status}
}

module Context = {
  module State = {
    type t = {session: Data.t, status: string}
  }

  let context = React.createContext(None)

  module Provider = {
    let provider = React.Context.provider(context)

    @react.component
    let make = (~children) => {
      let {session, status} = use()
      let router = Next.Router.useRouter()

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
      | Some(session) =>
        let state: State.t = {
          session: session,
          status: status,
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
  | None => Js.Exn.raiseError("Session Context must be used withing a context provider")
  }
}
