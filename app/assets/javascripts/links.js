$(document).ready(function() {
  populateLinksInbox();
})


function populateLinksInbox() {
  getAllLinks();
}

function getAllLinks() {
  $.ajax({
    url: "/api/v1/links",
    method: "GET"
  })
  .done(function(links_json) {
    getLinks(links_json).forEach(function(link) {
      console.log(link)
      $('#links-inbox').append(link.htmlTemplate())
    })
  })
}

function getLinks(links_json) {
  return links_json.map(function(link_json) {
    return new Link(link_json)
  })
}

function Link(params) {
  this.id = params['id']
  this.title = params['title']
  this.url = params['url']
  this.read = params['read']
}

Link.prototype.markAsReadOrUnread = function() {
  if(self.read) {
    return 'Mark As Unread'
  } else {
    return 'Mark As Read'
  }
}

Link.prototype.htmlTemplate = function() {
  return `<div class='link' id='link-${this.id}'>
    <p>Title: ${this.title}</p>
    <p>URL: ${this.url}</p>
    <p>Read?: ${this.read}</p>
  </div>`
}