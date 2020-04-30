// check if the js works
console.log("frontpage.js works");

//waits for the html doc to be ready before atempting to run any js.
$(document).ready( () =>{

    // jquery getting our json order data from firebase
    $.get("http://localhost:8888/orderslist", (data) => {    
       
        let rows = data.map(item => {
          let $clone = $('#frontpage_new_ordertable tfoot tr').clone();
          $clone.find('.customer-name').text(item.customer_name);
          $clone.find('.date').text(item.date);
          $clone.find('.time').text(item.time);
          $clone.find('.total').text(item.total + ' Kr.');
      
          let products = item.products.map(prod => `${prod.name}: ${prod.price} Kr.`);
          $clone.find('.products').html(products.join('<br />'));
          return $clone;
        });
      
        $("#frontpage_new_ordertable tbody").append(rows);
    });

});
/*
<input type="button" onclick="${$("#frontpage_ready_ordertable").append(data[i])}" value="Ready"/>
<input type="button" onclick="insert(this)" value="Cancel"/>
*/