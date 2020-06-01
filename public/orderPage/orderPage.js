$(document).ready(() => {

    // event handler at the top-level inside doc.ready
    function collectedOrder() {
        let btn = $(this);
        let row = btn.closest("tr");
        let id = row.data("id");

        $.ajax({
            method: "POST",
            url: "/collectedOrder",
            data: { orderId: id },
            success: function (status) {
                if (status === true) {
                    alert("Order has been archived");
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

        $.ajax({
            method: "POST",
            url: "/acceptedOrder",
            data: { orderId: id },
            success: function (status) {
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

        $.ajax({
            method: "POST",
            url: "/canceledOrder",
            data: { orderId: id },
            success: function (status) {
                if (status === true) {
                    alert("Order was canceled");
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

        // sorts the json data from our get request by the time value
        let sorted = data.sort(function (a, b) {
            return parseFloat(a.time) - parseFloat(b.time);
        });

        // Loops through our orderlist api and sets up how the table should look like
        let rows = sorted.map(item => {

            let $clone = $('#frontpage_new_ordertable tfoot tr').clone();

            //this is data we don't display but use to be able to check diffrent things 
            $clone.data("id", item.id);
            $clone.data("coffeshop_id", item.coffeeshop_id);
            $clone.data("customer_email", item.customer_email);
            $clone.data("order_status", item.order_status);

            // this checks if the order has been accepted
            if (item.order_status === true) {
                $clone.find('.order_status').html("<h4>Accepted</h4>");
            }

            // this is data we display
            $clone.find('.customer_name').text(item.customer_name);
            $clone.find('.date').text(item.date);
            $clone.find('.comments').text(item.comments);

            // this is our time typecast because our time format is ex. number 103040. after cast its "10:30:40" = "hour:minute:second"
            let timeToString = item.time.toString();
            let timeToStringHour = timeToString.slice(0, 2);
            let timeToStringMinute = timeToString.slice(2, 4);
            let timeToStringSecond = timeToString.slice(4, 6);
            let timeToStringFullTime = timeToStringHour + ":" + timeToStringMinute + ":" + timeToStringSecond;
            $clone.find('.time').html(timeToStringFullTime + '<br><br>' + item.date);

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