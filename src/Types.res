module SessionData = {
  type user = {
    id: string,
    email: string,
    image: string,
    name: string,
  }
  type t = {
    accessToken: string,
    expires: string,
    user: user,
  }
}
