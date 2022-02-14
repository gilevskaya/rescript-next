@react.component
let make = (~user: Session.Data.user) => {
  <div className="flex">
    <div
      className="mr-1 h-8 w-8 rounded-lg bg-cover"
      style={ReactDOM.Style.make(~backgroundImage=`url('${user.image}')`, ())}
    />
    <div className="text-xs text-gray-600">
      <div> {user.name->React.string} </div>
      <div className="font-medium"> {user.email->React.string} </div>
    </div>
  </div>
}
