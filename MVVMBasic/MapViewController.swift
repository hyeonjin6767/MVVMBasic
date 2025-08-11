//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
     
    private let mapView = MKMapView()
    let munlaeList = RestaurantList.restaurantArray
    var lastSpotIndex = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        addSeoulStationAnnotation()
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
         
        let seoulStationCoordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        let region = MKCoordinateRegion(
            center: seoulStationCoordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func addSeoulStationAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        annotation.title = "서울역"
        annotation.subtitle = "대한민국 서울특별시"
        mapView.addAnnotation(annotation)
    }
    
    func addMunlaeRestaurantAnnotation(category: String) {
        let annotation = MKPointAnnotation()
        for i in 0...munlaeList.count - 1 {
            annotation.coordinate = CLLocationCoordinate2D(latitude: munlaeList[i].latitude, longitude: munlaeList[i].longitude)
            annotation.title = munlaeList[i].name
            annotation.subtitle = munlaeList[i].address
            if category == munlaeList[i].category {
                print("추가",munlaeList[i].category)
                mapView.addAnnotation(annotation)
                //lastSpotIndex = i
            } else if category != munlaeList[i].category {
                print("제거",munlaeList[i].category)
                mapView.removeAnnotation(annotation)
            }
            //setupMapView2(index: lastSpotIndex)
        }
        mapView.reloadInputViews()
    }
//    private func setupMapView2(index: Int) {
//        mapView.delegate = self
//        mapView.mapType = .standard
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .none
//        
//        let lastSpot = CLLocationCoordinate2D(latitude: munlaeList[index].latitude, longitude:  munlaeList[index].longitude)
//        let focus = MKCoordinateRegion(
//            center: lastSpot,
//            latitudinalMeters: 2000,
//            longitudinalMeters: 2000)
//        mapView.setRegion(focus, animated: true)
//    }
    
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "양식", style: .default) { _ in
            print("양식이 선택되었습니다.")
            self.addMunlaeRestaurantAnnotation(category: "양식")
        }
        
        let alert2Action = UIAlertAction(title: "한식", style: .default) { _ in
            print("한식이 선택되었습니다.")
            self.addMunlaeRestaurantAnnotation(category: "한식")
        }
        
        let alert3Action = UIAlertAction(title: "전체보기", style: .default) { _ in
            print("전체보기이 선택되었습니다.")
            self.addMunlaeRestaurantAnnotation(category: "전체보기")
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소가 선택되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
//    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//        print(#function)
//    }
//    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//        print(#function)
//    }
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print(#function)
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
