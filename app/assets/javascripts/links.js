$(document).ready(function() {
  populateLinksInbox()
  bindSubmitNewLink()
})

function bindSubmitNewLink() {
  $('#new-link-submit').click(function(event) {
    event.preventDefault()
    postLink()
  })
}

function populateLinksInbox() {
  getAllLinks()
}

function getAllLinks() {
  $.ajax({
    url: "/api/v1/links",
    method: "GET"
  })
  .done(function(links_json) {
    getLinks(links_json).forEach(function(link) {
      $('#links-inbox').append(link.htmlTemplate())
    })
  })
}

function postLink() {
  var linkData = {
    link: {
      title: $("#link_title").val(),
      url: $("#link_url").val()
    }
  }

  resetLinkForm()
  $.ajax({
    url: "/api/v1/links",
    method: "POST",
    data: linkData,
    success: function(result) {
      var link = new Link(result)
      $('#links-inbox').append(link.htmlTemplate())
    },
    error: function(result) {
      displayFormErrors(result.responseJSON)
    }
  })
}

function resetLinkForm(){
  console.log($('#form-errors ul'))
  $('#link_title').val("")
  $('#link_url').val("")
  $('#form-errors ul').empty()
}

function getLinks(links_json) {
  return links_json.map(function(link_json) {
    return new Link(link_json)
  })
}

function displayFormErrors(result) {
  result['error'].forEach(function(error_message){
    $('#form-errors ul').append('<li>' + error_message + '.</li>')
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