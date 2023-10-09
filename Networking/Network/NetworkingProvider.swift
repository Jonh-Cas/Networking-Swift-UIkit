//
//  NetworkingProvider.swift
//  Networking
//
//  Created by Jonathan Casillas on 03/10/23.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    private let kBaseURLV2 = "https://gorest.co.in/public/v2/"
    private let kBaseURL = "https://gorest.co.in/public-api/"
    private let kStatusOk = 200...299
    private let kToken = "efbb14de93c864f766def0893c5254624f59e06bb53ad9d9fbf61d19496a350d"
    
    func getUser(id: Int, success: @escaping ( _ user: User ) -> (), failure: @escaping ( _ error: Error?  ) -> ()) {
        let url  = "\(kBaseURL)users/\(id)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: UserResponse.self, decoder: DateDecoder()) { response in
            print(response)
            if let user = response.value?.data {
                success( user )
            }else {
                failure( response.error )
            }
            
        }
        
    }
    
    func addUser( user: NewUser, success: @escaping ( _ user: User ) -> (), failure: @escaping ( _ error: Error? ) -> () ){
        
        let url = "\(kBaseURL)users"
        let headers: HTTPHeaders = [ .authorization(bearerToken: kToken) ]
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable(of: UserResponse.self, decoder: DateDecoder()) { response in
            
            if let user = response.value?.data, user.id != nil {
                success( user )
            }else {
                failure( response.error )
            }
            
        }
    }
    
    func updateUser( id: Int, user: NewUser, success: @escaping ( _ user: User ) -> (), failure: @escaping ( _ error: Error? ) -> () ){
        
        let url = "\(kBaseURL)users/\(id)"
        let headers: HTTPHeaders = [ .authorization(bearerToken: kToken) ]
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable(of: UserResponse.self, decoder: DateDecoder()) { response in
            
            if let user = response.value?.data, user.id != nil {
                success( user )
            }else {
                failure( response.error )
            }
            
        }
    }
    
    
    func deleteUser( id: Int, success: @escaping () -> (), failure: @escaping ( _ error: Error? ) -> () ){
        
        let url = "\(kBaseURL)users/\(id)"
        let headers: HTTPHeaders = [ .authorization(bearerToken: kToken) ]
        
        AF.request(url, method: .delete, headers: headers).validate(statusCode: kStatusOk).response { response in
        
            if let error = response.error {
                failure(error)
            }else{
                success()
            }
            
        }
    }
    
    
    
    func getUserV2(id: Int, success: @escaping ( _ user: UserRespV2 )-> (), failure: @escaping ( _ error: Error? ) -> () ){
        
        let url = "\(kBaseURLV2)users/\(id)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserRespV2.self ) { response in
            
            if let user = response.value {
                print("la data es ---> ", user)
                success( user )
            }else {
                print("el error es  ---> ", response.error?.responseCode ?? "No Error")
                failure( response.error )
            }
            
        }
        
    }
    
    
}
