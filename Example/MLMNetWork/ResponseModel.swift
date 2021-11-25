//
//  ResponseModel.swift
//  MLMNetWork_Example
//
//  Created by 孟利明 on 2020/8/6.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import HandyJSON
import MLMNetWork

struct Casch: HandyJSON {
    /**
    {
                "category_id": "6809637769959178254",
                "category_name": "后端",
                "category_url": "backend",
                "rank": 1,
                "back_ground": "https://lc-mhke0kuv.cn-n1.lcfile.com/fb3b208d06e6fe32.png",
                "icon": "https://lc-mhke0kuv.cn-n1.lcfile.com/a2ec01b816abd4c5.png",
                "ctime": 1457483880,
                "mtime": 1432503193,
                "show_type": 3,
                "item_type": 2,
                "promote_tag_cap": 4,
                "promote_priority": 1
            },
     */
    var category_id:String?
    var back_ground:String?
    var category_url:String?
}
/// 业务数据模型
final class ResponseModel<T> {
    var entry: T?
    var responseCode: Int?
    var status: Bool = false
    var message: String?
    
    var data:Array<Casch>?
    var err_no:Int?
    var err_msg:Int?
    
    required init() { }
}

extension ResponseModel: HandyJSON, Parsable { }

extension ResponseModel: ErrorJudge {
    var errorCode: Int {
        return self.responseCode ?? -1000
    }
    
    var errorMessage: String {
        return self.message ?? "未知错误信息"
    }
    
    var isSuccess: Bool {
        return self.status
    }
    
    func errorOccurs() {
        /// 发生错误时处理 如跳转登录等
        
    }
}
