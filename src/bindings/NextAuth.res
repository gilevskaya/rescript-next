module React = {
  type session<'data> = {
    data: option<'data>,
    status: string,
  }

  @module("next-auth/react") external useSession: unit => session<'data> = "useSession"
  @module("next-auth/react") external signIn: array<string> => unit = "signIn"
  @module("next-auth/react") external signOut: unit => unit = "signOut"
}
