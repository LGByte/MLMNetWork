//
//  ViewController.swift
//  MLMNetWork
//
//  Created by MengLiMing on 07/06/2020.
//  Copyright (c) 2020 MengLiMing. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MLMNetWork
import Alamofire
import HandyJSON
struct Login: Encodable {
    let email: String
    let password: String
}
class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testFunc()
        validateTest()
        let btn = UIButton(type: .custom)
        btn.setTitle("按钮", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.frame.size = CGSize(width: 100, height: 40)
        btn.center = view.center
        view.addSubview(btn)
        btn.rx.controlEvent(.touchUpInside).subscribe { (next) in
            self.validateTest()
        }.disposed(by: self.disposeBag)

    }
    
    func testFunc(){
        
        let login = Login(email: "test@test.test", password: "testPassword")
        
        AF.request("https://httpbin.org/post",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default) .response { response in
            debugPrint(response)
        }

    }
    
    func validateTest(){
        let url = "https://api.juejin.cn/tag_api/v1/query_category_briefs?aid=2608&uuid=7034072491513447969&show_type=2"
        AF.request(url)
            
        .responseJSON(completionHandler: { (res) in
                switch res.result {
                case .success(let sus) :
                    if let data = sus as? Dictionary<String, Any> ,let err_num = data["err_no"]{
                        print("\(err_num) ---")
                    }
//                    print("res \(sus)")
                break
                case .failure( _) :
                break
                default: break
                    
                }
            
            })
            .responseData { response in
                switch response.result {
                
                case .success(let data):
                 let res =   ""
                    print("Validation Successful \(data) -\(res)")
                case let .failure(error):
                    print(error)
                }
            }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _ = "https://api.juejin.cn/tag_api/v1/query_category_briefs?aid=2608&uuid=7034072491513447969&show_type=2"
//        validateTest()
        let request = Request<Casch>()
        request.path =  "/tag_api/v1/query_category_briefs?aid=2608&uuid=7034072491513447969&show_type=2"
        request.method = .get
//        request.parameters = [
//            "aid": "2608",
//            "uuid": "7034072491513447969",
//            "show_type": "2"
//        ]
        
        /// Completion
//        NetWorkClient.share.send(request) { (_, result) in
//            switch result {
//            case let .success(response):
//                print(response.entry ?? [])
//            case let .cache(response):
//                print(response.entry ?? [])
//            case let .failure(error):
//                print(error)
//            }
//        }
        
        // Success/Failure
//        NetWorkClient.share.send(request) { (_, response) in
//            print(response.entry ?? [])
//        } cacheHandler: { (_, response) in
//            print(response.entry ?? [])
//        } failureHandler: { (_, error) in
//            print(error)
//        }

        // RX
        NetWorkClient.share.rx.send(request).subscribe(onNext: {
            print($0.data ?? [])
        }).disposed(by: disposeBag)
    }
}

class Category: HandyJSON {
    var catId: Int?
    var catName: String?
    
    required init() { }
}

extension Dictionary {
    func jsonString(prettify: Bool = false) -> String? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: options) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
