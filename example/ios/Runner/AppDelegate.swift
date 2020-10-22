import UIKit
import g_faraday
import Alamofire

@UIApplicationMain
@objc class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        UINavigationController.fa.automaticallyHandleNavigationBarHiden()
        
        Faraday.sharedInstance.startFlutterEngine(navigatorDelegate: self, httpProvider: self, commonHandler: self.handle(_:_:_:), automaticallyRegisterPlugins: true)
        
        return true
    }
}

extension AppDelegate: FaradayNavigationDelegate {
    
    func push(_ name: String, arguments: Any?, options: [String : Any]?) -> UIViewController? {
        
        let isFultter = options?["flutterRoute"] as? Bool ?? false
        let isPresent = options?["present"] as? Bool ?? false
        
        let vc = isFultter ? FaradayFlutterViewController(name, arguments: arguments) : FirstViewController()
        
        let topMost = UIViewController.fa.topMost
        if (isPresent) {
            topMost?.present(vc, animated: true, completion: nil)
        } else {
            topMost?.navigationController?.pushViewController(vc, animated: true)
        }
        
        return vc
    }
}

public protocol FlutterPage {
    
    var name: String { get }
    var arguments: Any? { get }
}

enum FPage: FlutterPage {
    
    case flutterTab1
    case flutterTab2
    case flutter
    
    var name: String {
        switch self {
            case .flutterTab1:
                return "flutter_tab_1"
            case .flutterTab2:
                return "flutter_tab_2"
            default:
                return "flutter"
        }
    }
    
    var arguments: Any? { return [:] }
}

extension FlutterPage {
    
    func flutterViewController(callback: @escaping (Any?) -> Void) -> UIViewController {
        return FaradayFlutterViewController(name, arguments: arguments, callback: callback)
    }
}


extension AppDelegate: FaradayCommonHandler {
    func showLoading(_ message: String) -> Any? {
        return nil
    }
    
    func getSomeData(_ id: String, _ optionalArg: Bool?) -> Any? {
        return ["name": "test"]
    }
    
    func setSomeData(_ data: Any, _ id: String) -> Any? {
        //
        return true
    }
    
}

extension AppDelegate: FaradayHttpProvider {

    func request(method: String, url: String, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (Any?) -> Void) {
        let afHeaders = headers.map { HTTPHeaders($0) }
        let dataRequest = AF.request(url, method: HTTPMethod(rawValue: method.uppercased()), parameters: parameters, headers: afHeaders)
        dataRequest.responseJSON { response in
            switch response.result {
                case .success(let data):
                    completion(["data": data, "errorCode": 0])
                case .failure(let error):
                    completion(["message": error.localizedDescription, "errorCode": error.responseCode ?? 1])
            }
        }
    }

}
