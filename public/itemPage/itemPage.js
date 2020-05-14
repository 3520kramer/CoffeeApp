$(document).ready( () =>{

      $.ajax({
        url:'http://localhost:8888/products',
        method:'GET',
        contentType: "application/json",    
        dataType:'json',
        success:function(response){
        var trHTML='';
          for(var i=0;i<response[0].products.length;i++){

              trHTML=trHTML+'<tr><td>'+response[0].products[i].name+'</td>'+
              '<td>'+response[0].products[i].size +'<td>'
              +response[0].products[i].price + '</td>' 
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
   

})




