$(document).ready(function() {
  getAllLinksFromAJAX()
  bindSubmitNewLink()
  bindMarkReadOrUnread()
  filterLinksByText()
  filterLinksByReadOrUnread()
})

function filterLinksByText() {
  $('#filter-links').keyup(function() {
    var links = createLinksFromPage()
    var filter = $(this).val()
    links.each(function() {
      this.filterByText(filter)
    })
  })
}

function filterLinksByReadOrUnread() {
  $('.filter-button').click(function() {
    var links = createLinksFromPage()
    var readButton = $(this).attr('id') == 'links-read-true'
    links.each(function() {
      this.filterByReadButton(readButton)
    })
  })
}

function createLinksFromPage() {
  return $('.link').map(function() {
    return new Link({
      title: $(this).find('.link-title').text(),
      url: $(this).find('.link-url').text(),
      read: $(this).find('.link-read').text() == 'true',
      id: parseInt($(this).attr('id').replace('link-', '')),
      hot: linkRankFromPage(this)
    })
  })
}

function linkRankFromPage(link) {
  if($(link).find('.link-top').length == 0) {
    return "top"
  } else if($(link).find('.link-hot').length == 0) {
    return "hot"
  } else {
    return ""
  }
}

function bindSubmitNewLink() {
  $('#new-link-submit').click(function(event) {
    event.preventDefault()
    postLink()
  })
}

function bindMarkReadOrUnread() {
  $('#links-inbox').on('click', '.mark', function(){
    var linkBox = $(this).parent()
    markLinkReadOrUnread(linkBox)
  })
}

function getAllLinksFromAJAX() {
  $.ajax({
    url: "/api/v1/links",
    method: "GET"
  })
  .done(function(links_json) {
    getLinksFromJSON(links_json).forEach(function(link) {
      link.addToPage()
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
      link.addToPage()
    },
    error: function(result) {
      displayFormErrors(result.responseJSON)
    }
  })
}

function markLinkReadOrUnread(linkBox) {
  var id = linkBox.attr('id').split('-')[1]
  var read = (linkBox.find('.link-read').text() == 'true')
  var linkData = {
    link: {
      read: !read
    }
  }

  $.ajax({
    url: '/api/v1/links/' + id,
    method: "PUT",
    data: linkData,
    success: function(result) {
      var link = new Link(result)
      link.appendLinkOnPage()
    }
  })
}

function resetLinkForm(){
  $('#form-title').val("")
  $('#form-url').val("")
  $('#form-errors ul').empty()
}

function getLinksFromJSON(links_json) {
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
  this.hot = params['hot']
}

Link.prototype.buttonRead = function() {
  if(this.read) {
    return 'Mark As Unread'
  } else {
    return 'Mark As Read'
  }
}

Link.prototype.hotRead = function() {
  if(this.hot == 'top') {
    return "<p><span class='link-top'>TOP LINK</span></p>"
  }else if(this.hot == 'hot') {
    return "<p><span class='link-hot'>HOT LINK</span></p>"
  }else{
    return ""
  }
}

Link.prototype.htmlTemplate = function() {
  return "<div class='link' id='link-" + this.id + "'>" +
    this.hotRead() +
    "<p>Title: <span class='link-title'>" + this.title + "</span></p>" +
    "<p>URL: <span class='link-url'>" + this.url + "</span></p>" +
    "<p>Read?: <span class='link-read'>" + this.read + "</span></p>" +
    "<button class='mark'>" + this.buttonRead() + "</button>" +
    "<a href='/links/" + this.id + "/edit' class='edit'><button>Edit</button></a>" +
  "</div>"
}

Link.prototype.filterByText = function(filter) {
  if(this.title.toLowerCase().indexOf(filter) == -1 && this.url.toLowerCase().indexOf(filter) == -1) {
    $('#link-' + this.id}).hide()
  } else {
    $('#link-' + this.id}).show()
  }
}

Link.prototype.filterByReadButton = function(filter) {
  if(this.read == filter) {
    $('#link-' + this.id}).show()
  } else {
    $('#link-' + this.id}).hide()
  }
}

Link.prototype.addToPage = function() {
  $('#links-inbox').append(this.htmlTemplate())
  if(!this.read) {
    $('#link-' + this.id).addClass('unread')
  }
}

Link.prototype.appendLinkOnPage = function() {
  $('#link-' + this.id).replaceWith(this.htmlTemplate())
  if(!this.read) {
    $('#link-' + this.id).addClass('unread')
  }
}
