$(document).ready( () => {

  $.ajax({
    url:'http://localhost:8888/products',
    method:'GET',
    contentType: "application/json",    
    dataType:'json',
    success:function(response) {
    var trHTML='';
      for(var i=0;i<response[0].products.length;i++){
          trHTML=trHTML+'<tr><td>'+response[0].products[i].name+'</td>'+
          '<td>'+response[0].products[i].size +'<td>'
          +response[0].products[i].price + '</td><td>' 
          +response[0].products[i].quantity + '</td>' 
        }
    
      $('#itempage_table').append(trHTML);
      
    },
    error:function(response){
    }
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
   


  // Get the modal
  var modal = document.getElementById("myModal");

  // Get the button that opens the modal
  var btn = document.getElementById("myBtn");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];

  // When the user clicks on the button, open the modal
  btn.onclick = function() {
    modal.style.display = "block";
  };

  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
    modal.style.display = "none";
  };

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    };
  };
});




