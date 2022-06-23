//
//  APIManager.swift
//  SampleApp
//
//  Created by Jeffrey Cheung on 22/6/2022.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

class APIManager {
    private static let instance: APIManager = APIManager()
    let disposeBag = DisposeBag()
    
    public static func getInstance() -> APIManager {
        return instance
    }
    
    func getCharacters(url: URL, success: @escaping (CharacterModel?) -> ()) {
        requestData(.get, url)
            .debug()
            .subscribe(onNext: { (response, data) in
                print(response.statusCode)
                do {
                    let decodedData = try JSONDecoder().decode(CharacterModel.self, from: data)
                    success(decodedData)
                } catch {
                    print(error)
                    success(nil)
                }
            }, onError: { (error) in
                print(error)
                success(nil)
            }, onCompleted: {
                
            }, onDisposed: {
                
            }).disposed(by: disposeBag)
    }
}
