//
//  NewsListController.swift
//  WxToutiao
//
//  Created by yons on 2017/5/22.
//  Copyright © 2017年 yons. All rights reserved.
//

import UIKit

class NewsListController: UITableViewController {
    
    var newsList : [Post] = []
    var parentNavi : UINavigationController?
    
    var id = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
       
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getData), for: .valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NotificationHelper.updateList, object: nil)
    }
    
    func getData()  {
        Post.request(id: id) { (posts) in
            if let posts = posts {
                
                OperationQueue.main.addOperation {
                    self.newsList = posts
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
                
                
            } else {
                print("网络错误")
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return newsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell

        let news = newsList[indexPath.row]
        
        cell.titleLabel.text = news.title
        cell.commentLabel.text = "评论：\(news.comment_count!)"

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[tableView.indexPathForSelectedRow!.row]
        
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "SBID_NEWS_DETAIL") as! DetailController
        
        detailVC.post = news
        
        
        parentNavi?.pushViewController(detailVC, animated: true)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
