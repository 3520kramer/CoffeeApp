// same as app function in app.js just called router
const router = require("express").Router();

//firebase server validation and connection
const admin = require("firebase-admin");
let serviceAccount = require("../test-3ad87-bc8cc74b3d08.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();





//test route for database 
router.get("/orderslist", (req, res) => {    
    
  let orders = []
  let number_of_orders
  
    // Getting the snapshot of the order collection
    db.collection('orders').get().then( productSnapshot => {
      number_of_orders = productSnapshot.size
  
      // iterating over the order snapshot
      productSnapshot.forEach(orderDoc => {
  
        // creating an order object and assigning the ID and the rest of the information from the database
        var order = {
          id: orderDoc.id,
          customer_name: orderDoc.data().customer_name,
          date: orderDoc.data().date,
          time: orderDoc.data().time,
          total: orderDoc.data().total,
          products: []
        }
        // using the id, to get the products from the subcollection
        db.collection('orders/' + order.id + '/products').get().then( productSnapshot => {
  
          // iterating over the product snapshot
          productSnapshot.forEach(productDoc => {
  
            // creating a product object
            var product = {
              name: productDoc.data().name,
              price: productDoc.data().price
            }
  
            //console.log('product', product)
  
            // then we push the product object to the list of products in the order object
            order.products.push(product)
  
          });
          //console.log('ordre: ', order)
  
          // we are finished iterating over the productsnapshot and now we can push it to the orders list
          orders.push(order)
  
          // checks if the list is filled with everything from the database
          if(orders.length == number_of_orders){
            //console.log('efter push', orders)
            //console.log('efter push', orders[1].products[0].name)
            return res.json(orders)
          }
  
        });
        //console.log('efter push', orders[0].products[0].name)
      });
  
      // console.log(orders)
      // console.log(number_of_orders)
      // console.log('This Works')
    
  });
    
});
    
  
//test route for database 
router.get("/products", (req, res) => {    
    
  let products = []
  let number_of_products
  
    // Getting the snapshot of the order collection
    db.collection('coffeeshops').get().then( productSnapshot => {
      number_of_products = productSnapshot.size
  
      // iterating over the order snapshot
      productSnapshot.forEach(coffeeshopDoc => {
  
        // creating an order object and assigning the ID and the rest of the information from the database
        var coffeeshop = {
          id: coffeeshopDoc.id,
          coordinates: coffeeshopDoc.data().coordinates,
          marker_description: coffeeshopDoc.data().marker_description,
          name: coffeeshopDoc.data().name,
          products: []
        }
        // using the id, to get the products from the subcollection
        db.collection('coffeeshops/' + coffeeshop.id + '/products').get().then( productSnapshot => {
        
          // iterating over the product snapshot
     
          productSnapshot.forEach(productDoc => {
            // creating a product object
            var product = {
              name: productDoc.data().name,
              price: productDoc.data().price
            }

            // then we push the product object to the list of products in the order object
            coffeeshop.products.push(product)
  
          });
  
          // we are finished iterating over the productsnapshot and now we can push it to the orders list
          products.push(coffeeshop)
  
          // checks if the list is filled with everything from the database
          if(products.length == number_of_products){
            return res.json(products)
          }
        });

      });
  
  });
});


// last
module.exports = router