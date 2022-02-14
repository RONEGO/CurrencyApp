//
//  BottomView.swift
//  CurrrencyApp
//
//  Created by Egor Geronin on 12.02.2022.
//

import Foundation
import UIKit

class BottomView: UIView
{
    public var data = Data()
    private var curr: String = ""
    private var amount: String = ""
    public struct Data
    {
        var dataCurrency:[String]?
        var amountCurrency:[String]?
    }
    
    private var dateSend: ((String,String) -> Void)?
    
    public func setPicker( currencies: [String])
    {
        data.dataCurrency = currencies
        data.amountCurrency = []
        for index in 1...100
        {
            data.amountCurrency?.append("\(index)")
        }
        
        
        curr = data.dataCurrency![0]
        amount = data.amountCurrency![0]
        
        let picker = subviews.compactMap { $0 as? UIPickerView }[0]
        picker.reloadAllComponents()
    }

    convenience init( delegate: @escaping ((String,String) -> Void))
    {
        self.init(frame: .zero)
        data.amountCurrency = []
        data.dataCurrency  = []
        
        dateSend = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        SetCurrencyPicker()
    }
    
    
    @objc
    private func pressButton(sender: UIButton)
    {
        dateSend!(curr,amount)
    }
    
    private func SetCurrencyPicker()
    {
        let pickerCurrencyType = UIPickerView()
        pickerCurrencyType.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pickerCurrencyType)
        
        pickerCurrencyType.topAnchor.constraint(equalTo: topAnchor).isActive            = true
        pickerCurrencyType.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        pickerCurrencyType.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pickerCurrencyType.heightAnchor.constraint(equalTo: heightAnchor,multiplier: 0.65).isActive = true
        
        pickerCurrencyType.delegate = self
        pickerCurrencyType.dataSource = self
        
        SetReloadButton(pickerCurrencyType)
    }
    
    private func SetReloadButton( _ superView: UIView )
    {
        let button = UIButton(type: .system)
        button.setTitle("Calculate", for: .normal)
        button.addTarget(self, action: #selector(pressButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        
        button.titleLabel!.font = UIFont(name: "System", size: 30)
        
        
        button.topAnchor.constraint(equalTo: superView.bottomAnchor).isActive            = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive      = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive    = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive  = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// UI Picker Logic

extension BottomView: UIPickerViewDelegate, UIPickerViewDataSource
{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component
        {
        case 0:
            return data.amountCurrency!.count
        case 1:
            return data.dataCurrency!.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component
        {
        case 0:
            return data.amountCurrency![row]
        case 1:
            return data.dataCurrency![row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        amount = data.amountCurrency![pickerView.selectedRow(inComponent: 0)]
        curr = data.dataCurrency![pickerView.selectedRow(inComponent: 1)]
        print(amount)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
}
