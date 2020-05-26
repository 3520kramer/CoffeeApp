$(document).ready( () => {

  // event handler at the top-level inside doc.ready
  function collectedOrder() {
    let btn = $(this);
    let row = btn.closest("tr");
    let id = row.data("id");
    let name = row.find(".customer_name").text();
    
    //console.log(id, name);

    $.ajax({
      method: "POST",
      url: "/collectedOrder",
      data: { 
        orderId: id, 
        customer_name: name,
      },
      success: function(status) {
        if (status === true) {
          alert("Order was moved to Archive");  
          location.reload();
        } else { 
          alert("something went wrong");
        }
      }
    });
  }

  // event handler at the top-level inside doc.ready
  function acceptedOrder() {
    let btn = $(this);
    let row = btn.closest("tr");
    let id = row.data("id");
    //let name = row.find(".customer_name").text();
    //console.log(id, name);

    $.ajax({
      method: "POST",
      url: "/acceptedOrder",
      data: { orderId: id },
      success: function(status) {
        if (status === true) {
          alert("Order has been accepted"); 
          location.reload();  
        } else { 
          alert("something went wrong");
        }
      }
    });
  }

    // event handler at the top-level inside doc.ready
    function canceledOrder() {
      let btn = $(this);
      let row = btn.closest("tr");
      let id = row.data("id");
      //console.log(id);

      $.ajax({
        method: "POST",
        url: "/canceledOrder",
        data: { orderId: id },
        success: function(status) {
          if (status === true) {
            alert("Order was deleted");
            location.reload();  
          } else { 
            alert("something went wrong");
          }
        }
      });
    }

  // event listener
  $(document).on("click", ".collectOrder", collectedOrder);
  $(document).on("click", ".acceptOrder", acceptedOrder);
  $(document).on("click", ".cancelOrder", canceledOrder);
  
  

  // Jquery getting our json order data from API
  $.get("http://localhost:8888/orderslist", (data) => {    
    
    let sorted = data.sort(function(a, b) {
        return parseFloat(a.time) - parseFloat(b.time);
    });
    // Loops through our orderlist api
    let rows = sorted.map(item => {
            
      let $clone = $('#frontpage_new_ordertable tfoot tr').clone();
      $clone.data("id", item.id);
      $clone.data("order_status", item.order_status);

      if (item.order_status === true) {
        //console.log(item.order_status);
        $clone.find('.order_status').html("<h4>Accepted</h4>");
      }

      $clone.find('.customer_name').text(item.customer_name);
      $clone.find('.date').text(item.date);
      
      let timeToString = item.time.toString();
      let timeToStringHour = timeToString.slice(0,2)
      let timeToStringMinute = timeToString.slice(2,4)
      let timeToStringFullTime = timeToStringHour+":"+timeToStringMinute 
      $clone.find('.time').text(timeToStringFullTime);
      
      $clone.find('.pickup').text(item.pickup);
      $clone.find('.comments').text(item.comments);
      $clone.find('.total').text(item.total + ' Kr.');

      // buttons to collect, accept and cancel an order
      $clone.find('.buttons').html(
        `<button class="collectOrder" type="button">Collect</button><br>` +
        `<button class="acceptOrder" type="button">Accept</button><br>` +
        `<button class="cancelOrder" type="button">Cancel</button><br>`        
      );


      // Loops through orders product name
      let productsName = item.products.map(prod => `${prod.name}`);
      $clone.find('.products').html(productsName.join('<br />'));
      
      // Loops through orders product price
      let productsPrice = item.products.map(prod => `${prod.price} Kr.`);
      $clone.find('.price').html(productsPrice.join('<br />'));

      return $clone;
    });
    
    // appends to our frontpage html 
    $("#frontpage_new_ordertable tbody").append(rows);
  

  });
});
