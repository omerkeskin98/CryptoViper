//
//  Interactor.swift
//  CryptoViper
//
//  Created by Omer Keskin on 24.04.2024.
//

import Foundation


// talks to presenter
// class, protocol


protocol AnyInteractor{
    
    var presenter : AnyPresenter? {get set}
    
    func downloadCrypto()
    
}


class CryptoInteractor: AnyInteractor{
    
    var presenter: (any AnyPresenter)?
    
    func downloadCrypto() {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else{
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            }catch{
                self.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
            }
            
        }
        task.resume()
        
        
    }
    
    
    
}
