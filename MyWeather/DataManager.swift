//
//  DataManager.swift
//  MyWeather
//
//  Created by 심현석 on 2023/03/01.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    var dataList = [Item]()
    
    func Request(completion: (() -> Void)?) {
        let url = "https://apis.data.go.kr/1360000/MidFcstInfoService/getMidTa?serviceKey=W20dZ%2FzPRBLwO%2BOF9sBZ2CR9mMv6v6jiGm5dLqsyGBo%2BUA8My0qhvu%2BKDUVx4C0FUrERFo2IdDq75ECcQW%2Bdfw%3D%3D&pageNo=1&numOfRows=10&dataType=JSON&regId=11B10101&tmFc=202303010600"
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(JSONData.self, from: data)
                self.dataList = data.response.body.items.item
                completion?()
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
