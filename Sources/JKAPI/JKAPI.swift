//
// project 
// 
// Created By Junky on 2020/12/14
// email: <#Email#>
// github: <#github#>
//
// 
// 
// File.swift
// desc: None






import Foundation
import Alamofire
import JKCodable




public class JKAPI<T: Codable>: NSObject, API {
    
    public typealias Result = JKResponse<T>
    
    public var name: String = "未命名"
    
    public var url: String = "未指定"
    
    public var param: [String : Any]?
    
    public var header: HTTPHeaders?
    
    public var method: HTTPMethod = .get
    
    public var hudOption: HudOption = .none
    
    public var hudTarget: HudTarget?
    
    public var taskGroup: TaskGroup?
    
    public var didSuccessCallback: ((JKResponse<T>?) -> Void)?
    
    public var didFailureCallbakc: ((Error?) -> Void)?
    
    public var resuestTask: Request?
    
    public var responseObject: Data?
    
    public var error: Error?
    
    
}




public struct JKResponse<T: Codable>: Codable {
    
    
    public var code: Int? = 0
    
    public var message: String = ""
    
    public var ok: Bool = false
    
    public var data: T?
    
    public var meta: String?
    
    
}



