import nc from "next-connect"

const handler = nc()
  .get((req, res) => {
    res.json({ data: [] })
  })

export default handler