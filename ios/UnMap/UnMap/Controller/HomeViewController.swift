//
//  ViewController.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/28.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    let friendLocations = [
        Friend(imagePath: "https://pbs.twimg.com/profile_images/1635460694740189185/NpDlT7bZ_400x400.jpg", userName: "中西直人", userId: "nanaonanika", location: "西宮市上ヶ原", updatedAt: Date().addingTimeInterval(-450)),
        Friend(imagePath: "https://pbs.twimg.com/profile_images/1635460694740189185/NpDlT7bZ_400x400.jpg", userName: "中西直", userId: "nanaonanika", location: "西宮市上ヶ原", updatedAt: Date().addingTimeInterval(-450))
    ]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendLocations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendLocationTableCell", for: indexPath) as! FriendLocationTableViewCell
        
        cell.setCell(friendLocation: friendLocations[indexPath.section])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let marginView = UIView()
        marginView.backgroundColor = .clear
        return marginView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "この友達を削除") { (action, view, completionHandler) in
            print("Deleteがタップされた")
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    var locationManager : CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        //位置情報を使用可能か
        if CLLocationManager.locationServicesEnabled() {
            //位置情報の取得開始
            locationManager!.startUpdatingLocation()
            
        }
    }
    
    // 位置情報を取得した場合
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            return
        }
        let location:CLLocationCoordinate2D
        = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        getLocationString(location: location, completion: { address in
            print(address)
            self.submitToServer(text: address)
        })
    }
    
    func getLocationString(location: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        var components = URLComponents(string: "https://maps.googleapis.com/maps/api/geocode/json")
        
        components?.queryItems = [
            URLQueryItem(name: "latlng", value: "\(location.latitude),\(location.longitude)"),
            URLQueryItem(name: "language", value: "Ja"),
            URLQueryItem(name: "key", value: "AIzaSyB21aEspPuFlZ56B_7JJsi8L0MRdoYrAvo")
        ]
        
        if let url = components?.url {
            print("2")
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let geoLocation = try decoder.decode(GeoLocation.self, from: data)
                        let address = "\(geoLocation.results[0].addressComponents[3].shortName)\(geoLocation.results[0].addressComponents[2].shortName )"
                        completion(address)
                    } catch {
                        print("Serialize Error")
                        completion(nil)
                    }
                } else {
                    print(error ?? "Error")
                    completion(nil)
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    func submitToServer(text: String?) -> Void {
        var url = URLComponents(string: "http://localhost:8787/location")
        
        
        var request = URLRequest(url: url!.url!)
            request.httpMethod = "PUT"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: Any] = ["location_name": text!, "is_custom": false]
            guard let httpBody = try? JSONSerialization.data(withJSONObject: data, options: []) else { return }
        
        request.httpBody = httpBody

            URLSession.shared.dataTask(with: request) {(data, response, error) in

                if let error = error {
                    print("Failed to get item info: \(error)")
                    return;
                }

                if let response = response as? HTTPURLResponse {
                    if !(200...299).contains(response.statusCode) {
                        print("Response status code does not indicate success: \(response.statusCode)")
                        return
                    }
                }

                if let data = data {
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let success = jsonDict!["success"] as! Bool
                        var message = jsonDict!["message"] as! String

                        if(success) {
                            print("Success")
                        }
                    } catch {
                        print("Error parsing the response.")
                    }
                } else {
                    print("Unexpected error.")
                }

            }.resume()
    }
    
    @IBAction func goToAddFriendPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToAddFriend", sender: self)
    }
    
}
