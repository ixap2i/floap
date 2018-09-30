const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'public')
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        include: /src/,
        loader: 'babel-loader'
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        loader: ['style-loader', 'css-loader'],
      },
      {
        test: /\.vue$/,
        exclude: /node_modules/,
        loader: 'vue-loader',
        options: {
          loaders: {
          }
        }
      }
    ],
  },
  plugins: [
    new CopyWebpackPlugin([{
      from: path.resolve(__dirname, 'src', 'index.html'),
    }]),
  ],
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.js'
    },
  },
  devServer: {
    contentBase: 'public',
    port: 3000,
    host: 'localhost',
    historyApiFallback: true,
  },
};