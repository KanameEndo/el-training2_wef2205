const { environment } = require('@rails/webpacker')
//ここから
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)
//ここまで追加
module.exports = environment
