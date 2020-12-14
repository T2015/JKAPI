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




class JKAPI<T: Codable>: NSObject, API {
    
    typealias Result = JKResponse<T>
    
    var name: String = "未命名"
    
    var url: String = "未指定"
    
    var param: [String : Any]?
    
    var header: HTTPHeaders?
    
    var method: HTTPMethod = .get
    
    var hudOption: HudOption = .none
    
    var hudTarget: HudTarget?
    
    var taskGroup: TaskGroup?
    
    var didSuccessCallback: ((JKResponse<T>?) -> Void)?
    
    var didFailureCallbakc: ((Error?) -> Void)?
    
    var resuestTask: Request?
    
    var responseObject: Data?
    
    var error: Error?
    
    
}




struct JKResponse<T: Codable>: Codable {
    
    
    public var code: Int? = 0
    
    public var message: String = ""
    
    public var ok: Bool = false
    
    public var data: T?
    
    public var meta: String?
    
    
}



