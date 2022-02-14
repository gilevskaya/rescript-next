import Head from 'next/head'
import { SessionProvider } from "next-auth/react"
import "../styles/globals.css"

export default function App({ Component, pageProps }) {
  return (
    <>
      <Head>
        <title key="title">My main title</title>
        <meta name="viewport" content="initial-scale=1.0, width=device-width" />
        {/* for sign in with google button */}
        <link href="https://fonts.googleapis.com/css?family=Google+Sans:500" rel="stylesheet"></link>
      </Head>
      <SessionProvider session={pageProps.session} refetchInterval={0}>
        <Component {...pageProps} />
      </SessionProvider>
    </>
  )
}