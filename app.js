// Framework for our server
const express = require("express");
const app = express();

// Makes public folder static, so it's always accessable    
app.use(express.static("public"));


// Routes 
app.get("/orderPage", (req, res) => {
    console.log("orderPage");
    return res.sendFile(__dirname + "/public/orderPage/orderPage.html");
});

app.get(("/itemPage"), (req, res) => {
    return res.sendFile(__dirname + "/public/itemPage/itemPage.html");
});

app.get(("/archive"), (req, res) => {
    return res.status(501).send({ response: "Not implmented yet" });
});

app.get(("/"), (req, res) => {
    return res.status(501).send({ response: "Not implmented yet" });
});


// import routes 
const firebaseRoute = require("./routes/firebase.js");
//set up routes with our server
app.use(firebaseRoute);


// Port we listen to for incoming trafic
const port = process.env.PORT ? process.env.PORT : 8888;


//eroor handling
const server = app.listen(port, (error) => {
    if (error) {
        console.log("Error starting the server");
    }
    console.log("This server is running on port", server.address().port);
});
