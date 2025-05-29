import request from './request.js'

export const userAPI = {
  // 用户登录
  login(data) {
    return request({
      url: '/public/user/login',
      method: 'POST',
      data
    })
  },
  
  // 用户注册
  register(data) {
    return request({
      url: '/public/user/register',
      method: 'POST',
      data
    })
  },
  
  // 获取用户主页数据
  getHome() {
    return request({
      url: '/user/home',
      method: 'GET'
    })
  },
  
  // 更新用户信息
  updateInfo(data) {
    return request({
      url: '/user/info',
      method: 'PUT',
      data
    })
  },
  
  // 修改密码
  updatePassword(data) {
    return request({
      url: '/user/password',
      method: 'PUT',
      data
    })
  },
  
  // 获取用户统计
  getStats() {
    return request({
      url: '/user/stats',
      method: 'GET'
    })
  }
}
