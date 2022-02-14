import { make as App } from "../../lib/es6/src/pages/App.bs";
import { signOut, useSession } from "next-auth/react"

export default function AppIndexPage() {
  const { data: session } = useSession()

  if (session) {
    return (
      <App logout={signOut} />
    )
  }
  else {
    return (
      <div className="m-10 text-center">
        <div>
          {"Session expired"}
        </div>
        <div>
          <a className="underline" href="/">{"back to home"}</a>
        </div>
      </div>
    )
  }
}
