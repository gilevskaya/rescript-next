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
let make = () => {
  let taskList = React.useMemo0(() => <TaskLists />)

  <Session.Context.Provider>
    <AppLayout>
      <div className="mb-5 font-medium"> {React.string("Logged content:")} </div> {taskList}
    </AppLayout>
  </Session.Context.Provider>
}
