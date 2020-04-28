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
  // For loop goes through the collection list and displays them all. 
  db.collection('orders').get().then((snapshot) => {
    let getCoffee = snapshot.docs.map((doc) => {
      return doc.data();
    });
   
    // working on route for subcollection orders/products  
    /*
    db.collection("orders/" + getDoc.id + "/products").get().then((snapshot) => {

      let getProductDoc = snapshot.docs.map((doc) => {
        return doc.data();
      });
      console.log(getProductDoc);
    });
    */
   
    console.log(getCoffee)
    return res.json(getCoffee);

  }).catch((err) => {
    console.log('Error getting documents', err);
  });
});

/*
router.post("/testPost", (req, res) => {
  // used when sending to db
  const docRef = db.collection("coffee").doc();  
  
  // create object and sends to database collection coffee
  docRef.set({title: "new test from post"});

});
*/
// last
module.exports = router