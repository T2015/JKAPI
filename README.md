# JKAPI

> 基于Alamofire 的网络请求类的封装, 并通过Codable解析返回的数据, 面向协议，支持链式编程,一步到“胃”

```
JKAPI<[Model]>().set(name: "测试接口").set(url: <##您的链接##>).set(method: .get).set { (response) in
        // TODO: 刷新界面
        } didFailureCallbakc: { (error) in
        // TODO: 处理错误
        }.request()

```






