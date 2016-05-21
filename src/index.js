'use strict';

require('bootstrap-loader');
// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var app = Elm.Main.embed(document.getElementById('main'));
