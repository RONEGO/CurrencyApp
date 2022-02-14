//
//  Currency.swift
//  CurrrencyApp
//
//  Created by Egor Geronin on 12.02.2022.
//

import Foundation
import UIKit


class Currency
{
    private let urlCurrency: [String] = ["https://api.exchangerate.host/latest?base=","&amount="]
    public var currencyNow: String = ""
    public var amountNow: String = ""
    
    private weak var delegate: ViewController?
    
    init( view: ViewController, currencyGet: String, amountGet: String)
    {
        delegate = view
        SetCurrency(currency: currencyGet, amount: amountGet)
    }
    
    public func SetCurrency( currency: String, amount: String )
    {
        guard currency != self.currencyNow || amount != self.amountNow else { print(amount,amountNow); return }
        currencyNow = currency
        amountNow = amount
        delegate?.title = "\(amountNow) \(currencyNow)"
        makeRequest()
    }
    
    private func makeRequest()
    {
        var newURL = urlCurrency
        newURL[0] += currencyNow
        newURL[1] += amountNow
        
        getData(from: newURL.joined(), completed: closureGetCurrencies(_:))
    }
    
    
    private func closureGetCurrencies( _ currencies: [String: Any])
    {
        delegate!.GetData(data: currencies)
    }
    
    private func getData(from url: String, completed: @escaping ([String: Any]) -> Void)
    {
        URLSession.shared.dataTask(with: URL(string: url)!)
        {
            data, response, error in
            guard let dataNew = data, error == nil else { print("URL Error!"); return}
            
            do{
                if let parsedData = try JSONSerialization.jsonObject(with: dataNew, options: .allowFragments) as? [String:Any]
                {
                    DispatchQueue.main.sync {
                        let rates = parsedData["rates"] as? [String:Any]
                        guard rates != nil else { return }
                        completed(rates!)
                    }
                }
            }
            catch{
                print("Error decode! \(error)")
            }
            
        }.resume()
        
    }
}
