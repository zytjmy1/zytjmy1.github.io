const express = require('express');
const axios = require('axios');
const cors = require('cors');
require('dotenv').config(); // 读取 .env 文件

const app = express();
const PORT = process.env.PORT || 3000;
const API_KEY = process.env.XAI_API_KEY; // 从环境变量获取 API Key
const API_ENDPOINT = 'https://api.x.ai/v1/chat/completions';

if (!API_KEY) {
    console.error('❌ 错误：未设置 XAI_API_KEY 环境变量');
    process.exit(1);
}

// 允许跨域请求（如果前端和后端不在同一服务器上）
app.use(cors());
app.use(express.json());

// 处理 POST 请求
app.post('/api/xai/chat', async (req, res) => {
    try {
        const response = await axios.post(API_ENDPOINT, req.body, {
            headers: {
                'Authorization': `Bearer ${API_KEY}`,
                'Content-Type': 'application/json'
            }
        });

        res.json(response.data);
    } catch (error) {
        console.error('调用 XAI API 失败:', error.response ? error.response.data : error.message);
        res.status(error.response?.status || 500).json({ error: error.response?.data || '服务器错误' });
    }
});

// 启动服务器
app.listen(PORT, () => {
    console.log(`🚀 服务器运行中： http://localhost:${PORT}`);
});
