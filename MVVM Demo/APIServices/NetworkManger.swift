//
//  NetworkManger.swift
//  MVVM
//
//  Created by Abdallah on 11/7/21.
//

import Foundation
class NetworkManger {
    
    func getComingSoon(completion: @escaping (Result<SearchResult , ResoneError>) -> Void){
        let url = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        fetchGenericJSONData(urlString:url , completion: completion)
    }
    
    
   
    
    
    func fetchGenericJSONData<T:Codable>(urlString:String,completion: @escaping (Result<T , ResoneError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.invaldURL))
            return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let _ = err {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response  = response as? HTTPURLResponse ,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                // success
                completion(.success(objects))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
}

   


