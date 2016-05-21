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
      { test: /\.(woff2?|svg)$/, loader: 'url?limit=10000' },
      { test: /\.(ttf|eot)$/, loader: 'file' },
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
  plugins: [
    //new webpack.optimize.UglifyJsPlugin({
    //  compress: {
    //      warnings: false
    //  }
    //}),
  ],
  devServer: {
    inline: true,
    stats: { colors: true },
  },
};
