import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="post-replace"
export default class extends Controller {
  static values = { postId: Number }
  static targets = ["post"]

  connect() {
    console.log("connecting")
    this.channel = createConsumer().subscriptions.create(
      { channel: "PostChannel", id: this.postIdValue },
      { received: data => this.postTarget.outerHTML = data }
    )
    console.log("done")
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
}
