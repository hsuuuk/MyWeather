//
//  ViewController.swift
//  MyWeather
//
//  Created by 심현석 on 2023/02/28.
//

import UIKit
import CoreLocation
import SnapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let dataManager = DataManager.shared
    let locationManager = CLLocationManager()
    //var currentLocation: CLLocation?
    
    var data = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        let layout = Layout.CompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(Cell1.self, forCellWithReuseIdentifier: "Cell1")
        collectionView.register(Cell2.self, forCellWithReuseIdentifier: "Cell2")
        collectionView.register(Cell3.self, forCellWithReuseIdentifier: "Cell3")
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        func setupLocation() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! Cell1
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! Cell2
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! Cell3
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! Header
        
        return header
    }
}

extension ViewController: UICollectionViewDelegate {
    
}
