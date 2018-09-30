process.env.NODE_ENV = process.env.NODE_ENV || 'development'
const { environment } = require('@rails/webpacker')

// const environment = require('./environment')

module.exports = environment.toWebpackConfig()


const vue =  require('./loaders/vue')

 environment.loaders.append('vue', vue)
 environment.loaders.append('babel', {
 test: /\.js\.vue$/,
  loader: 'babel-loader'
 })
