function copyDiipLink() 
{
    anchor = document.getElementById("diip-link");
    link = `https://${anchor.innerText}`;

    executeCopy(link);
}

function executeCopy(text) 
{
    input = document.createElement("textarea");
    userIdDiv = document.getElementById('clipboard-appender')
    userIdDiv.appendChild(input);
    input.value = text;
    input.focus();
    input.select();
    document.execCommand("Copy");
    input.remove();
}

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
    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
      callback(JSON.parse(xmlhttp.responseText));
    }
  }
}