document.addEventListener('DOMContentLoaded', changeActive);

// ページが読み込まれた時の背景色の変更
function changeActive() {
  const recent = document.querySelector('#recent');
  const least_recent = document.querySelector('#least-recent');
  const satisfaction = document.querySelector('#satisfaction');
  const params = window.location.search;

  if (params.includes('asc')) {
    recent.classList.remove('bg-gray-100');
    least_recent.classList.add('bg-gray-100');
  } else if (params.includes('satisfaction')) {
    recent.classList.remove('bg-gray-100');
    satisfaction.classList.add('bg-gray-100');
  } else {
    recent.classList.add('bg-gray-100');
  }

  const buttons = document.querySelector('#sort_buttons');
  buttons.addEventListener('click', clickButton);

  // ページが読み込まれる前の背景色の変更
  function clickButton(event) {
    recent.classList.remove('bg-gray-100');
    least_recent.classList.remove('bg-gray-100');
    satisfaction.classList.remove('bg-gray-100');

    event.target.classList.add('bg-gray-100');
  };
};
