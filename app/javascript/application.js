import "@hotwired/turbo-rails"

import { Application } from "@hotwired/stimulus"
const application = Application.start()
export { application }

import "./controllers"

import "@rails/activestorage"

import "./avatar_preview"
