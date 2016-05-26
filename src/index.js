'use strict';

require('bootstrap-loader');
require("font-awesome-webpack");
// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var app = Elm.Main.embed(document.getElementById('main'));

// initialize all popover elements
app.ports.popoverInit.subscribe(function() {
  var $ = require('jquery');
  $('[data-toggle="popover"]').popover();
});

app.ports.title.subscribe(function(title) {
  document.title = title;
});
