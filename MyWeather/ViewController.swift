//
//  ViewController.swift
//  MyWeather
//
//  Created by 심현석 on 2023/02/28.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var tableView = UITableView()
    
    var models = [Datum]()

    let locationManager = CLLocationManager()

    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint

        setupTableView()
        
        //requestWeatherForLoacation()
        setupLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setupLocation()
            }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //setupLocation()
    }

    func setupLocation() {
        locationManager.delegate = self
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // 위치 정보가 업데이트 될 때 호출되는 delegate 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, currentLocation == nil {
            currentLocation = location
            locationManager.stopUpdatingLocation()
            requestWeatherForLoacation()
            
            if let lat = currentLocation?.coordinate.latitude, let lon = currentLocation?.coordinate.longitude {
                print("위치 업데이트~ 위도: \(lat), 경도: \(lon)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }

    func requestWeatherForLoacation() {
        guard let currentLocation = currentLocation else { return }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude

        let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(lat),\(long)?exclude=[flags,minutely]"

        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in

            // validation
            guard let data = data, error == nil else {
                print("erro1")
                return
            }
            // convert data to models/some object
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
            }
            catch {
                print("erro2:", error)
            }

            guard let result = json else { return }

            self.models = result.daily.data

            // update user interface
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                self.tableView.tableHeaderView = self.setupTableHeader()
            }
            
        }.resume()
    }
    
    func setupTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        headerView.backgroundColor = .systemCyan
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20 , height: headerView.frame.size.height/5))
        locationLabel.backgroundColor = .yellow
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        summaryLabel.backgroundColor = .purple
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 10+locationLabel.frame.size.height+10+summaryLabel.frame.size.height+10, width: view.frame.size.width-20, height: headerView.frame.size.height/2))
        tempLabel.font = UIFont.systemFont(ofSize: 32)
        tempLabel.backgroundColor = .systemGray
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(summaryLabel)
        headerView.addSubview(tempLabel)
        
        locationLabel.text = "busan"
        summaryLabel.text = "맑음"
        tempLabel.text = "11°"
        
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        
        return headerView
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

