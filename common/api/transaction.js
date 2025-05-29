import request from './request.js'

export const transactionAPI = {
  // 创建交易记录
  create(data) {
    return request({
      url: '/user/transaction/',
      method: 'POST',
      data
    })
  },
  
  // 获取交易记录列表
  getList(data) {
    return request({
      url: '/user/transaction/list',
      method: 'GET',
      data
    })
  },
  
  // 获取单个交易记录
  getOne(id) {
    return request({
      url: `/user/transaction/${id}`,
      method: 'GET'
    })
  },
  
  // 更新交易记录
  update(id, data) {
    return request({
      url: `/user/transaction/${id}`,
      method: 'PUT',
      data
    })
  },
  
  // 删除交易记录
  delete(id) {
    return request({
      url: `/user/transaction/${id}`,
      method: 'DELETE'
    })
  },
  
  // 获取月度统计
  getMonthStatistic(data) {
    return request({
      url: '/user/transaction/statistic/month',
      method: 'GET',
      data
    })
  },
  
  // 获取分类统计
  getCategoryStats(data) {
    return request({
      url: '/user/transaction/statistic/category',
      method: 'GET',
      data
    })
  }
}
