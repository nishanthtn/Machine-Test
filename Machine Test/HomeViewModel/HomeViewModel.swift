//
//  HomeViewModel.swift
//  Machine Test
//
//  Created by Jaldee on 29/01/23.
//

import UIKit

class HomeViewModel {

    var homeData: DataModel?
    private let sourcesURL = URL(string: "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0" )!
    
    func apiToGetData(completion : @escaping () -> ()) {
            
            URLSession.shared.dataTask(with: sourcesURL) { [weak self] (data, urlResponse, error) in
                if let data = data {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    let apiData = try! jsonDecoder.decode(DataModel.self, from: data)
                    self?.homeData = apiData
                    completion()
                }
            }.resume()
        }
}
