const switchbar = document.querySelector('.switchbar');

switchbar.addEventListener('click', function () {
  const input = document.querySelector('input[name="user[public]"]').checked
  const switchbar_input = switchbar.firstChild;

  this.classList.toggle('checked');
  if (!input) {
    switchbar_input.checked = true;
  } else {
    switchbar_input.checked = false;
  }
});
