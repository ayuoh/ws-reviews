const switchbar = document.querySelector('.switchbar');
const switchbar_input = switchbar.lastChild;

switchbar.addEventListener('click', function () {
  // const input = document.querySelector('input[name="user[public]"]').checked

  this.classList.toggle('checked');
  if (!switchbar_input.checked) {
    switchbar_input.checked = true;
  } else {
    switchbar_input.checked = false;
  }
});
