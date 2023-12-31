//
//  NetworkLayer.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 19/10/23.
//

import UIKit

enum NetworkError: Error {
    case urlNotFound
    case dataCantParse
    case noDataFound
}

class NetworkDelegate: NSObject, URLSessionDelegate, URLSessionDataDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Error : ", error)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Location Delegate : ", location)
    }
    
}

final class URLSessionAPIClient {
    private let configuration: URLSessionConfiguration
    private let urlSession: URLSession
    private let delegate = NetworkDelegate()
    var pdfURL: URL?
    
    init() {
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        
        urlSession = URLSession(configuration: self.configuration, delegate: delegate, delegateQueue: nil)
    }
    
    public func dataTask<T: Codable>(_ urlString: String, completion: @escaping (_ result: Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlNotFound))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        self.urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(.noDataFound))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.dataCantParse))
            }
            
        }.resume()
    }
    
    public func downloadTask(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        self.urlSession.downloadTask(with: urlRequest) { url, response, error in
            guard let url = url else {
                return
            }
            
            print("Download Link : ", url)

            let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
            // delete original copy
            try? FileManager.default.removeItem(at: destinationURL)
            // copy from temp to Document
            do {
                try FileManager.default.copyItem(at: url, to: destinationURL)
                self.pdfURL = destinationURL
            } catch let error {
                print("Copy Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
