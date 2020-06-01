$(document).ready(() => {

    // event handler at the top-level inside doc.ready
    function deletedProduct() {
        let btn = $(this);
        let row = btn.closest("tr");
        let productId = row.data("productId");
        let shopId = row.data("shopId");

        $.ajax({
            method: "POST",
            url: "/deletedProduct",
            data: { 
                productId: productId,
                shopId: shopId,
            },
            success: function (status) {
                if (status === true) {
                    alert("Product has been deleted");
                    location.reload();
                } else {
                    alert("Something went wrong");
                }
            }
        });
    }


    // event listener
    $(document).on("click", ".deleteProduct", deletedProduct);

    
    // Jquery getting our json product data from API
    $.get("http://localhost:8888/products", (data) => {

        let shopId = data[0].id
            console.log(shopId);
        
        let rows = data[0].products.map(item => {

            let $clone = $('#frontpage_new_ordertable tfoot tr').clone();
            $clone.data("productId", item.id);
            $clone.data("shopId", shopId);
            

            $clone.find('.name').html(item.name);
            $clone.find('.price').html(item.price + " kr.");
            $clone.find('.size').html(item.size);
            $clone.find('.quantity').html(item.quantity);

            $clone.find('.buttons').html(`<button class="deleteProduct" type="button">Delete</button><br>`);

            return $clone;
        });
        
        console.log(rows)

        // appends to our frontpage html 
        $("#frontpage_new_ordertable tbody").append(rows);

    });


    // Get the modal
    var modal = document.getElementById("myModal");

    // Get the button that opens the modal
    var btn = document.getElementById("myBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on the button, open the modal
    btn.onclick = function () {
        modal.style.display = "block";
    };

    // When the user clicks on <span> (x), close the modal
    span.onclick = function () {
        modal.style.display = "none";
    };

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        };
    };
});