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
  <Session.Context.Provider>
    <Next.Head> <title key="title"> {"App"->React.string} </title> </Next.Head>
    <div>
      <Header />
      <div className="m-5 mt-10">
        <div className="mb-5 font-medium"> {React.string("Logged content:")} </div> <TaskLists />
      </div>
    </div>
  </Session.Context.Provider>
}
