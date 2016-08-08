//
//  ContactsViewController.swift
//  WildDogExample
//
//  Created by yrq_mac on 16/3/30.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

import UIKit
import Wilddog

class ContactsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var cellHeight = Dictionary<Int,CGFloat>()
    var tableView:UITableView?
    var userArray:Array<String>!
    var nicknameArray = Array<String>()
    var mailArray = Array<String>()
    var selectedPerson:String!
    var userID = ""
    var userNickname = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contacts"
        self.tableView = UITableView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        self.tableView!.dataSource = self
        self.tableView!.delegate = self
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ContactsTableViewCell")
//        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.tableView!.separatorColor = UIColor.clearColor()
        self.view.addSubview(self.tableView!)

        let rightItem = UIBarButtonItem(title:"My",style:.Plain,target:self,action:"rightVC");
        navigationItem.rightBarButtonItem = rightItem;
    }

    // MARK: - TableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArray.count
//        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell",forIndexPath: indexPath) as UITableViewCell
//        cell.textLabel!.text = self.userArray[indexPath.row]
        let cellIdentifier = "ContactsTableViewCell"
        var cell:ContactsTableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? ContactsTableViewCell
        if (cell == nil) {
            cell = ContactsTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier:cellIdentifier)
        }
//        print(self.userArray[indexPath.row])
        cell.nameLabel!.text = self.userArray[indexPath.row]
        cell.mailLabel!.text = self.mailArray[indexPath.row]
//        cell.nameLabel!.sizeToFit()
//        cell.nameLabel!.backgroundColor = UIColor.redColor()
        self.cellHeight[indexPath.row] = cell.nameLabel!.yrq_height+20.0

        return cell
    }
    
    func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) ->CGFloat{
        if self.cellHeight[indexPath.row] != nil{
            return self.cellHeight[indexPath.row]!
        }
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let personView = PersonDetailViewController()
//        self.navigationController!.pushViewController(personView, animated: true)
        
        let singleView = SingleChatViewController()
        singleView.getName(self.userArray[indexPath.row],id: self.userID,myName: self.userNickname)
        self.navigationController!.pushViewController(singleView, animated: true)
        
//        let image = UIImage(named: "sun")
//        let person = PersonDetailView(frame: self.view.frame)
//        person.setMessage(image!, nickname_: self.userArray[indexPath.row], name_: "Dong", position_: self.mailArray[indexPath.row], department_: self.mailArray[indexPath.row])
//        selectedPerson = self.userArray[indexPath.row]
//        person.chatTap.addTarget(self, action: "beginChat")
//        view.addSubview(person)
    }
    
    func beginChat(){
        
        let singleView = SingleChatViewController()
        singleView.getName(selectedPerson,id: self.userID,myName: self.userNickname)
        self.navigationController!.pushViewController(singleView, animated: true)
    }
    
    // MARK: - TransmitAccountMsg
    func transmitAccountMsg(mail:String,id:String,nickname:String){
        print("Enter Contacts View")
        self.userID = id
        self.userNickname = nickname
        self.userArray = Array<String>()
        let myRootRef = Wilddog(url:WilddogURL)
        let accountRef = myRootRef.childByAppendingPath("UserAccount")
        accountRef.queryOrderedByChild("mail").observeSingleEventOfType(.Value, withBlock: { snapshot in
            for i in (snapshot.value as! Dictionary<String,Dictionary<String,String>>) {
                if i.1["mail"]! != mail {
                    self.userArray.append(i.1["nickname"]!)
                    self.mailArray.append(i.1["mail"]!)
                }
            }
//                let nickname = snapshot.value[i]["nickname"] as! String
//                let mail = snapshot.value[i]!["mail"]! as! String
//                let User = nickname
//                self.nicknameArray.append(nickname)
//                self.mailArray.append(mail)
//                self.userArray.append(User)
//            self.tableView!.reloadData()
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView!.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
