//
//  GSettingsTableViewController.swift
//  Mobile Assistant
//
//  Created by RitcheldaV on 26/3/15.
//  Copyright (c) 2015 Cloudstaff. All rights reserved.
//

import UIKit
import CoreData


class GSettingsTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFirst: UITextField!
    @IBOutlet weak var txtSecond: UITextField!
    @IBOutlet weak var txtThird: UITextField!
    @IBOutlet weak var txtFourth: UITextField!
    @IBOutlet weak var txtFifth: UITextField!
    @IBOutlet weak var txtYourEmail: UITextField!
    @IBOutlet weak var txtCSUsername: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    
    var titles = [NSManagedObject]()
    
    ///////////////////////  KEYBOARD DISMISS  /////////////////////////
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    ////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCSUsername.delegate = self
        txtEmailAddress.delegate = self
        txtFifth.delegate = self
        txtFirst.delegate = self
        txtFourth.delegate = self
        txtMobileNumber.delegate = self
        txtSecond.delegate = self
        txtThird.delegate = self
        txtYourEmail.delegate = self
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Pages")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        
        
        if let results = fetchedResults {
            titles = results
            
            println(titles[0].valueForKey("title")!)
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        
        if count(txtFirst.text) > 0 {
            savePageTitle(txtFirst.text!)
        }
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        if (section == 0) {
            returnValue = 5
        } else if (section == 1) {
            returnValue = 1
        } else if (section == 2) {
            returnValue = 3
        }
        
        return returnValue
    }
    
    func hideKeyboard() {
        txtEmailAddress.resignFirstResponder()
        txtCSUsername.resignFirstResponder()
        txtFifth.resignFirstResponder()
        txtFirst.resignFirstResponder()
        txtFourth.resignFirstResponder()
        txtMobileNumber.resignFirstResponder()
        txtSecond.resignFirstResponder()
        txtThird.resignFirstResponder()
        txtYourEmail.resignFirstResponder()
    }
    
    func savePageTitle(title: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Pages", inManagedObjectContext: managedContext)
        
        let pagetitle = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        pagetitle.setValue(title, forKey: "title")
        
        var error: NSError?
        
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        titles.append(pagetitle)
    }
    
    
}
