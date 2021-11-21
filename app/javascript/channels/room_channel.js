import consumer from "./consumer"

consumer.subscriptions.create('RoomChannel', {
  received(data) {
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
        <span class="time"><small>(${data['message']['short_date']}): </small></span>
        <span class="message">${data['message']['content']}</span>
      </p>
    `
  }
})
