@react.component
let make = (~onClick, ~title, ~href) => {
  <a
    href
    className="px-2 py-1 border-gray-400 hover:bg-gray-300 border rounded-md text-gray-500 font-regular text-sm cursor-pointer"
    onClick>
    {title->React.string}
  </a>
}
