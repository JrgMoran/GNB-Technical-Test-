//
//  Network.swift
//  GNB
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import RxSwift

protocol Network { }

extension Network {
    func decoder<T: Decodable>(from json: Data) -> Single<T>{
        return Single.create { single in
            single(decoderObjectOfSingleEvent(from: Result.success(json)))
            return Disposables.create()
        }
    }
    
    func decoderObjectOfSingleEvent<T: Decodable>(from result: Result<Data,AppError>) -> SingleEvent<T>{
        let result: Result<T,AppError> = decoderObject(from: result)
        switch result {
        case .success(let data):
            return SingleEvent.success(data)
        case .failure(let error):
            return SingleEvent.error(error)
        }
    }
    
    func decoderObject<T: Decodable>(from result: Result<Data,AppError>) -> Result<T,AppError> {
        
        guard let json = getData(from: result) else {
            return Result.failure(getError(from: result) ?? AppError.unknown(message: nil))
        }
        
        let jsonStr = String(decoding: json, as: UTF8.self)
        if let first = jsonStr.first, let last = jsonStr.last, first == "{", last == "}"{
            
                do {
                    let object = try JSONDecoder().decode(T.self, from: json)
                    return Result.success(object)
                } catch let error {
                    return Result.failure(AppError.other(error: error))
                }
            
        } else {
            return Result.failure(AppError.badJson)
        }
    }
    
    func decoderArray<T: Decodable>(from json: Data) -> Single<[T]>{
        return Single.create { single in
            single(decoderObjectOfSingleEvent(from: Result.success(json)))
            return Disposables.create()
        }
    }
    
    func decoderObjectsOfSingleEvent<T: Decodable>(from result: Result<Data,AppError>) -> SingleEvent<[T]>{
        let result: Result<[T],AppError> = decoderObjects(from: result)
        switch result {
        case .success(let data):
            return SingleEvent.success(data)
        case .failure(let error):
            return SingleEvent.error(error)
        }
    }
    
    func decoderObjects<T: Decodable>(from result: Result<Data,AppError>) -> Result<[T],AppError> {
        
        guard let json = getData(from: result) else {
            return Result.failure(getError(from: result) ?? AppError.unknown(message: nil))
        }
        
        let jsonStr = String(decoding: json, as: UTF8.self)
        if let first = jsonStr.first, let last = jsonStr.last, first == "[", last == "]"{
            
                do {
                    let objects = try JSONDecoder().decode([T].self, from: json)
                    return Result.success(objects)
                } catch let error {
                    return Result.failure(AppError.other(error: error))
                }
            
        } else {
            return Result.failure(AppError.badArrayJson)
        }
    }
}

extension Network {
    fileprivate func getData(from result: Result<Data,AppError>) -> Data? {
        switch result {
        case .success(let data):
            return data
        case .failure(_):
            return nil
        }
    }
    
    fileprivate func getError(from result: Result<Data,AppError>) -> AppError? {
        switch result {
        case .success(_):
            return nil
        case .failure(let error):
            return error
        }
    }
}

