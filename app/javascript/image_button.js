const btn = document.querySelector('#image-button');
const input = document.querySelector('#activestorage_avatar_image');

btn.addEventListener("click", () => {
  input.click();
});

input.addEventListener("change", () => {
  const file = input.files[0];

  // readerのresultプロパティに、データURLとしてエンコードされたファイルデータを格納
  const reader = new FileReader();
  reader.readAsDataURL(file);

  reader.onload = function () {
    const image = document.querySelector('#image-button img');
    image.src = reader.result;
  }
});
