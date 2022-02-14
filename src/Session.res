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
