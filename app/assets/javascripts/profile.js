var div_categories_icons = document.querySelectorAll('.category-icon-container');
document.addEventListener("DOMContentLoaded", function(event) 
{
  if (div_categories_icons) {     
    div_categories_icons.forEach(function(element, key) {
      
      element.addEventListener('click', function () {
        categoryToggle(element, key);
      });

    });
  }
});

function categoryToggle(element, key) 
{
  if(element.classList.contains("category-icon-selected") == false) 
  {
    element.classList.toggle("category-icon-selected");
    
    set_params = {
      method: "GET", 
      url: "/analytics/"+document.body.dataset.userId+"/category/"+element.dataset.categoryId                       
    }
    send_request(set_params);

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