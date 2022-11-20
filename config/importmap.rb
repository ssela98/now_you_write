# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin 'bootstrap', to: 'https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js'
pin '@popperjs/core', to: 'https://unpkg.com/@popperjs/core@2.11.2/dist/esm/index.js' # use unpkg.com as ga.jspm.io contains a broken popper package
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js' # TODO: remove @rails/ujs and replace link_to delete with buttons
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
