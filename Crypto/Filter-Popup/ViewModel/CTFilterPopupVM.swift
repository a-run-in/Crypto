//
//  CTFilterPopupVM.swift
//  Crypto
//
//  Created by Arun on 17/10/24.
//

import UIKit

class CTFilterPopupVM{
    
    let cellHeight: CGFloat = 30
    let buttonHeight: CGFloat = 50
    
    var data:[CTFilterOptionDataModel]
    
    var selectedOptions: [CTFilterOptionDataModel]{
        data.filter{$0.selected}
    }
    
    weak var delegate: CTFilterViewModelDelegate? = nil
    
    var shouldShowCancel = true{
        didSet{
            delegate?.updateCancelButtonDisplay()
        }
    }
    
    var cencelButtonTitle: String{
        if shouldShowCancel{
            return "Cancel"
        }else{
            return "Clear"
        }
    }
    
    init(input:[CTFilterOptionDataModel]){
        self.data = input
    }
    
    func setDelegate(_ delegate:CTFilterViewModelDelegate){
        self.delegate = delegate
    }
    
    func setCancelButtonState(){
        if data.filter({$0.selected}).isEmpty{
            shouldShowCancel = true
        }else{
            shouldShowCancel = false
        }
    }
    
    func numberOfItems() -> Int{
        data.count
    }
    
    func dataForItem(at index:IndexPath) -> CTFilterOptionDataModel?{
        data[index.item]
    }
    
    func toggleSelection(at index: IndexPath){
        data[index.item].selected = !data[index.item].selected
    }
    
    
}
