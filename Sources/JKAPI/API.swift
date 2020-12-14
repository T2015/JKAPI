
import Foundation
import UIKit
import Alamofire
import JKCodable







public protocol API: NSObjectProtocol {
    
    
    associatedtype Result where Result: Codable
    
    /// 易读属性
    var name: String { get set }
    
    /// 请求时的完整Url
    var url: String { get set }
    
    /// 参数
    var param: [String: Any]? { get set }
    
    /// 请求头
    var header: HTTPHeaders? { get set }
    
    /// 请求方法
    var method: HTTPMethod { get set }
    
    /// hud显示配置
    var hudOption: HudOption { get set }
    
    /// hud显示目标视图
    var hudTarget: HudTarget? { get set }
    
    /// 任务组
    var taskGroup: TaskGroup? { get set }
    
    
    /// 成功回调
    var didSuccessCallback: ((Result?) -> Void)? { get set }
    
    /// 失败回调
    var didFailureCallbakc: ((Error?) -> Void)? { get set }
    
    
    
    var resuestTask: Request? { get set }
    
    
    /// 请求成功时返回的原始数据
    var responseObject: Data? { get set }
    
    
    /// 请求失败时返回的错误信息
    var error: Error? { get set }
    
    
    
    
    
    
}

public extension API {
    
    
    @discardableResult func set(name: String) -> Self {
        self.name = name
        return self
    }
    
    @discardableResult func set(url: String) -> Self {
        self.url = url
        return self
    }
    
    @discardableResult func set(param: [String: Any]) -> Self {
        self.param = param
        return self
    }
    
    @discardableResult func set(header: HTTPHeaders) -> Self {
        self.header = header
        return self
    }
    
    @discardableResult func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    @discardableResult func set(hudOption: HudOption) -> Self {
        self.hudOption = hudOption
        return self
    }
    
    @discardableResult func set(hudTarget: HudTarget) -> Self {
        self.hudTarget = hudTarget
        return self
    }
    
    @discardableResult func set(taskGroup: TaskGroup) -> Self {
        self.taskGroup = taskGroup
        return self
    }
    
    @discardableResult func set(didSuccessCallback: @escaping (Result?) -> Void) -> Self {
        self.didSuccessCallback = didSuccessCallback
        return self
    }
    
    @discardableResult func set(didFailureCallbakc: @escaping (Error?) -> Void) -> Self {
        self.didFailureCallbakc = didFailureCallbakc
        return self
    }
    
    @discardableResult func set(didSuccessCallback: @escaping (Result?) -> Void, didFailureCallbakc: @escaping (Error?) -> Void) -> Self {
        self.didSuccessCallback = didSuccessCallback
        self.didFailureCallbakc = didFailureCallbakc
        return self
    }
    
    
    
    
    
    
    func request() {
        
        shouldRequest()
        resuestTask = AF.request(url, method: method, parameters: param, headers: header).responseData { (responseData) in
            
            self.didResponse(response: responseData)
        }
        
    }
    
    
    /// 将要开始，校验请求
    func shouldRequest(){
        
        // * group
        if let group = taskGroup {
            group.taskIn()
        }
        
        
        // * Hud
        if taskGroup == nil && hudOption.contains(.loading) {
            if let target = hudTarget {
                target.hudLoading(api: self)
            }
        }
    }
    
    
    /// 请求结束，处理结果
    func didResponse(response: AFDataResponse<Data>) {
        
        // * group
        if let group = taskGroup {
            group.taskOut()
        }
        
        switch response.result {
        case .success(let data):
            self.responseObject = data
        case .failure(let error):
            self.error = error
        }
        
        if let _ = error {
            didFailure()
        }else{
            didSuccess()
        }
        
        self.resuestTask = nil
    }
    
    
    
    /// 成功
    func didSuccess() {
        
        // * Hud
        if taskGroup == nil && hudOption.contains(.success) {
            if let target = hudTarget {
                target.hudSuccess(api: self)
            }
        }
        
        var resultObject: Result? = nil
        if let data = responseObject {
            resultObject = Result.fromData(data)
        }
        if let callback = didSuccessCallback {
            callback(resultObject)
        }
        
    }
    
    /// 失败
    func didFailure() {
        
        // * Hud
        if taskGroup == nil && hudOption.contains(.failure) {
            if let target = hudTarget {
                target.hudFaulure(api: self)
            }
        }
        
        if let callback = didFailureCallbakc {
            callback(error)
        }
    }
    
    
    
}


