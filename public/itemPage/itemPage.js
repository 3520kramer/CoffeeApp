$(document).ready( () => {

  // dummy data over items - C0 story - 15-05-2020
  let items = [
    { id: "1", NAME: "Black Coffee", PRICE: 20},
    { id: "2", NAME: "Cappuccino", PRICE: 25},
    { id: "3", NAME: "Kaffe Latte", PRICE: 30},
    { id: "4", NAME: "Hot Chocolate", PRICE: 38},
    { id: "5", NAME: "Filter Kaffe", PRICE: 10},
    { id: "6", NAME: "Water", PRICE: 1230}
  ];
  
  $.each(items, function () {      
    $(`<div id = item-box>
      Id:          ${this.id}<br>
      Name:        ${this.NAME}<br>
      Price:       ${this.PRICE}<br><br>`
    ).appendTo("#item-box");        
  });

  //USER STORY C1 - 15-05-2020
  $("#addItem-button").click( () => {
    
    // object we enter data into
    let newItem = {
      id : 20,
      NAME : $("#name").val(),
      PRICE : $("#price").val(),
    };
    
    // goes trough list of items and adds to bottom of list 
    $("#item-box").length + 1;
    $("#item-box").last().append(
      `<div id = item-box>
      Id:          ${newItem.id}<br>
      Name:        ${newItem.NAME}<br>
      Price:       ${newItem.PRICE}<br><br>`
    );

    console.log(newItem);
    items.push(newItem);
    
  });

});



