function send_request(params, callback)
{
  xmlhttp = new XMLHttpRequest();

  if (params.method == "DELETE") {
    xmlhttp.open("DELETE", params.url);
  } else {
    xmlhttp.open(params.method, params.url, true);
  }

  if (params.method == "POST") {
    xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlhttp.send(params.post_params);
  } else {
    xmlhttp.send();
  }  

  xmlhttp.onload = function() {
    callback(xmlhttp.status, JSON.parse(xmlhttp.responseText));
  }
}

function validURL(url) {
  var res = url.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
  return (res !== null)
}