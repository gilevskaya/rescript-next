module SessionData = {
  type user = {
    id: string,
    email: string,
    image: string,
    name: string,
  }
  type t = {
    accessToken: string,
    expires: string,
    user: user,
  }
}

@react.component
let make = () => {
  let {data: session}: NextAuth.React.session<SessionData.t> = NextAuth.React.useSession()
  let router = Next.Router.useRouter()

  React.useEffect2(() => {
    if session->Belt.Option.isSome {
      router->Next.Router.push("/app")
    }
    None
  }, (session, router))

  <div className="bg-green-500"> {React.string("from rescript (auth test-3)")} </div>
}
