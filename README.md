# ai-finance-frontend
AI理财助手前端代码

## 如何连接后端

1. 确保后端 goAccounting 服务已启动（默认端口8080）。
2. 前端请求会通过 `$api-base-url` 变量访问后端接口，默认地址为 `http://localhost:8080`，如需修改请在 `uni.scss` 中调整。
3. 推荐前后端分别在不同终端窗口运行，开发时可使用代理或 CORS 支持。
