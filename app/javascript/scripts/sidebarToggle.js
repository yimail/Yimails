document.addEventListener('turbolinks:load', () => {
  const btn = document.querySelector('#sidebarBtn');
  const sidebar = document.querySelector('#sidebar');
  const sidebarBackdrop = document.querySelector('#sidebarBackdrop');
  
  btn.addEventListener("click", () => {
    sidebar.classList.toggle('hidden');
    sidebarBackdrop.classList.toggle('hidden');
  })
})