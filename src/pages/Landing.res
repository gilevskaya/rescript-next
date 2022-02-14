@react.component
let make = () => {
  let {data: session}: NextAuth.React.session<Types.SessionData.t> = NextAuth.React.useSession()
  let router = Next.Router.useRouter()

  React.useEffect2(() => {
    if session->Belt.Option.isSome {
      router->Next.Router.push("/app")
    }
    None
  }, (session, router))

  <div className="bg-green-500"> {React.string("from rescript (auth test-4)")} </div>
}
