
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
  let category_id = document.querySelectorAll(".category-icon-selected")[0].dataset.categoryId;
  let link        = document.getElementById("url");
  
  if (validURL(link.value)) {
    loader_link(link);

    let set_params = {
      method: "POST", 
      url: "/users/piid",
      post_params: "category_id="+category_id+"&link="+link.value             
    }

    send_request(set_params, function(status, result) {
      
      if (status == 404) {
        swal("", "Desculpe, não conseguimos entender esse link, já enviamos esse erro aos nossos time.", "error");

        error_extract_link = `
          <div id="error_404">
            <p class="emoji">😔</p>
            <p></p>
          </div>
        `;
    
        // document.getElementById("new-tip-aling-middle").innerHTML = error_extract_link
      } else {
        swal("", "Link adicionado com sucesso.", "success");
      }

      // var ul_category    = document.getElementById(category_id);
      // var last_li = ul_category.children[ul_category.children.length - 1];

      

      // ul.find('li:first').clone(true).appendTo(ul);

      // let node = document.createElement("li");

      // content_loading = `
      //   <div class="catalog-item">
          
      //     <div class="header-row">
      //       <span class="category-item-title">Titulo</span>
      //       <img src="/assets/delete.png" onclick="delTip(this)">
      //     </div>

      //       <div class="content-row">
      //       <div class="col">
      //         <div class="row">
      //           <img class="thumbnail" src="<%= recomendation.image %>">
      //         </div>
      //       </div>
      //     </div>

      //   </div>`;

      // let textnode = document.createTextNode(content_loading);
      // node.appendChild(textnode);

      // document.getElementById(category_id).appendChild(node);
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
      title: text_are_you_are,
      text: text_are_you_are_2,
      icon: "warning",
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        
        element.closest("li").remove();

        swal(text_remove_sucess, {
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
