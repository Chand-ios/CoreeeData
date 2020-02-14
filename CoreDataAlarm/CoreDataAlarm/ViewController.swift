//
//  ViewController.swift
//  CoreDataAlarm
//
//  Created by eAlphaMac2 on 14/02/20.
//  Copyright © 2020 eAlphaMac2. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ViewController: UIViewController  {
    var titleStr = String()
    var dateStr = String()

    

     var timer = Timer()
    var Time:String = ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
        var context:NSManagedObjectContext!
        var items: [NSManagedObject] = []
        @IBOutlet var dptext: UITextField!
        let datePicker = UIDatePicker()
    @IBOutlet var titleLbl: UITextField!

        override func viewDidLoad() {
            if(titleStr != ""){
                titleLbl.text = titleStr
            }
            if(dateStr != ""){
                dptext.text = dateStr
            }
                 createDatePicker()
            timer  = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.testDate), userInfo: nil, repeats: true)
        }
   
 //Creating Database,Save Data and Fetch data

        func openDatabse()
           {
               context = appDelegate.persistentContainer.viewContext
               let entity = NSEntityDescription.entity(forEntityName: "Dates", in: context)
               let newUser = NSManagedObject(entity: entity!, insertInto: context)
               saveData(UserDBObj:newUser)
           }
        func saveData(UserDBObj:NSManagedObject)
           {
            if(titleLbl.text != ""){
                UserDBObj.setValue(titleLbl.text, forKey: "title")

            }
            UserDBObj.setValue(Time, forKey: "time")

            print("Storing Data..")
            do {
                try context.save()
                self.navigationController?.popViewController(animated: false)
                
            } catch {
                print("Storing data Failed")
            }

            fetchData()
        }
       
        
        func createDatePicker() {
            datePicker.datePickerMode = .dateAndTime
        let toolbar = UIToolbar()
            toolbar.sizeToFit()

            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneButton], animated: false)

            dptext.inputAccessoryView = toolbar
            dptext.inputView = datePicker


        }
    func fetchData()
                 {

                     guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                        let manageContent = appDelegate.persistentContainer.viewContext
                        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Dates")
                        do {

                            let result = try manageContent.fetch(fetchData)
                            items = result as! [NSManagedObject]
                        }catch {
                            print("err")
                        }
                 }
@objc func testDate() {
    if Calendar.current.isDate(datePicker.date, equalTo: Date(), toGranularity: .minute) {
        print("success")
        }
}
    @IBAction func AddAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
                   dateFormatter.dateStyle = .short
                   dateFormatter.timeStyle = .short
                   //let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                   let convertedDate = dateFormatter.string(from: datePicker.date)

                  Time = convertedDate
                   openDatabse()
                   self.view.endEditing(true)
    }
    @objc func donePressed() {

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            //let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            let convertedDate = dateFormatter.string(from: datePicker.date)

           Time = convertedDate
            openDatabse()
            self.view.endEditing(true)

              }
}
