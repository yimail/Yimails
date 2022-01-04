import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "checkbox" ]

  connect() {
    console.log(123);
    // this.outputTarget.textContent = 'Hello, Stimulus!'
  }
}
