$(document).ready( () =>{

     // jquery getting our json order data from firebase
     $.get("http://localhost:8888/products", (data) => {    
       
      let rows = data.map(item => {
        let $clone = $('#itempage_new_table tfoot tr').clone();
    
        let productsName = item.products.map(prod => `${prod.name}:`);
        let productsPrice = item.products.map(prod => `${prod.price} Kr.`);
        $clone.find('.name').html(productsName.join('<br />'));
        $clone.find('.price').html(productsPrice.join('<br />'));
        return $clone;
      });
    
      $("#itempage_new_table tbody").append(rows);
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




