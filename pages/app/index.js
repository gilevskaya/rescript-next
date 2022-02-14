import { make as App } from "../../lib/es6/src/pages/App.bs";
import { signOut, useSession } from "next-auth/react"

export default function AppIndexPage() {
  const { data: session } = useSession()

  return <App logout={signOut} />
}
