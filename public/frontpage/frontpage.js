// check if the js works
console.log("frontpage.js works");


//waits for the html doc to be ready before atempting to run any js.
$(document).ready( () =>{

  // add event listener here
  $(document).on("click", ".acceptOrder", acceptedOrder);

  // add the event handler at the top-level inside doc.ready
  function acceptedOrder() {
    let btn = $(this);
    let row = btn.closest("tr");
    let id = row.data("id");
    let name = row.find(".customer_name").text();
    console.log(id, name);
    $(row).css("background-color", "green");
    $.post('/acceptedOrder', { orderId: id });
  }


  // add event listener here
  $(document).on("click", ".cancelOrder", canceledOrder);

  // add the event handler at the top-level inside doc.ready
  function canceledOrder() {
    let btn = $(this);
    let row = btn.closest("tr");
    let id = row.data("id");
    console.log(id);

    $.post('/canceledOrder', { orderId: id });
  }

    // jquery getting our json order data from API
    $.get("http://localhost:8888/orderslist", (data) => {    
       

        // loops through our orderlist api
        let rows = data.map(item => {
          let $clone = $('#frontpage_new_ordertable tfoot tr').clone();
          $clone.data("id", item.id);
          $clone.find('.customer_name').text(item.customer_name);
          $clone.find('.date').text(item.date);
          $clone.find('.time').text(item.time);
          $clone.find('.pickup').text(item.pickup);
          $clone.find('.comments').text(item.comments);
          $clone.find('.total').text(item.total + ' Kr.');


          // accept and cancel buttons
          $clone.find('.order_status').html(
            `<button class="acceptOrder" type="button">Accept</button>` + 
            `<button class="cancelOrder" type="button">Cancel</button>`
          );

          // loops through orders product name
          let productsName = item.products.map(prod => `${prod.name}`);
          $clone.find('.products').html(productsName.join('<br />'));
          
          // loops through orders product price
          let productsPrice = item.products.map(prod => `${prod.price} Kr.`);
          $clone.find('.price').html(productsPrice.join('<br />'));

          return $clone;
        });

        $('th').click(function(){
          var table = $(this).parents('table').eq(0)
          var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
          this.asc = !this.asc
          if (!this.asc){rows = rows.reverse()}
          for (var i = 0; i < rows.length; i++){table.append(rows[i])}
      })
      function comparer(index) {
          return function(a, b) {
              var valA = getCellValue(a, index), valB = getCellValue(b, index)
              return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
          }
      }
      function getCellValue(row, index){ return $(row).children('td').eq(index).text() }

        

        //appends to our frontpage html 
        $("#frontpage_new_ordertable tbody").append(rows);
    });

});
