//
//  AlarmDetailsViewController.swift
//  CoreDataAlarm
//
//  Created by eAlphaMac2 on 14/02/20.
//  Copyright © 2020 eAlphaMac2. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
class AlarmDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UNUserNotificationCenterDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context:NSManagedObjectContext!
    var items: [NSManagedObject] = []
@IBOutlet var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        //deleteRecords()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
           fetchData()
       }
       @IBAction func AddAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
     //TableView Delegate And Data Source
    @IBAction func upcomingAction(_ sender: Any) {
        for date in items {
            let dateFormatter = DateFormatter()
             dateFormatter.dateStyle = .short
             dateFormatter.timeStyle = .short
             //let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
           let Time = (date.value(forKey: "time") as? String)!
             let convertedDate = dateFormatter.date(from: Time)
            if Date().compare(convertedDate!) == ComparisonResult.orderedDescending {
                print("myDate is earlier than currentDate")
            }
            
        }
//            if Calendar.current.isDate(datePicker.date, equalTo: Date(), toGranularity: .minute) {
//                   print("success")
//                   }
//        }
//
    }
    
    @IBAction func pastAction(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return items.count
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlaramDetailsTableViewCell") as! AlaramDetailsTableViewCell
              cell.selectionStyle = .none
              let item = items[indexPath.row]
               print("item : ", item)
              print("item : ", (item.value(forKey: "time") as? String) ?? "")
              cell.dateLbl.text = item.value(forKey: "time") as? String
              cell.dateLbl.textColor = .white
             cell.titleLbl.text = item.value(forKey: "title") as? String
            cell.deleteBtn.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
               
            cell.deleteBtn.tag = indexPath.row
          cell.editBtn.addTarget(self, action: #selector(editAction), for: .touchUpInside)
             
          cell.editBtn.tag = indexPath.row
          return cell
          
          }
    @objc func deleteAction(){
       
        
    }
    @objc func editAction(_sender : UIButton){
          let vc = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        let item = items[_sender.tag]
        
        vc.titleStr = (item.value(forKey: "title") as? String)!
        vc.dateStr = (item.value(forKey: "time") as? String)!
        self.navigationController?.pushViewController(vc, animated: false)
           
}
       func fetchData()
              {

                  guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                     let manageContent = appDelegate.persistentContainer.viewContext
                     let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dates")
                     do {

                         let result = try manageContent.fetch(fetchData)
                         items = result as! [NSManagedObject]
                         tblView.reloadData()
                     }catch {
                         print("err")
                     }
              }
    // MARK: Delete Data Records

    func deleteRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Dates")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
          

}
