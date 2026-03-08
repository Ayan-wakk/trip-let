document.addEventListener("turbo:load", () => {
  const country = document.getElementById("country-select");
  const prefectureField = document.getElementById("prefecture-field");

  if (!country || !prefectureField) return;

  function togglePrefecture() {
    if (country.value === "JP") {
      prefectureField.style.display = "block";
    } else {
      prefectureField.style.display = "none";
    }
  }

  country.addEventListener("change", togglePrefecture);

  togglePrefecture();
});
