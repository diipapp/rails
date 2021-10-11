
var div_categories_icons = document.querySelectorAll('.category-icon-container');
document.addEventListener("DOMContentLoaded", function(event) 
{
  if (div_categories_icons) {
    div_categories_icons.forEach(function(element, key) {
      
      element.addEventListener('click', function () {
        categoryChangeStatus(element, key);
        categoryToggle(element, key);
      });

    });
  }
});

function categoryChangeStatus(element, key)
{
  document.getElementById("add-new-tip-category-name").innerHTML = element.dataset.categoryName;
}

function categoryToggle(element, key) 
{
  if(element.classList.contains("category-icon-selected") == false) 
  {
    element.classList.toggle("category-icon-selected");
    
    document.getElementById(element.dataset.categoryId).classList.remove("category-block-unselected");
    document.getElementById(element.dataset.categoryId).classList.add("category-block-selected");

    div_categories_icons.forEach(function(element_sec, key_sec) {
      if(key !== key_sec) {
        element_sec.classList.remove('category-icon-selected');
        
        document.getElementById(element_sec.dataset.categoryId).classList.add("category-block-unselected");
        document.getElementById(element_sec.dataset.categoryId).classList.remove("category-block-selected");
      }
    });
  } 
}

function add() {
  let category_id          = document.querySelectorAll(".category-icon-selected")[0].dataset.categoryId;
  let block_insert_new_tip = document.getElementById("new-tip-aling-middle").innerHTML
  let link        = document.getElementById("url");
  
  if (validURL(link.value)) {
    loader_link(link);

    let set_params = {
      method: "POST", 
      url: "/users/piid",
      post_params: "category_id="+category_id+"&link="+link.value             
    }

    send_request(set_params, function(status, result) {
      
      document.getElementById("new-tip-aling-middle").innerHTML = block_insert_new_tip

      if (status == 404) {
        swal("", "Desculpe, não conseguimos entender esse link, já enviamos esse erro aos nossos time, tente enviar um outro link.", "error");
      } else {
        swal("", "Link adicionado com sucesso.", "success");

        let new_li = `
        <li id="` + result.tip_id + `">
          <div class="catalog-item">

          <div class="header-row">
          <span class="category-item-title">` + result.og_title + `</span>
          <img src="/assets/delete.png" onclick="delTip(this)">
          </div>

          <div class="content-row">
          <div class="col">
            <div class="row">
              <img class="thumbnail" src="` + result.og_image + `">
            </div>
          </div>
          </div>

          </div>
        </li>`;

        document.getElementById(category_id).insertAdjacentHTML('afterbegin', new_li)        
      }
    });
  }
}

function loader_link(link) {
  if (link.value) {
    content_loading = `
    <div id="loader">
      <div class="loader loader-9">
        <svg class="loader-star star1" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="23.172px" height="23.346px" viewBox="0 0 23.172 23.346" xml:space="preserve">
          <polygon fill="#2f80ed" points="11.586,0 8.864,8.9 0,8.9 7.193,14.447 4.471,23.346 11.586,17.84 18.739,23.346 16.77,14.985 23.172,8.9 14.306,8.9" />
        </svg>
        <svg class="loader-star star2" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="23.172px" height="23.346px" viewBox="0 0 23.172 23.346" xml:space="preserve">
          <polygon fill="#2f80ed" points="11.586,0 8.864,8.9 0,8.9 7.193,14.447 4.471,23.346 11.586,17.84 18.739,23.346 16.77,14.985 23.172,8.9 14.306,8.9  " />
        </svg>
        <svg class="loader-star star3" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="23.172px" height="23.346px" viewBox="0 0 23.172 23.346" xml:space="preserve">
          <polygon fill="#2f80ed" points="11.586,0 8.864,8.9 0,8.9 7.193,14.447 4.471,23.346 11.586,17.84 18.739,23.346 16.77,14.985 23.172,8.9 14.306,8.9  " />
        </svg>
      </div>
    </div>`;

    document.getElementById("new-tip-aling-middle").innerHTML = content_loading
  } else {
    link.classList.add('shake');
  }
}

function delTip(element)
{
  li_tip_id = element.closest("li")
  if (li_tip_id.hasAttribute('id') == true)
  {
    swal({
      title: "Você tem certeza?",
      text: "",
      icon: "warning",
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        
        element.closest("li").remove();

        swal("Link removido com sucesso.", {
          icon: "success",
        });

        set_params = {method: "DELETE", 
                      url: "/tips/"+li_tip_id.getAttribute("id")};
        
        send_request(set_params);

      }
    });
  } else { 
    element.closest("li").remove();
  }
}
