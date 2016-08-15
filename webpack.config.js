var path = require("path"),
    webpack = require('webpack');

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: 'app.js',
  },

  module: {
    loaders: [
      { test: /bootstrap-sass[\/\\]assets[\/\\]javascripts[\/\\]/, loader: 'imports?jQuery=jquery' },
      { test: /\.(woff2?|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: 'url?limit=10000' },
      { test: /\.(ttf|eot)(\?v=[0-9]\.[0-9]\.[0-9])?$/, loader: 'file' },
      {
        test:    /\.html$/,
        include: /src/,
        loader:  'file?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        include: /src/,
        loader:  'elm-hot!elm-webpack?warn=true',
      }
    ],

    noParse: /\.elm$/,
  },

  devServer: {
    inline: true,
    stats: 'errors-only',
    historyApiFallback: true
  },
};
