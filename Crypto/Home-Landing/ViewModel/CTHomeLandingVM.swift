//
//  CTHomeLandingVM.swift
//  Crypto
//
//  Created by Arun on 16/10/24.
//

import Foundation

class CTHomeLandingVM{
    
    var listData:[CTHomeListingDataModel] = []{
        didSet{
            delegate?.refreshTable()
        }
    }
    
    var sourceData:[CTHomeListingDataModel] = []
    
    var currentFilters:[CTHomeLandingFilterOption] = []
    
    let cacheManager:CacheManager<[CTHomeListingDataModel]>
    
    private weak var delegate:CTHomeLandingVMDelegate?
    
    init(){
        //TODO: - Replace caching mechanism with CoreData persistence store
        cacheManager = CacheManager(cacheKey: CTHomeListingDataModel.cacheKey)
    }
    
    func loadCache(){
        if let cachedData = cacheManager.loadData(){
            listData = cachedData
            sourceData = cachedData
        }
    }
    
    func setDelegate(_ delegate:CTHomeLandingVMDelegate?){
        self.delegate = delegate
    }
    
    func fetchData(completion:@escaping()->()){
        fetchHomeListingData(completion: completion)
    }
    
    func fetchHomeListingData(completion:@escaping()->()){
        let url = APIEndpoints.homeListing
        NetworkUtility.request(ofType: .get, url: url) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decodedResponse = try JSONDecoder().decode([CTHomeListingDataModel].self, from: data)
                    self?.listData = decodedResponse
                    self?.sourceData = decodedResponse
                    self?.cacheManager.storeData(decodedResponse)
                } catch let decodingError {
                    print("Error : \(decodingError.localizedDescription)")
                }
            case .failure(let error):
                print("Error : \(error.localizedDescription)")
            }
            completion()
        }
    }
    
    func numberOfRows() -> Int{
        listData.count
    }
    
    func dataForCell(at index:IndexPath) -> CTHomeListingDataModel?{
        guard index.row < listData.count else{ return nil }
        return listData[index.row]
    }
    
    func heightForRow(at index:IndexPath) -> CGFloat{
        100
    }
    
    //TODO: - Filter behaviour for active/inactive should be exclusionary.
    func updateFilter(options:[CTHomeLandingFilterOption]){
        currentFilters = options
        if options.isEmpty{
            listData = sourceData
            return
        }
        var data = sourceData
        for option in options {
            switch option {
            case .active:
                data = data.filter{ $0.isActive }
            case .inactive:
                data = data.filter{ !$0.isActive }
            case .tokens:
                data = data.filter{ $0.type == .token }
            case .coins:
                data = data.filter{ $0.type == .coin }
            case .new:
                data = data.filter{ $0.isNew }
            }
        }
        listData = data
    }
    
    func performSearch(for key:String){
        if key.isEmpty{
            listData = sourceData
            return
        }
        let searchKey = key.lowercased()
        let searchData = sourceData.filter { $0.name.lowercased().contains(searchKey) || $0.symbol.lowercased().contains(searchKey) }
        listData = searchData
    }
    
    func resetDataSource(){
        listData = sourceData
    }
    
}



