document.addEventListener("turbo:load", () => {
  const input = document.getElementById("avatar-input");
  const preview = document.getElementById("avatar-preview");

  if (!input) return;

  input.addEventListener("change", (event) => {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();

    reader.onload = function (e) {
      preview.innerHTML = `
        <img src="${e.target.result}"
             class="w-32 h-32 rounded-full object-cover">
      `;
    };

    reader.readAsDataURL(file);
  });
});
