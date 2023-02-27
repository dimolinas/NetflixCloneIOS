//
//  APICaller.swift
//  Netflix Clone
//
//  Created by MacBookPro on 24/02/23.
//

import Foundation

struct Constants {
    static let API_KEY = "03be78d134e2a0a09cb0167b2c4954c8"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIerror: Error{
    case failedToGetData
}

class APICaller{
    static let shared = APICaller()
    
    //func getTrendingMovies(completion: @escaping (String) -> Void){
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in guard let data,error == nil else{
                return
            }
            do {
                //print("data:",data)
                //let results = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
                //print(results.results[0])
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data )
                completion(.success(results.results))
                
            } catch {
                print("error in API call")
                //print(error)
                //print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[String], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in guard let data,error == nil else{
                return
            }
            do {
                let results = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
                print(results)
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
}
