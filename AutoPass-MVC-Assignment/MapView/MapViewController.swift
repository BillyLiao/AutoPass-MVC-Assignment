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

internal final class MapViewController: NavigationViewController {

    private var mapView: MKMapView = MKMapView()
    
    var parksHandler: ParksHandler
    let locationManager = CLLocationManager()
    
    var targetPark: Park? {
        didSet{
            guard targetPark != nil else { return }
            setCenterTo(park: targetPark!)
        }
    }
    
    init(parksHandler: ParksHandler) {
        self.parksHandler = parksHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.title = tabBarItem.title
        configureMapView()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        mapView.addAnnotations(parksHandler.parks)
    }

    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
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
    private func configureMapView() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navigationBar.snp.bottom)
        }
                
        mapView.delegate = self
    }
    
    private func setCenterTo(park: Park) {
        let regionRadius = 3000
        let region = MKCoordinateRegionMakeWithDistance(park.coordinate, CLLocationDistance(regionRadius), CLLocationDistance(regionRadius))
        let adjustedRegion = mapView.regionThatFits(region)

        mapView.setRegion(adjustedRegion, animated: false)
        mapView.selectAnnotation(park, animated: false)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let park = view.annotation as? Park {
            let calloutView = CustomCalloutView()
            calloutView.configure(with: park)
            calloutView.starButton.isSelected = parksHandler.realmManager.query(id: park.id) != nil
            calloutView.center = CGPoint(x: view.bounds.size.width / 2, y: -calloutView.bounds.size.height*0.26)
            
            calloutView.starButton.rx.tap.asDriver().drive(onNext: { [weak self] in
                self?.parksHandler.parkStarredStateChanged(park: park, to: calloutView.starButton.isSelected)
            }).disposed(by: calloutView.bag)
            
            calloutView.navigationButton.rx.tap.asDriver().drive(onNext: {
                let placeMark = MKPlacemark(coordinate: park.coordinate, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placeMark)
                let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps(launchOptions: options)
            }).disposed(by: calloutView.bag)
            
            let tapGesture = UITapGestureRecognizer(target: nil, action: nil)
            calloutView.addGestureRecognizer(tapGesture)
            tapGesture.rx.event.bind(onNext: { [ weak self](recogizer) in
                let parkDetailManager = ParkDetailManager.init(GetParkSpotList(), GetParkFacilityList(), parkName: park.parkName)
                let vc = ParkDetailViewController(park: park, parkDetailManager: parkDetailManager)
                self?.navigationTransitionDelegate?.presentingViewController = vc
                self?.asyncPresent(vc, animated: true)
            }).disposed(by: calloutView.bag)
            
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
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard targetPark == nil, let location = manager.location else { return }
        if let closestTarget = parksHandler.getClosestPark(to: location) {
            targetPark = closestTarget
        }
    }
}
