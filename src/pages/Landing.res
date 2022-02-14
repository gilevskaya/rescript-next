@react.component
let make = () => {
  let {session} = Session.use()
  let router = Next.Router.useRouter()

  React.useEffect2(() => {
    switch session {
    | None => Js.log("session-landing-none")
    | Some(s) => Js.log2("session-landing-some", s)
    }

    if session->Belt.Option.isSome {
      router->Next.Router.push("/app")
    }
    None
  }, (session, router))

  <div className="bg-green-500"> {React.string("from rescript (auth test-4)")} </div>
}
