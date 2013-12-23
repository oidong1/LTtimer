
/**
 * Module dependencies.
 */

var express = require('express');
var routes = require('./routes');
var routesYoine = require('./routes/yoine');
var routesAdmin = require('./routes/admin');
var http = require('http');
var path = require('path');

var app = express();
count = 0;

// all environments
app.set('port', process.env.PORT || 61251);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use(express.favicon());
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/yoine', routesYoine.index);
app.get('/admin', routesAdmin.index);

server = http.createServer(app); // add
server.listen(app.get('port'), function(){ //add
  console.log("Express server listening on port " + app.get('port'));
});
var socketIO = require('socket.io');
var io = socketIO.listen(server);
io.set( "log level", 0 ); 
io.sockets.on('connection', function(socket) {
  console.log(count);
  io.sockets.emit('message', { value: count});
  socket.on('add', function(data) {
    count++;
    io.sockets.emit('message', { value: count });
  });
});
