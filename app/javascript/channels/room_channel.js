import consumer from "./consumer"

consumer.subscriptions.create('RoomChannel', {
  received(data) {
    console.log(data)
    this.appendLine(data)
  },

  appendLine(data) {
    const html = this.createLine(data)
    const element = document.querySelector("[data-chat-room='Chat']")
    element.insertAdjacentHTML("beforeend", html)
  },

  createLine(data) {
    return `
      <p>
        <strong>${data["current_user"]["name"]}</strong>
        <span class="time"><small>(${data['message']['created_at']}): </small></span>
        <span class="message">${data['message']['content']}</span>
      </p>
    `
  }
})