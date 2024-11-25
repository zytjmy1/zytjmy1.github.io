const express = require('express');
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 3000;

// 使用中间件解析 JSON 请求体
app.use(express.json());

// 处理 POST 请求
app.post('/api/xai', async (req, res) => {
  const { data } = req.body;
  const apiKey = 'YOUR_API_KEY'; // 替换为你的实际 API 密钥
  const apiEndpoint = 'https://api.x.ai/v1/query'; // 确认 X.ai API 的实际端点

  try {
    const response = await axios.post(apiEndpoint, { data }, {
      headers: {
        'Authorization': `Bearer ${apiKey}`
      }
    });

    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// 启动服务器
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
