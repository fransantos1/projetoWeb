require('dotenv').config();
var express = require('express');
var path = require('path');
var cookieSession = require('cookie-session');
var morgan = require('morgan');

const {verify} = require("./config/updater");
setInterval(verify,1000);


var app = express();
app.use(cookieSession({
  name: 'session',
  secret: process.env.COOKIE_SECRET,
  // Cookie Options
  maxAge: 6 * 60 * 60 * 1000 // 6 hours
}))

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

const usersRouter = require("./routes/usersRoutes");
const carRouter = require("./routes/carRoutes");
const rentRouter = require("./routes/rentRoutes");
app.use("/api/rent",rentRouter);
app.use("/api/users",usersRouter);
app.use("/api/car",carRouter);

// when we don't find anything
app.use((req, res, next) => {
  res.status(404).send({msg:"No resource or page found."});
})

// When we find an error (means it was not treated previously)
app.use((err, req, res, next) => {
  console.error(err)
  res.status(500).send(err);
})

const port = parseInt(process.env.port || '8080');
app.listen(port,function() {
  console.log("Server running at http://localhost:"+port);
});