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
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in guard let data,error == nil else{
                return
            }
            do {
                //print("data:",data)
                //let results = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
                //print(results.results[0])
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data )
                completion(.success(results.results))
                
            } catch {
                
                //print(error)
                //print(error.localizedDescription)
                completion(.failure(APIerror.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in guard let data,error == nil else{
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
//                print(results)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIerror.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    func getUpcomingMovies(completion:@escaping(Result<[Title], Error>) -> Void){
        //https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){
            data, _, error in guard let data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIerror.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion:@escaping(Result<[Title], Error>) -> Void){
//        https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)){
            data, _, error in guard let data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIerror.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion:@escaping(Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){
            data, _, error in guard let data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self,from: data)
                completion(.success(results.results))

            }catch{
                completion(.failure(APIerror.failedToGetData))
            }
        }
        task.resume()
    }
}
