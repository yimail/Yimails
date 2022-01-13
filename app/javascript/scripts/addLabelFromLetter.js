import httpClient from "lib/http/client"

document.addEventListener('turbolinks:load',()=>{
  const labelBtn = document.querySelector('#labelBtn')
  if (!labelBtn) return

  const labelItems = document.querySelectorAll('#labelItemInShow')
  labelItems.forEach((label)=>{
    label.addEventListener('click', (e)=>{
      const letterId = Number(window.location.pathname.slice(9));
      const labelId = Number(e.target.dataset.id);
      console.log(letterId);
      console.log(labelId);
      httpClient.post(`/api/letters/add_label`,{
        letter_id: letterId, label_id: labelId
      }).then((data)=>{
        window.location.href = window.location.pathname;
      })
    })
  })
})