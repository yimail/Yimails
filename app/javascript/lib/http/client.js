import axios from "axios"

const token = document.querySelector("meta[name=csrf-token]").content
axios.defaults.headers.common["X-CSRF-Token"] = token

export default axios