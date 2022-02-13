import IndexRes from "../lib/es6/src/Index.bs";
import { signIn, signOut, useSession } from "next-auth/react"
import React from "react";



export default function IndexPage() {
  const { data: session, status } = useSession()

  useEffect(() => {
    if (session?.error === "RefreshAccessTokenError") {
      signIn(); // Force sign in to hopefully resolve error
    }
  }, [session]);

  React.useEffect(() => {
    if (session?.user) {
      fetch("https://tasks.googleapis.com/tasks/v1/users/@me/lists", {
        method: "GET",
        headers: {
          Authorization: `Bearer ${session.accessToken}`,
          "content-type": "application/json"
        }
      }).then(response => response.json())
        .then(json => console.log(json))
    }
  }, [session])

  return (
    <div>
      <IndexRes />
      {!session && (<a
        href={`/api/auth/signin`}
        className="border p-1 bg-gray-100"
        onClick={(e) => {
          e.preventDefault()
          signIn(["google"])
        }}
      >
        Sign in
      </a>)}
      {session?.user && (
        <>
          {session.user.image && (
            <span
              style={{
                backgroundImage: `url('${session.user.image}')`, borderRadius: "2rem",
                float: "left",
                height: "2.8rem",
                width: "2.8rem",
                backgroundColor: "white",
                backgroundSize: "cover",
                backgroundRepeat: "no-repeat"
              }}
            />
          )}
          <span className="">
            <small>Signed in as</small>
            <br />
            <strong>{session.user.email ?? session.user.name}</strong>
          </span>
          <a
            href={`/api/auth/signout`}
            className="border p-1 bg-gray-100"
            onClick={(e) => {
              e.preventDefault()
              signOut()
            }}
          >
            Sign out
          </a>
        </>
      )}
    </div>
  );
}
