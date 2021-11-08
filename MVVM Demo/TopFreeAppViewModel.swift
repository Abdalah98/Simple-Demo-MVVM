//
//  TopFreeAppViewModel.swift
//  MVVM Demo
//
//  Created by Abdallah on 11/7/21.
//

import Foundation

class TopFreeAppViewModel: NSObject {
    
    var results = [ResultApple]()
    
    var apiServices = NetworkManger()
    
    func getCountapp() ->Int{
        return results.count
    }
    
    func fetchData(completion: @escaping() ->()){
        apiServices.getComingSoon {[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                let data = response.feed?.results ?? []
                self.results = data
                completion()
        
            case .failure(let error):
                print(error,"Some thing error")
                
            }
        }
    }
    
//    
    func getArtistName( at indexPath: IndexPath ) -> String {
        return results[indexPath.row].artistName ?? ""
        
    }
    func getName( at indexPath: IndexPath ) -> String {
        return results[indexPath.row].name ?? ""
        
    }
    func getImage( at indexPath: IndexPath ) -> String {
        return results[indexPath.row].artworkUrl100 ?? ""
        
    }
    func openUrl( at indexPath: IndexPath ) -> String {
        return results[indexPath.row].url ?? ""
        
    }
}
