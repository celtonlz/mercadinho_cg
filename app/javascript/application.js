// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// app/javascript/application.js
import Rails from '@rails/ujs'
Rails.start()

import { Turbo } from "turbo-rails"

