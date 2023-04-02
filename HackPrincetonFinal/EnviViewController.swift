//
//  EnviViewController.swift
//  HackPrincetonFinal
//
//  Created by Fatima Asif on 4/1/23.
//

import UIKit

class EnviViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    var data: [Organizer]!
    var imageName: String!
    
    @IBAction func back(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backSegue2", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let org = data[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.iconImageView.image = UIImage(named: org.imageName)
        cell.label.text = org.title
        cell.label2.text = org.description
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = UserPrefs.orgList
        print(self.data!)
        table.dataSource = self
        image.image = UIImage(named: imageName)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
