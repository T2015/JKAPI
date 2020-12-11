//
// project 
// 
// Created By Junky on 2020/12/11
// email: <#Email#>
// github: <#github#>
//
// 
// 
// File.swift
// desc: None

import Foundation


/// 显示规则
public struct HudOption: OptionSet {
    public let rawValue: Int
    
    public static let loading = HudOption(rawValue: 1 << 0)
    public static let success = HudOption(rawValue: 1 << 1)
    public static let failure = HudOption(rawValue: 1 << 2)
    
    public static let none: HudOption = []
    public static let end: HudOption = [.success, .failure]
    public static let all: HudOption = [.loading, .success, .failure]
    
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}



/// 拓展本协议即可
public protocol HudTarget {
    
    
    /// 加载时
    func hudLoading(api: Any)
    
    
    /// 成功时
    func hudSuccess(api: Any)
    
    
    /// 失败时
    func hudFaulure(api: Any)
    
}




