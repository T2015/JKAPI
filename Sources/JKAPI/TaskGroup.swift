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



public protocol TaskGroup {
    /// hud显示配置
    var hudOption: HudOption { get }
    
    /// hud显示目标视图
    var hudTarget: HudTarget? { get }
    
    
    var taskEnd: (() -> Void)? { get set }
    
    
    func taskIn()
    
    func taskOut()
}


extension TaskGroup {
    
}
