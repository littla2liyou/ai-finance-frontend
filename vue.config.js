const path = require('path');

module.exports = {
  outputDir: 'dist/custom-h5', // 自定义 H5 构建输出路径
  assetsDir: 'static', // 静态资源目录
  configureWebpack: {
    // 其他 Webpack 配置
    resolve: {
      alias: {
        // 将 manifest.json 的路径指向项目根目录
        '@manifest': path.resolve(__dirname, 'manifest.json')
      }
    }
  },
  devServer: {
    port: 8080, // 开发服务器端口
  },
  pluginOptions: {
    // 配置 uni-app 使用根目录的 manifest.json
    'uni-app': {
      manifest: path.resolve(__dirname, 'manifest.json')
    }
  }
};
