//
//  Service.swift
//  Practic15
//
//  Created by Даниил Циркунов on 10.03.2023.
//

import UIKit

struct Service {
    
    var url: URL?
    
    var imageCache = NSCache<NSString, UIImage>()
    
    mutating func jsonURL (urlString: String) {
        guard
            let urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
            let url = URL(string: urlString)
        else {
            print("Ошибка, не удалось получить ссылку")
            return
        }
        print(url)
        self.url = url
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global().async {
            if let cachedImage = imageCache.object(forKey: urlString as NSString){
                print("изображение из кэша")
                completion(cachedImage)
            } else {
                guard
                    let url = URL(string: urlString),
                    let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data)
                else {
                    print("Ошибка, не удалось загрузить изображение")
                    return
                }
                self.imageCache.setObject(image, forKey: urlString as NSString)
                print("изображение из интернета")
                completion(image)
            }
        }
    }
    
    func parsingData(data:Data) -> Model? {
            do{
                let model = try JSONDecoder().decode(Model.self, from: data)
                return model
            } catch {
                print(error)
                return nil
            }
    }
    
    func getData(completion: @escaping (Data?, Error?) -> Void){
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json"]
        request.httpBody = nil
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            } else {
                completion(data, error)
            }
        }
        task.resume()
    }
}

