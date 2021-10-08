
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
  document.getElementById("category-selected-name").innerHTML = element.dataset.categoryName;
  document.getElementById("category-selected-recommendations-total").innerHTML = element.dataset.categoryRecommendationsTotal;
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

function addTip()
{
  category_id = document.querySelector(".category-icon-selected").dataset.categoryId
  category_ul = document.querySelector(`#${CSS.escape(category_id)}`)

  content_clone = `
    <div class="catalog-item">
      <div class="header-row">
        <span class="category-item-title">title</span>
        <img src="/assets/delete-2138c3ba66ecfb8e10fdf217b2282282b55b63a8e5256d8d321c3a9f636c2a61.png" onclick="delTip(this)">
      </div>
      
      <div class="content-row">
        <div class="col">
          <div class="input-wrapper">
            <span>🔗</span>
            <input type="text" placeholder="https://url" onchange="inputTipChange(this)">
          </div>
          <div class="row">
            <img class="thumbnail" src="/assets/placeImg-bf1410dd9367395877f232948cc1fb045f54e107bcb2a4c3d1b31d0b04f1d641.png">
          </div>
        </div>
      </div>
    </div>
  `;

  li = document.createElement("li");
  li.innerHTML = content_clone;

  category_ul.appendChild(li);
}

function inputTipChange(element)
{
  li_category_id_id = element.closest("ul").getAttribute("id")
  li_tip_id = element.closest("li")

  li_tip_id.querySelector(".thumbnail").src = '/assets/loading.gif';

  if (li_tip_id.hasAttribute('id') == true) {
    post_params = "category_id="+li_category_id_id+"&tip_id="+li_tip_id.getAttribute("id")+"&link="+element.value  
  } else {
    post_params = "category_id="+li_category_id_id+"&link="+element.value  
  }

  set_params = {method: "POST", 
                url: "/users/piid",
                post_params: post_params           
  }

  send_request(set_params, function(result) {
    li_tip_id.querySelector(".category-item-title").innerHTML = result['og_title'];
    li_tip_id.querySelector(".thumbnail").src = result['og_image'];
  });

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
