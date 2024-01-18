import { Controller } from "@hotwired/stimulus"
import Tagify from '@yaireo/tagify'

// Connects to data-controller="tag"
export default class extends Controller {
  connect() {
    var input = document.querySelector('#tags-input'),
      tagify = new Tagify(input, {
        whitelist: [], dropdown: {
          position: "input",
          enabled: 0
        },
        originalInputValueFormat: valuesArr => valuesArr.map(item => item.value)
      }),
      controller;

    tagify.on('input', onInput)

    function onInput(e) {
      var value = e.detail.value
      tagify.whitelist = null // reset the whitelist

      // https://developer.mozilla.org/en-US/docs/Web/API/AbortController/abort
      controller && controller.abort()
      controller = new AbortController()

      // show loading animation.
      tagify.loading(true)

      fetch(`/tags/all_search?query=${value}`, { signal: controller.signal })
        .then(RES => RES.json())
        .then(function (newWhitelist) {
          tagify.whitelist = newWhitelist // update whitelist Array in-place
          tagify.loading(false).dropdown.show(value) // render the suggestions dropdown
        })
    }
  }
}
