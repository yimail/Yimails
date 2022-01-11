document.addEventListener('turbolinks:load',()=>{
  const currentFolder = window.location.pathname
  const folderBtns = document.querySelectorAll('.folderBtn')
  folderBtns.forEach((folderBtn)=>{
    const folderRoute = folderBtn.dataset.route
    if (currentFolder === folderRoute){
      folderBtn.classList.add('focusedFolder')
    } 
  })
})