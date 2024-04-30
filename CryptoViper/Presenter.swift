//
//  Presenter.swift
//  CryptoViper
//
//  Created by Omer Keskin on 24.04.2024.
//

import Foundation


// class, protocol
// talks to interactor, view, router


enum NetworkError : Error{
    case NetworkFailed
    case ParsingFailed
    
}

protocol AnyPresenter{
    
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
        
    
}

class CryptoPresenter : AnyPresenter{
    
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)? {
        didSet{
            interactor?.downloadCrypto()
        }
    }
    
    var view: (any AnyView)?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        
        switch result{
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(let error):
            view?.update(with: "Parsing Error")
        }
    }
    
    
    
}
