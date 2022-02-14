@react.component
let make = () => {
  let {session} = Session.use()
  let router = Next.Router.useRouter()

  React.useEffect2(() => {
    // switch session {
    // | None => Js.log("session-landing-none")
    // | Some(s) => Js.log2("session-landing-some", s)
    // }
    if session->Belt.Option.isSome {
      router->Next.Router.push("/app")
    }
    None
  }, (session, router))

  <div className="m-5">
    <div className="mb-5"> {React.string("sign in cleanup")} </div>
    <Button
      title="Sign in"
      href="/api/auth/signin"
      onClick={_e => {
        let _ = %raw(`_e.preventDefault()`)
        NextAuth.React.signIn(["google"])
      }}
    />
  </div>
}
