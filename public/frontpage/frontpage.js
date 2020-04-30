// check if the js works
console.log("frontpage.js works");

//waits for the html doc to be ready before atempting to run any js.
$(document).ready( () =>{

    // jquery getting our json order data from API
    $.get("http://localhost:8888/orderslist", (data) => {    
       
        // loops through our orderlist api
        let rows = data.map(item => {
          let $clone = $('#frontpage_new_ordertable tfoot tr').clone();
          $clone.find('.customer_name').text(item.customer_name);
          $clone.find('.date').text(item.date);
          $clone.find('.time').text(item.time);
          $clone.find('.total').text(item.total + ' Kr.');
      
          // loops through orders product name
          let productsName = item.products.map(prod => `${prod.name}`);
          $clone.find('.products').html(productsName.join('<br />'));
          
          // loops through orders product price
          let productsPrice = item.products.map(prod => `${prod.price} Kr.`);
          $clone.find('.price').html(productsPrice.join('<br />'));
          
          
          return $clone;
        });
        //appends to our frontpage html 
        $("#frontpage_new_ordertable tbody").append(rows);
    });

});
/*
<input type="button" onclick="${$("#frontpage_ready_ordertable").append(data[i])}" value="Ready"/>
<input type="button" onclick="insert(this)" value="Cancel"/>
*/