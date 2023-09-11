//
//  ViewController.swift
//  Neobis_IOS_WeatherApp
//
//  Created by Bermet Toichubekova on 3/9/23.
//
import UIKit
import SnapKit
import CoreLocation

class ViewController: BaseController, UISearchBarDelegate  {
    
//    private var collectionView = UICollectionView()
    
    var networkWeatherManager = WANetworkWeatherManager()
    


    private lazy var searchBarButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .black
        searchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return searchButton
    }()
    private lazy var searchLocation: UISearchBar = {
        let searchLocation = UISearchBar()
        searchLocation.text = "Search Location"
        searchLocation.layer.cornerRadius = 50
        return searchLocation
    }()
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    private lazy var labelForDaysOfTheWeek: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    private lazy var labelForCountry: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.textColor = .white
        return label
    }()
    private lazy var labelForCity: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var viewEllipse: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ellipse 1")
        return image
    }()
    private lazy var labelTemperature: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 80, weight: .ultraLight)
        label.textColor = .black
        return label
    }()

    private lazy var viewWeatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "WeatherIcon")
        return image
    }()
    
    private lazy var viewForDay: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 60
        return view
    }()
    
    private lazy var WindStatus: UILabel = {
        let label = UILabel()
        label.text = "Wind status"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var WindStatusForApi: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var Visibility : UILabel = {
        let label = UILabel()
        label.text = "Visibility"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var VisibilityForApi : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var Humidity : UILabel = {
        let label = UILabel()
        label.text = "Humidity"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var HumidityForApi: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var AirPressure: UILabel = {
        let label = UILabel()
        label.text = "Air Pressure"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private lazy var AirPressureForApi: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    
    override func setupView() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [ UIColor(red: 48/255, green: 162/255, blue: 197/255, alpha: 1).cgColor,
                                UIColor(red: 0/255, green: 36/255, blue: 47/255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1.3)
        view.layer.addSublayer(gradientLayer)
        view.addSubview(searchBarButton)
        view.addSubview(searchLocation)
        searchLocation.isHidden = true
        searchLocation.delegate = self
        
        self.networkWeatherManager.onCompletion = { [weak self] currentWeather in
            self?.updateInterfaceWith(weather: currentWeather)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestLocation()
        }
        view.addSubview(labelForDaysOfTheWeek)
        view.addSubview(labelForCountry)
        view.addSubview(labelForCity)
        view.addSubview(viewEllipse)
        viewEllipse.addSubview(labelTemperature)
        viewEllipse.addSubview(viewWeatherIcon)
        view.addSubview(viewForDay)
        view.addSubview(WindStatus)
        view.addSubview(WindStatusForApi)
        view.addSubview(Visibility)
        view.addSubview(VisibilityForApi)
        view.addSubview(Humidity)
        view.addSubview(HumidityForApi)
        view.addSubview(AirPressure)
        view.addSubview(AirPressureForApi)
//        col()
    }
    
    override func setupConstraints() {
     
        searchBarButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(330)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        labelForDaysOfTheWeek.snp.makeConstraints({make in
            make.top.equalToSuperview().offset(86)
            make.leading.equalToSuperview().offset(150)
            make.width.equalTo(141)
            make.height.equalTo(17)
        })
        labelForCountry.snp.makeConstraints({make in
            make.top.equalTo(labelForDaysOfTheWeek.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(130)
            make.width.equalTo(212)
            make.height.equalTo(49)
        })
        labelForCity.snp.makeConstraints({make in
            make.top.equalTo(labelForCountry.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(130)
            make.width.equalTo(150)
            make.height.equalTo(24)
        })
        viewEllipse.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelForCity.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(70)
            make.width.equalTo(240)
            make.height.equalTo(240)
        })
        labelTemperature.snp.makeConstraints({make in
            make.center.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(35)
            make.width.equalTo(100)
            make.height.equalTo(110)
        })
        
        viewWeatherIcon.snp.makeConstraints({ make in
            make.bottom.equalTo(labelTemperature.snp.top).offset(10)
            make.leading.equalToSuperview().offset(70)
            make.width.equalTo(100)
            make.height.equalTo(90)
        })
        viewForDay.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(600)
            make.width.equalTo(400)
            make.height.equalTo(290)
        })
        
        WindStatus.snp.makeConstraints{ label in
            label.top.equalToSuperview().offset(460)
            label.leading.equalToSuperview().offset(60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        WindStatusForApi.snp.makeConstraints{ label in
            label.top.equalTo(WindStatus.snp.bottom).offset(10)
            label.leading.equalToSuperview().offset(60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        Humidity.snp.makeConstraints{ label in
            label.top.equalTo(WindStatus.snp.bottom).offset(30)
            label.leading.equalToSuperview().offset(60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        HumidityForApi.snp.makeConstraints{ label in
            label.top.equalTo(Humidity.snp.bottom).offset(0)
            label.leading.equalToSuperview().offset(60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        Visibility.snp.makeConstraints{ label in
            label.top.equalToSuperview().offset(460)
            label.trailing.equalToSuperview().offset(-60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        VisibilityForApi.snp.makeConstraints{ label in
            label.top.equalTo(Visibility.snp.bottom).offset(0)
            label.trailing.equalToSuperview().offset(-60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        AirPressure.snp.makeConstraints{ label in
            label.top.equalTo(Visibility.snp.bottom).offset(30)
            label.trailing.equalToSuperview().offset(-60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        AirPressureForApi.snp.makeConstraints{ label in
            label.top.equalTo(AirPressure.snp.bottom).offset(0)
            label.trailing.equalToSuperview().offset(-60)
            label.width.equalTo(90)
            label.height.equalTo(15)
        }
        
    }
    private func updateInterfaceWith(weather: WACurrentWeather) {
        DispatchQueue.main.async {
            self.labelForDaysOfTheWeek.text = String(weather.timezone)
            self.labelForCountry.text = weather.country
            self.labelForCity.text = weather.cityName
            self.labelTemperature.text = "\(weather.temperatureString)°C"
            self.WindStatusForApi.text = "\(weather.windStatus) mph"
            self.HumidityForApi.text = "\(weather.humidityStatus)%"
            self.VisibilityForApi.text = "\(weather.visibilityStatus) miles"
            self.AirPressureForApi.text = "\(weather.pressureStatus) mb"
            self.viewWeatherIcon.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
    
    
    @objc func buttonTapped() {

        self.presentSearchAlert(withTitle: "Enter city name",
                                message: nil,
                                style: .alert) { [weak self] (city) in
            self?.networkWeatherManager.fetchCurrentWeather(
                forRequestType: .cityName(city: city))
       }

}
}

extension ViewController: CLLocationManagerDelegate {
        func locationManager(_ manager: CLLocationManager,
                             didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            networkWeatherManager.fetchCurrentWeather(
                forRequestType: .coordinate(latitude: latitude, longitude: longitude))
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
      }
    func locationManager1(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }

    }

//extension ViewController {
//    func col() {
//        let collection = UICollectionViewFlowLayout()
//        collection.scrollDirection = .horizontal
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collection)
//        viewForDay.addSubview(collectionView)
//        collectionView.snp.makeConstraints{ make in
//            make.top.equalToSuperview().offset(40)
//            make.leading.equalToSuperview().offset(30)
//            make.height.equalTo(80)
//        }
//        collectionView.dataSource = self
//    }
//
//}
//
//extension ViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }
//
//
//}
