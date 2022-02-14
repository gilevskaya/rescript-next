module React = {
  type session<'data> = {
    data: option<'data>,
    status: string,
  }

  @module("next-auth/react") external useSession: unit => session<'data> = "useSession"
}
