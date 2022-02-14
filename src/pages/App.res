module Header = {
  @react.component
  let make = (~logout) => {
    <div className="h-10 px-5 bg-gray-200 flex items-center justify-between">
      <div className="uppercase font-bold text-lg text-gray-600"> {"appname"->React.string} </div>
      <Button
        title="logout"
        href="/api/auth/signout"
        onClick={e => {
          let _ = %raw(`_e.preventDefault()`)
          logout()
        }}
      />
    </div>
  }
}

@react.component
let make = (~logout) => {
  <>
    <Next.Head> <title key="title"> {"App"->React.string} </title> </Next.Head>
    <div> <Header logout /> <div className="p-5"> {React.string("Logged content...")} </div> </div>
  </>
}
