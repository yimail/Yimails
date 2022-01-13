import httpClient from 'lib/http/client'

document.addEventListener('turbolinks:load', () => {

  const back = document.querySelector('#back')
  if (!back) return

  const letterId = window.location.pathname.slice(9)
  httpClient.post(`/api/letters/${letterId}/read`,{
    letterId: letterId
  })
})