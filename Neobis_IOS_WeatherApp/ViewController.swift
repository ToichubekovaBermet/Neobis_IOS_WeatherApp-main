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
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.textColor = .white
        return label
    }()
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var ellipseImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ellipse 1")
        return image
    }()
    private lazy var temperatureLabel: UILabel = {
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
    
    private lazy var fiveDayForecastView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 60
        return view
    }()
    private lazy var collectionWeather: UICollectionView = {
        let layot = UICollectionViewFlowLayout()
        layot.itemSize = CGSize(width: 70, height: 75)
        let collection = UICollectionView(frame:  CGRect(x: 0, y: 0, width: 350, height: 150), collectionViewLayout: layot)
        collection.backgroundColor = .gray
        return collection
    }()
    
    private lazy var windLabel = CustomView()
    private lazy var visibilityLabel = CustomView()
    private lazy var humidityLabel = CustomView()
    private lazy var airPressureLabel = CustomView()
    
    override func setupView() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors =
        [ UIColor(red: 48/255, green: 162/255, blue: 197/255, alpha: 1).cgColor,
          UIColor(red: 0/255, green: 36/255, blue: 47/255, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1.3)
        view.layer.addSublayer(gradientLayer)
        self.networkWeatherManager.onCompletion = { [weak self] currentWeather in
            self?.updateInterfaceWith(weather: currentWeather)
        }
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestLocation()
        }
        view.addSubview(searchBarButton)
        view.addSubview(searchLocation)
        searchLocation.isHidden = true
        searchLocation.delegate = self
        view.addSubview(timeLabel)
        view.addSubview(countryLabel)
        view.addSubview(cityLabel)
        view.addSubview(ellipseImageView)
        ellipseImageView.addSubview(temperatureLabel)
        ellipseImageView.addSubview(viewWeatherIcon)
        view.addSubview(windLabel)
        view.addSubview(visibilityLabel)
        view.addSubview(humidityLabel)
        view.addSubview(airPressureLabel)
        view.addSubview(fiveDayForecastView)
        fiveDayForecastView.addSubview(collectionWeather)
        
        collectionWeather.register(CollectionCellView.self, forCellWithReuseIdentifier: "CollectionCellView")
        collectionWeather.delegate = self
        collectionWeather.dataSource = self

    }
    
    override func setupConstraints() {
     
        searchBarButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(330)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        timeLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(86)
            make.leading.equalToSuperview().offset(150)
            make.width.equalTo(141)
            make.height.equalTo(17)
        }
        countryLabel.snp.makeConstraints{make in
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(130)
            make.width.equalTo(212)
            make.height.equalTo(49)
        }
        cityLabel.snp.makeConstraints({make in
            make.top.equalTo(countryLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(130)
            make.width.equalTo(150)
            make.height.equalTo(24)
        })
        ellipseImageView.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(70)
            make.width.equalTo(240)
            make.height.equalTo(240)
        }
        temperatureLabel.snp.makeConstraints{make in
            make.center.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(35)
            make.width.equalTo(100)
            make.height.equalTo(110)
        }
        viewWeatherIcon.snp.makeConstraints{ make in
            make.bottom.equalTo(temperatureLabel.snp.top).offset(10)
            make.leading.equalToSuperview().offset(70)
            make.width.equalTo(100)
            make.height.equalTo(90)
        }
        windLabel.snp.makeConstraints{ label in
            label.top.equalToSuperview().offset(460)
            label.leading.equalToSuperview().offset(60)
            label.width.equalTo(130)
            label.height.equalTo(15)
        }
        humidityLabel.snp.makeConstraints{ label in
            label.top.equalTo(windLabel.snp.bottom).offset(30)
            label.leading.equalToSuperview().offset(60)
            label.width.equalTo(130)
            label.height.equalTo(15)
        }
        visibilityLabel.snp.makeConstraints{ label in
            label.top.equalToSuperview().offset(460)
            label.trailing.equalToSuperview().offset(-60)
            label.width.equalTo(130)
            label.height.equalTo(15)
        }
        airPressureLabel.snp.makeConstraints{ label in
            label.top.equalTo(visibilityLabel.snp.bottom).offset(30)
            label.trailing.equalToSuperview().offset(-60)
            label.width.equalTo(130)
            label.height.equalTo(15)
        }
        fiveDayForecastView.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().offset(600)
            view.width.equalTo(400)
            view.height.equalTo(300)
        }
        collectionWeather.snp.makeConstraints{ make in
            make.top.equalTo(fiveDayForecastView.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    private func updateInterfaceWith(weather: WACurrentWeather) {
        DispatchQueue.main.async {
            self.timeLabel.text = String(weather.timezone)
            self.countryLabel.text = weather.country
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = "\(weather.temperatureString)°C"
            self.windLabel.setup(staticText: "Wind Status", data: "\(weather.windStatus)mph")
            self.humidityLabel.setup(staticText: "Humidity", data:"\(weather.humidityStatus)%")
            self.visibilityLabel.setup(staticText: "Visibility", data: "\(weather.visibilityStatus) miles")
            self.airPressureLabel.setup(staticText: "Air Pressure", data: "\(weather.pressureStatus) mb")
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

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellView", for: indexPath) as? CollectionCellView
        else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
