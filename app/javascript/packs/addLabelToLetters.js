import httpClient from "lib/http/client"

document.addEventListener('turbolinks:load',()=>{
  const labelBtn = document.querySelector('#labelBtn')
  if (!labelBtn) return

  const labelItems = document.querySelectorAll('#labelItem')
  const letters = document.querySelectorAll('#each_letter')
  const checkedLetters = []

  letters.forEach((letter)=>{
    letter.addEventListener('change', (e)=>{
      const letterId = Number(e.target.parentNode.dataset.id)
      const isChecked = e.target.checked
      if (isChecked) {
        checkedLetters.push(letterId)
      } else {
        const letterIdIndex = checkedLetters.indexOf(letterId)
        if (letterIdIndex < 0) return
        checkedLetters.splice(letterIdIndex, 1)
      }
    })
  })

  labelItems.forEach((label)=>{
    label.addEventListener('click', (e)=> {
      const labelId = Number(e.target.dataset.id);
      httpClient.post(`/api/letters/add_label`,{
        letter_ids: checkedLetters, label_id:labelId
      }).then((data)=>{
        window.location.href = window.location.pathname;
      })
    })
  })
})
