// Framework for our server
const express = require("express");
const app = express();



// Makes public folder static, so it's always accessable    
app.use(express.static("public"));


// Routes 
app.get("/", (req, res) =>{
    console.log("frontpage");
    return res.sendFile(__dirname + "/public/frontpage/frontpage.html");
});

app.get(("/frontpage.js"), (req, res) => {
    console.log("frontpage.js");
    return res.sendFile(__dirname + "/public/frontpage/frontpage.js");
});

app.get(("/itemPage"), (req, res) => {
    return res.sendFile(__dirname + "/public/itemPage/itemPage.html");
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
