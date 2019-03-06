//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Peiqin Zhao on 3/4/19.
//  Copyright © 2019 Google LLC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseFirestore
class PiTableViewController: UITableViewController {
    
    //MARK: Properties
    var pis = [Pi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadSamplePis()
        loadInitPis()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pis.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PiTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PiTableViewCell  else {
            fatalError("The dequeued cell is not an instance of WeatherTableViewCell.")
        }
        
        cell.action = {
            let db = Firestore.firestore()
            db.collection("board").document("Iron")
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    // Mark: What if a document has a lot of fields?
                    // TODO: Finish the UI update
                    
            }

        }
        
        let pi = pis[indexPath.row]
        
        // Configure the cell...
        cell.cpuImage.image = pi.cpuImage
        cell.cpuName.text = pi.name
        cell.geoInfo.text = pi.geoInfo
        cell.cpuTemperature.text = String(format:"%.1f °C", pi.cpuTemperature)
        cell.gpuTemperature.text = String(format:"%.1f °C", pi.gpuTemperature)
        cell.diskUsage.text = String(format:"%.1f ", pi.diskUsage) + "%"
        cell.memoryUsage.text = String(format:"%.1f ", pi.memoryUsage) + "%"
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        
        
        guard let sensorTableViewController = segue.destination as? SensorTableViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedSensorCell = sender as? UIButton else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPathForRow(at: selectedSensorCell.convert(CGPoint.zero, to: tableView)) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        //sensorTableViewController.sensors = pis[indexPath.row].sensors
        //Mark: You could use it as cache.
        sensorTableViewController.masterId = pis[indexPath.row].name
    }
    
    //MARK: Private Methods
    
    private func uploadSamplePis(){
        /*
         var name: String
         //TODO: How to represent location
         var geoInfo: String
         var cpuImage: UIImage?
         var gpuTemperature: Double
         var cpuTemperature: Double
         var memoryUsage: Double
         var diskUsage: Double
         */
        let db = Firestore.firestore()
        
        db.collection("board").document("Iron").setData([
            "geoInfo": "San Francisco",
            "cpuImage": "pi",
            "gpuTemperature": 25.6,
            "cpuTemperature": 54.1,
            "memoryUsage": 40.3,
            "diskUsage": 21.4,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Document added with ID: \(ref!.documentID)")
                print("Document Added!")
            }
        }

        db.collection("board").document("Mecury").setData([
            "geoInfo": "San Francisco",
            "cpuImage": "pi",
            "gpuTemperature": 25.6,
            "cpuTemperature": 54.1,
            "memoryUsage": 40.3,
            "diskUsage": 21.4
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Document added with ID: \(ref!.documentID)")
                print("Document Added!")
            }
        }
        
        db.collection("sensor").document("Rogue").setData([
            "masterId": "Iron",
            "errorRate": 0.01,
            "samplingRate": 40,
            "sampledValue": 25.6,
            "model": "Rogue"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                // print("Document added with ID: \(ref!.documentID)")
                // print("Document Added!")
            }
        }
        
        db.collection("sensor").document("Wayne").setData([
            "masterId": "Mecury",
            "errorRate": 0.01,
            "samplingRate": 40,
            "sampledValue": 25.6,
            "model" : "Wayne"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //print("Document added with ID: \(ref!.documentID)")
                //print("Document Added!")
            }
        }
    }
    
    private func loadInitPis() {
        let db = Firestore.firestore()
        //var ref: DocumentReference? = nil
        db.collection("board").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // print("\(document.documentID) => \(document.data())")
                    // Load all the boards
                    let fetchedData = document.data()
                    let name = document.documentID
                    let geoInfo = fetchedData["geoInfo"] as? String ?? ""
                    let cpuImage = UIImage(named: fetchedData["cpuImage"] as? String ?? "pi")
                    let gpuTemperature = fetchedData["gpuTemperature"] as? Double ?? 0.0
                    let cpuTemperature = fetchedData["cpuTemperature"] as? Double ?? 0.0
                    let memoryUsage = fetchedData["memoryUsage"] as? Double ?? 0.0
                    let diskUsage = fetchedData["diskUsage"] as? Double ?? 0.0
                    guard let pi = Pi(name: name, geoInfo: geoInfo, cpuImage: cpuImage, gpuTemperature: gpuTemperature, cpuTemperature: cpuTemperature, memoryUsage: memoryUsage, diskUsage: diskUsage) else {
                        fatalError("Unable to instantiate Pi")
                    }
                    // Add a new meal.
                    let newIndexPath = IndexPath(row: self.pis.count, section: 0)
                    self.pis.append(pi)
                    //meals.append(meal)
                    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }
}
