import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// 画像プレビュー---------------------------------------------
document.addEventListener("turbo:load", () => {
  const input = document.getElementById("image-input")
  const preview = document.getElementById("image-preview")
  if (!input || !preview) return

  let selectedFiles = []          // 新規アップロード
  let existingImages = []         // 既存画像用配列
  let removeImageIds = []         // 削除予定の既存画像ID

  // 編集画面用：初期データがある場合
  const initialData = preview.dataset.existing ? JSON.parse(preview.dataset.existing) : []
  existingImages = initialData    // サーバーから渡された既存画像を格納

  input.addEventListener("change", () => {
    selectedFiles = Array.from(input.files)
    renderPreview()
  })

  function renderPreview() {
    preview.innerHTML = ""

    // 既存画像 ★
    existingImages.forEach((img, idx) => {
      const wrapper = document.createElement("div")
      wrapper.className = "flex flex-col w-1/2 sm:w-1/5 h-32 rounded-lg"

      const imageEl = document.createElement("img")
      imageEl.src = img.url
      imageEl.className = "w-full h-24 object-cover rounded-lg mb-2"

      const btn = document.createElement("button")
      btn.type = "button"
      btn.textContent = "削除"
      btn.className = "px-2 py-0.5 text-xs text-gray-500 border border-gray-300 rounded mx-auto hover:text-gray-700 hover:border-gray-400 active:scale-95 transition"
      btn.dataset.existing = true
      btn.dataset.id = img.id

      btn.addEventListener("click", (e) => {
        const id = e.target.dataset.id

        removeImageIds.push(id) 
        document.getElementById("remove-image-ids").value = removeImageIds 

        existingImages = existingImages.filter(image => image.id != id)
        renderPreview()
      })

      wrapper.appendChild(imageEl)
      wrapper.appendChild(btn)
      preview.appendChild(wrapper)
    })

    // 新規ファイル
    selectedFiles.forEach((file, index) => {
      const reader = new FileReader()
      reader.onload = (e) => {
        const wrapper = document.createElement("div")
        wrapper.className = "flex flex-col w-1/2 sm:w-1/5 h-32 rounded-lg"

        const img = document.createElement("img")
        img.src = e.target.result
        img.className = "w-full h-24 object-cover rounded-lg mb-2"

        const btn = document.createElement("button")
        btn.type = "button"
        btn.textContent = "削除"
        btn.className = "px-2 py-0.5 text-xs text-gray-500 border border-gray-300"+
                        "rounded mx-auto hover:text-gray-700 hover:border-gray-400"+
                        "active:scale-95 transition"
        btn.dataset.index = index

        btn.addEventListener("click", (e) => {
          const removeIndex = Number(e.target.dataset.index)
          selectedFiles.splice(removeIndex, 1)
          updateInputFiles()
          renderPreview()
        })

        wrapper.appendChild(img)
        wrapper.appendChild(btn)
        preview.appendChild(wrapper)
      }
      reader.readAsDataURL(file)
    })
  }

  function updateInputFiles() {
    const dt = new DataTransfer()
    selectedFiles.forEach(file => dt.items.add(file))
    input.files = dt.files
  }

  renderPreview()
})
// --------------------------------------------------------
