import request from './request.js'

export const categoryAPI = {
  // 获取分类列表
  getList(params = {}) {
    return request({
      url: '/category/list',
      method: 'GET',
      data: params
    })
  },

  // 创建分类
  create(data) {
    return request({
      url: '/category',
      method: 'POST',
      data
    })
  },

  // 更新分类
  update(id, data) {
    return request({
      url: `/category/${id}`,
      method: 'PUT',
      data
    })
  },

  // 删除分类
  delete(id) {
    return request({
      url: `/category/${id}`,
      method: 'DELETE'
    })
  }
}
