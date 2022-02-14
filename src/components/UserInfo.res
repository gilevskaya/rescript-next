@react.component
let make = (~user: Session.Data.user) => {
  <div className="flex">
    <div className="mr-2 border border-red-400 h-8 w-8 rounded-lg" />
    <div className="text-xs text-gray-600">
      <div> {user.name->React.string} </div>
      <div className="font-medium"> {user.email->React.string} </div>
    </div>
  </div>
}
