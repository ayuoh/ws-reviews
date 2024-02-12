changeActive();
// ページが読み込まれた時の背景色の変更
function changeActive() {
  const recent = document.querySelector('#recent');
  const least_recent = document.querySelector('#least-recent');
  const satisfaction = document.querySelector('#satisfaction');
  const params = window.location.search;
  if (params.includes('asc')) {
    least_recent.classList.add('active-button');
  } else if (params.includes('satisfaction')) {
    satisfaction.classList.add('active-button');
  } else {
    recent.classList.add('active-button');
  }
};

const button = document.querySelector('.select-button');
button.addEventListener('click', (event) => {
  button.classList.remove('active-button');
  event.classList.add('active-button');
});
