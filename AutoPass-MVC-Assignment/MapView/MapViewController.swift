//
//  MapViewController.swift
//  AutoPass-MVC-Assignment
//
//  Created by 廖慶麟 on 2018/5/5.
//  Copyright © 2018年 廖慶麟. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import RxCocoa

internal final class MapViewController: UIViewController, Navigable {

    var navigationBar: ColorgyNavigationBar = ColorgyNavigationBar()
    private var mapView: MKMapView = MKMapView()
    
    var parksHandler: ParksHandler
    
    let locationManager = CLLocationManager()
    
    var targetPark: Park? {
        didSet{
            guard targetPark != oldValue, targetPark != nil else { return }
            setCenterTo(coordinate: targetPark!.coordinate)
        }
    }
    
    var navigationTransitionDelegate: ColorgyNavigationTransitioningDelegate? = ColorgyNavigationTransitioningDelegate()
    
    init(parksHandler: ParksHandler) {
        self.parksHandler = parksHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNavigationBar()
        configureMapView()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
        mapView.addAnnotations(parksHandler.parks)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
        targetPark = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View Configuration
    func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.title = tabBarItem.title
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
        }
                
        mapView.delegate = self
    }
    
    private func setCenterTo(coordinate: CLLocationCoordinate2D) {
        let regionRadius = 3000
        let region = MKCoordinateRegionMakeWithDistance(coordinate, CLLocationDistance(regionRadius), CLLocationDistance(regionRadius))
        let adjustedRegion = mapView.regionThatFits(region)

        mapView.setRegion(adjustedRegion, animated: false)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let park = view.annotation as? Park {
            mapView.setCenter(park.coordinate, animated: true)
            
            let calloutView = CustomCalloutView()
            calloutView.configure(with: park)
            calloutView.starButton.isSelected = parksHandler.realmManager.query(id: park.id) != nil
            calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.26)
            
            calloutView.starButton.rx.tap.asDriver().drive(onNext: { [weak self] in
                calloutView.starButton.isSelected = !calloutView.starButton.isSelected
                self?.parksHandler.parkStarredStateChanged(park: park, to: calloutView.starButton.isSelected)
            }).disposed(by: calloutView.bag)
            
            calloutView.navigationButton.rx.tap.asDriver().drive(onNext: {
                let placeMark = MKPlacemark(coordinate: park.coordinate, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placeMark)
                let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps(launchOptions: options)
            }).disposed(by: calloutView.bag)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(calloutViewTapped))
            calloutView.addGestureRecognizer(tapGesture)
            
            view.addSubview(calloutView)
        }
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        for subView in view.subviews {
            if subView is CustomCalloutView {
                subView.removeFromSuperview()
            }
        }
    }
    
    @objc func calloutViewTapped() {
        guard let park = mapView.selectedAnnotations.first as? Park else { return }
        let parkDetailManager = ParkDetailManager.init(GetParkSpotList(), GetParkFacilityList(), parkName: park.parkName)
        let vc = ParkDetailViewController(park: park, parkDetailManager: parkDetailManager)
        navigationTransitionDelegate?.presentingViewController = vc
        self.asyncPresent(vc, animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard targetPark == nil else { return }
        var minDistance = CLLocationDistanceMax
        var closetTarget: Park?
        parksHandler.parks.forEach { (park) in
            let parkLocation = CLLocation(latitude: park.coordinate.latitude, longitude: park.coordinate.longitude)
            if let distance = manager.location?.distance(from: parkLocation), distance < minDistance {
                minDistance = distance
                closetTarget = park
            }
        }
        
        if closetTarget != nil { targetPark = closetTarget }
    }
}
