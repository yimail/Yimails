import httpClient from "lib/http/client"

document.addEventListener('turbolinks:load',()=>{
  const deleteLabelBtns = document.querySelectorAll('.delete_label_btn')
  if (!deleteLabelBtns) return

  deleteLabelBtns.forEach((deleteLabelBtn)=>{
    deleteLabelBtn.addEventListener('click', (e)=>{
      const labelId = Number(e.target.dataset.label_id);
      const letterId = Number(e.target.dataset.letter_id);
      httpClient.post(`/api/letters/delete_label`,{
        letter_id: letterId, label_id: labelId
      }).then((data)=>{
        window.location.href = window.location.pathname;
      })
    })
  })
})