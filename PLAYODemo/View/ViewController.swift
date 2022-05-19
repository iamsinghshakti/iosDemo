//
//  ViewController.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import UIKit

class ViewController: UIViewController {
     lazy var newsVM:NewsVM = {
        return NewsVM()
    }()
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                         #selector(handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.gray
            
            return refreshControl
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
        tableView.register(UINib(nibName: "NewsTC", bundle: nil), forCellReuseIdentifier: "NewsTC")
       callApi()
        // Do any additional setup after loading the view.
    }
    func callApi(){
        Apputility.showLoader(pView: self.view)

        newsVM.getNewsData { check in
            DispatchQueue.main.async {
                Apputility.hideLoader(pView: self.view)
            }
            if check {
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }
            }else{
                print("Something went wrong")
            }
        }
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshControl.endRefreshing()
       callApi()
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsVM.newsArticleList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTC", for: indexPath) as! NewsTC
        cell.setDetail(data: newsVM.newsArticleList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = NewsVC(nibName: "NewsVC", bundle: nil)
        obj.url = newsVM.newsArticleList[indexPath.row].url
        self.navigationController?.pushViewController(obj, animated: true)
    }
}
