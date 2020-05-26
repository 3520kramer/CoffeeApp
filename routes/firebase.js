// same as app function in app.js just called router
const router = require("express").Router();

//firebase server validation and connection
const admin = require("firebase-admin");
let serviceAccount = require("../test-3ad87-bc8cc74b3d08.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const bodyParser = require("body-parser");

/** bodyParser.urlencoded(options)
 * Parses the text as URL encoded data (which is how browsers tend to send form data from regular forms set to POST)
 * and exposes the resulting object (containing the keys and values) on req.body
 */
router.use(bodyParser.urlencoded({
    extended: true
}));

/**bodyParser.json(options)
 * Parses the text as JSON and exposes the resulting object on req.body.
 */
router.use(bodyParser.json());

router.post("/collectedOrder", function (req, res) {
  //console.log(req.body);
  //console.log(req.body.orderId)

  let archivedOrder = {
    customer_name: req.body.customer_name
  }
  
  db.collection('archives').doc(req.body.orderId).set(archivedOrder);
  // db.collection('orders').doc(req.body.orderId).delete();
  return res.status(202).send(true);
});

router.post("/acceptedOrder", function (req, res) {
  //console.log(req.body.orderId);
  db.collection('orders').doc(req.body.orderId).update({order_status: true});
  return res.status(202).send(true);
});


router.post("/canceledOrder", function (req, res) {
  db.collection('orders').doc(req.body.orderId).update({order_status: false});
  // db.collection('orders').doc(req.body.orderId).delete();
  return res.status(202).send(true);
});



router.post("/newProduct", function (req, res) {

    var newProduct = {
      name: req.body.name,
      price: req.body.price,
      size: req.body.size,
      quantity: req.body.quantity
    }

    let setDoc = db.collection('coffeeshops').doc('FVFkkD7s8xNdDgh3zAyd').collection("products").add(newProduct);
});

// route for database 
router.get("/orderslist", (req, res) => {    
    
  let orders = []
  let number_of_orders
  
    // Getting the snapshot of the order collection
    db.collection('orders').orderBy('time').get().then( productSnapshot => {
      number_of_orders = productSnapshot.size
  
      // iterating over the order snapshot
      productSnapshot.forEach(orderDoc => {
  
        // creating an order object and assigning the ID and the rest of the information from the database
        var order = {
          id: orderDoc.id,
          customer_name: orderDoc.data().customer_name,
          date: orderDoc.data().date,
          comments: orderDoc.data().comments,
          time: orderDoc.data().time,
          total: orderDoc.data().total,
          order_status: orderDoc.data().order_status,
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
  
            // then we push the product object to the list of products in the order object
            order.products.push(product)
  
          });
  
          // we are finished iterating over the productsnapshot and now we can push it to the orders list
          orders.push(order)
  
          // checks if the list is filled with everything from the database
          if(orders.length == number_of_orders){
            return res.json(orders)
          }
  
        });

      });
  
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
              price: productDoc.data().price,
              size: productDoc.data().size,
              quantity: productDoc.data().quantity
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