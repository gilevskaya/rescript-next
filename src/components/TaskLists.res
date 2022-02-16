@react.component
let make = () => {
  let {taskLists} = UserData.useContext()

  taskLists
  ->Js.Array2.map(list =>
    <div className="border-2 p-2 my-1 rounded-md bg-gray-50" key={list.id}>
      {list.title->React.string}
    </div>
  )
  ->React.array
}
