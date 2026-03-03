# 性价比之王来了！Gemini 3.1 Flash-Lite 上手指南

大家好，我是老里。

昨天 Google 发了个新模型，Gemini 3.1 Flash-Lite。

输入 $0.25/百万 Token，输出 $1.50/百万 Token。

我第一反应：这价格，终于可以放开用了。

---

## 一、三个核心特点

### 1. 便宜又快

价格比 GPT-4 便宜120倍。

输出速度比上一代快45%，首token响应快2.5倍。

算笔账：处理1000万条评论，GPT-4 要几千块，Flash-Lite 只要几百块。

而且速度快一倍。

### 2. 可以控制"思考深度"

这个功能挺有意思。

简单任务（翻译、审核）用低级别，快速便宜。

复杂任务（代码生成、UI设计）用高级别，准确深度。

以前简单任务也要用完整版模型，浪费钱。现在按需付费，成本能省30-50%。

### 3. 一个模型搞定所有场景

能处理高频任务（内容审核、实时翻译）。

也能处理复杂任务（生成UI、遵循详细指令）。

不用维护多个模型版本了。

---

## 二、性能数据

我查了一些第三方数据：

Arena.ai Elo 分数：1432，排名中上游。

基准测试：GPQA Diamond 86.9%，MMMU Pro 76.8%。

对比上一代：速度快45%，质量持平或略好，价格差不多。

**结论：不是最强的，但可能是最实用的。**

---

## 三、什么时候该用？

**高频API调用**

内容审核、实时翻译、客服机器人这些场景，速度快意味着服务器成本低。

虽然单价比 GPT-4o mini 贵，但综合成本可能更低。

**界面生成和复杂指令**

Google 官方特别提到这个场景。

生成UI、执行复杂指令、创建模拟，Flash-Lite 都能搞定。

支持高思考级别，质量够用，成本可控。

**批量处理**

数据清洗、文档分类、邮件自动回复。

速度快，处理时间短。思考级别可控，成本也可控。

**不适合的场景：**

长文本生成（输出token贵）、最高质量要求（学术研究、法律文书）。

---

## 四、对比其他模型

**vs GPT-4o mini**

GPT-4o mini 便宜（$0.15/$0.60），但 Flash-Lite 快2.5倍。

实时性要求高选 Flash-Lite，纯粹追求便宜选 GPT-4o mini。

**vs Claude Haiku**

价格差不多，Flash-Lite 更快，Haiku 更稳定。

看生态，Google 生态选 Flash-Lite，Anthropic 生态选 Haiku。

**vs DeepSeek**

DeepSeek 最便宜（$0.14/$0.28），但 Flash-Lite 质量明显更好，速度也快很多。

预算紧张选 DeepSeek，追求质量和速度选 Flash-Lite。

---

## 五、怎么开始用？

**方案1：Google AI Studio**

网页版，免费试用，不用写代码。

适合快速测试和验证想法。

地址：https://aistudio.google.com/

**方案2：Vertex AI**

企业级，按量付费，稳定性好。

需要 Google Cloud 账号。

适合生产环境和大规模部署。

**方案3：API 调用**

```python
import google.generativeai as genai

genai.configure(api_key="YOUR_API_KEY")
model = genai.GenerativeModel('gemini-3.1-flash-lite')

response = model.generate_content(
    "翻译成英文：你好，世界",
    generation_config={"thinking_level": "low"}
)

print(response.text)
```

thinking_level 可选 low/medium/high，简单任务用 low，复杂任务用 high。

---

如果你在做高频API调用，Flash-Lite 值得试试。

以上，既然看到这里了，如果觉得不错，随手点个赞、在看、转发三连吧，如果想第一时间收到推送，也可以给我个星标⭐️～

感谢你看我的文章，我们，下次再见。
