//
//  ViewController.swift
//  CurrrencyApp
//
//  Created by Egor Geronin on 12.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var currencyRef: Currency?
    private var tableView: UITableView?
    private var dataPicker: (([String]) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyRef = Currency(view: self,currencyGet: "USD",amountGet: "1")
        view.backgroundColor = .white
        
        SetBottomView()
    }
    
    private func SetBottomView()
    {
        let bottomView = BottomView(delegate: ReLoad(currency:amount:))
        dataPicker = bottomView.setPicker( currencies :)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomView)
        
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive                     = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                                       = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                                     = true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive                        = true
        
        SetTableView(bottomView)
    }
    
    private func SetTableView( _ bottom: BottomView)
    {
        tableView = UITableView()
        if let table  = tableView
        {
            table.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(table)
            
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive        = true
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive                    = true
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive                  = true
            table.bottomAnchor.constraint(equalTo: bottom.topAnchor).isActive                      = true
            
            table.dataSource = self
            table.delegate  = self
            
            table.isHidden = true
        }
    }
    
    public var dataArray = [String]()
    
    private func ReLoad(currency: String, amount: String)
    {
        currencyRef?.SetCurrency(currency: currency, amount: amount)
    }
    
    public func GetData( data: [String: Any])
    {
        dataArray = [String]()
        for key in data.keys
        {
            guard data[key] != nil else { continue }
            dataArray.append("\(key): \(data[key]!)")
        }
        dataArray.sort()
        
        if let table = tableView, table.isHidden
        {
            table.isHidden = false
            dataPicker!(dataArray.compactMap { String($0.prefix(3)) } )
        }
        
        tableView?.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel!.text = dataArray[indexPath.row]
        return cell
        
    }
}
