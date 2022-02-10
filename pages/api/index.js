import { getAPIData } from "../../lib/es6/src/APITest.bs";
import nc from "next-connect"

const handler = nc()
  .get((req, res) => {
    res.json(getAPIData())
  })

export default handler