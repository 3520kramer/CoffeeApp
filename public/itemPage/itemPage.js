$(document).ready( () =>{

  $.get("http://localhost:8888/products", (data) => {    
      let i = 0;    
      $.each(data, function () {
           
  
      $(`<div id = item-box>
          Product name:   ${data[i].name}<br>
          Price:       ${data[i].price}<br><br>`
      ).appendTo("#item-box");        
      i++;

      
      });
  });
  var product = firebase.database().ref("coffeshop/get.Doc.");

  // Save a new product to the database, using the input in the form
  var submitProduct = function () {
  
    // Get input values from each of the form elements
    var name = $("#name").val();
    var price = $("#price").val();
  
    // Push a new recommendation to the database using those values
    product.push({
      "name": name,
      "price": price,
    });
  };
  console.log(price + "" + name)

})




