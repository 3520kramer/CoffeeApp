$(document).ready( () =>{

     // jquery getting our json order data from firebase
     $.get("http://localhost:8888/products", (data) => {    
       
      let rows = data.map(item => {

        let $clone = $('#itempage_new_table tfoot tr').clone();
    
        let productsName = item.products.map(prod => `${prod.name}`);
        $clone.find('.name').html(productsName.join('<br />'));

        
        let productsPrice = item.products.map(prod => `${prod.price} Kr.`);
        $clone.find('.price').html(productsPrice.join('<br />'));
        
        
        return $clone;
      });
      $("#itempage_new_table tbody").append(rows);
  });


})




