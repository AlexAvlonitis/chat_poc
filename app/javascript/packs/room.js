document.addEventListener("turbolinks:load", function () {
  const input = document.getElementById("message_content");

  document.body.addEventListener("ajax:success", () => {
    input.value = '';
  })
})
