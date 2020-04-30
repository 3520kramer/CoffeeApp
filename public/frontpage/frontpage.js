// check if the js works
console.log("frontpage.js works");

//waits for the html doc to be ready before atempting to run any js.
$(document).ready( () =>{

    // jquery getting our json order data from firebase
    $.get("http://localhost:8888/orderslist", (data) => {    
        
        // i is for the index of the array of orders
        let i = 0;    
        //for each loop through our array list
        $.each(data, function () {
            //console.log(data)
            //console.log(i);
            // is how we arrange the data and show it to the frontpage
            $(`<table id = order_table_layout>
                    <tr>
                        <th>Customer</th>
                        <th>Date</th>
                        <th>Total</th>
                        <th>Order</th>
                        <th>Order Status</th>
                    </tr>
                    <tr>
                        <td>${data[i].customer_name}</td>
                        <td>${data[i].date}</td>
                        <td>${data[i].total} Kr.</td>
                        <td>${data[i].products}</td>
                        <td>

                        </td>
                    </tr>
                </table>`
            
            ).appendTo("#frontpage_new_ordertable");        
            // counts 1 up for each loop 
            i++;
            //console.log(i);
        });
    });




});
/*
<input type="button" onclick="${$("#frontpage_ready_ordertable").append(data[i])}" value="Ready"/>
<input type="button" onclick="insert(this)" value="Cancel"/>
*/