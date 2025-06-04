const BASE_URL = 'http://localhost:8080/api'

const request = (options) => {
  return new Promise((resolve, reject) => {
    // 添加token
    const token = uni.getStorageSync('token')
    
    // 构建请求参数
    const requestOptions = {
      url: BASE_URL + options.url,
      method: options.method || 'GET',
      header: {
        'Content-Type': 'application/json',
        ...options.header
      },
      success: (res) => {
        console.log('Request success:', res)
        if (res.statusCode === 200) {
          resolve(res.data)
        } else {
          console.error('Request failed with status:', res.statusCode, res.data)
          reject(res.data)
        }
      },
      fail: (err) => {
        console.error('Request failed:', err)
        reject(err)
      }
    }
    
    // 添加token到header
    if (token) {
      requestOptions.header.Authorization = `Bearer ${token}`
    }
    
    // 根据请求方法添加数据
    if (options.method === 'GET') {
      // GET请求将参数添加到URL
      if (options.data) {
        const params = new URLSearchParams(options.data).toString()
        requestOptions.url += (requestOptions.url.includes('?') ? '&' : '?') + params
      }
    } else {
      // 非GET请求将数据放在body中
      requestOptions.data = options.data
    }
    
    console.log('Making request:', requestOptions)
    uni.request(requestOptions)
  })
}

export default request
