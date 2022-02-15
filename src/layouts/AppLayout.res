module Header = {
  @react.component
  let make = () => {
    let {session} = Session.useContext()

    <div className="h-10 px-5 bg-gray-200 flex items-center justify-between">
      <div className="uppercase font-bold text-lg text-gray-600"> {"appname"->React.string} </div>
      <UserInfo user=session.user />
      <Button
        title="logout"
        href="/api/auth/signout"
        onClick={e => {
          ReactEvent.Mouse.preventDefault(e)
          NextAuth.React.signOut()
        }}
      />
    </div>
  }
}

@react.component
let make = (~children) => {
  <>
    <Next.Head> <title key="title"> {"App"->React.string} </title> </Next.Head>
    <div> <Header /> <div className="m-5 mt-10"> {children} </div> </div>
  </>
}
