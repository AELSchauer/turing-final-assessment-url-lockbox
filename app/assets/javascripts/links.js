$(document).ready(function() {
  populateLinksInbox()
  bindSubmitNewLink()
  bindMarkReadOrUnread()
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

function bindMarkReadOrUnread() {
  $('#links-inbox').on('click', '.mark', function(){
    var linkBox = $(this).parent()
    markLinkReadOrUnread(linkBox)
  })
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
      title: $("#form-title").val(),
      url: $("#form-url").val()
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

function markLinkReadOrUnread(linkBox) {
  var id = parseInt(linkBox.attr('id').split('-')[1])
  var read = (linkBox.find('.link-read').text() == 'true')
  var linkData = {
    link: {
      read: !read
    }
  }

  $.ajax({
    url: `/api/v1/links/${id}`,
    method: "PUT",
    data: linkData,
    success: function(result) {
      var link = new Link(result)
      $(`#link-${link.id}`).replaceWith(link.htmlTemplate())
      if(link.read) {
        $(`#link-${link.id}`).addClass('unread')
      }
    }
  })
}

function resetLinkForm(){
  $('#form-title').val("")
  $('#form-url').val("")
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

Link.prototype.buttonRead = function() {
  if(this.read) {
    return 'Mark As Unread'
  } else {
    return 'Mark As Read'
  }
}

Link.prototype.htmlTemplate = function() {
  return `<div class='link' id='link-${this.id}'>
    <p>Title: <span class='link-title'>${this.title}</span></p>
    <p>URL: <span class='link-url'>${this.url}</span></p>
    <p>Read?: <span class='link-read'>${this.read}</span></p>
    <button class='mark'>${this.buttonRead()}</button>
    <a href='/links/${this.id}/edit' class='edit'><button>Edit</button></a>
  </div>`
}