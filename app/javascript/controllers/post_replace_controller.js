import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="post-replace"
export default class extends Controller {
  static values = { postId: Number }
  static targets = ["post"]

  // When connected, this will open a connection with the PostChannel using the id from the values
  // The received method indicates what happens with the data received.
  // In this example it is a one line replacement but can be a more complicated method
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "PostChannel", id: this.postIdValue },
      { received: data => this.postTarget.outerHTML = data }
    )
  }

  // Best practice is to have an unsubscribe
  disconnect() {
    this.channel.unsubscribe()
  }
}
