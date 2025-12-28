import { Controller } from "@hotwired/stimulus"

// data-controller="menu"
export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }
}
