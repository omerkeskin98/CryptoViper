//
//  Router.swift
//  CryptoViper
//
//  Created by Omer Keskin on 24.04.2024.
//

import Foundation
import UIKit

// class, protocol
// entry point


typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
    
}


class CryptoRouter: AnyRouter{
    
    var entry: EntryPoint?
    
    static func startExecution() -> any AnyRouter {
        
        let router = CryptoRouter()
        
        var view : AnyView = CryptoView()
        var interactor : AnyInteractor = CryptoInteractor()
        var presenter : AnyPresenter = CryptoPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        
        router.entry = view as? EntryPoint
        
        
        return router
    }
    
    
    
}
