//
//  CTHomeLandingVC.swift
//  Crypto
//
//  Created by Arun on 15/10/24.
//


import UIKit

class CTHomeLandingVC: UIViewController {
    
    let topContainer = UIView()
    let headerView = UIView()
    let cryptoLabel = UILabel()
    let searchButton = UIButton(type: .system)
    let filterButton = UIButton(type: .custom)
    let textField = UITextField()
    let closeButton = UIButton(type: .system)
    let tableView = UITableView()
    
    let searchView = UIView()
    
    var viewModel: CTHomeLandingVM
    
    init(viewModel: CTHomeLandingVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupViewModel()
    }
    
    func setupViewModel(){
        viewModel.loadCache()
        viewModel.fetchData {
            print("API Loaded")
        }
    }
    
    func configureUI(){
        self.view.backgroundColor = .white
        setupTopContainer()
        setupHeaderSearchView()
        addTableView()
    }
    
    func setupTopContainer(){
        topContainer.backgroundColor = UIColor.purple
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topContainer)
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: view.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
        setupHeaderView()
    }
    
    func setupHeaderView(){
        headerView.backgroundColor = UIColor.purple
        topContainer.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor)
        ])
        addHeaderTitle()
        addSearchButton()
        addFilterButton()
    }
    
    func addHeaderTitle(){
        cryptoLabel.text = "Crypto"
        cryptoLabel.textColor = .white
        cryptoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        headerView.addSubview(cryptoLabel)
        cryptoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cryptoLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            cryptoLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    func addSearchButton(){
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        headerView.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    func addFilterButton(){
        filterButton.setImage(UIImage(systemName: "line.horizontal.3.decrease"), for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.tintColor = .white
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        headerView.addSubview(filterButton)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            filterButton.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
            filterButton.widthAnchor.constraint(equalToConstant: 40),
            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    func setupHeaderSearchView(){
        searchView.backgroundColor = .purple
        headerView.addSubview(searchView)
        searchView.isHidden = true
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            searchView.topAnchor.constraint(equalTo: headerView.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        textField.placeholder = "Search..."
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .always
        textField.delegate = self
        searchView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        searchView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // TextField constraints
            textField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 16),
            textField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
            
            // Close Button constraints
            closeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func addTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tableView.register(CTHomeLandingListTVC.self, forCellReuseIdentifier: CTHomeLandingListTVC.reuseIdentifier)
    }
    
    @objc func searchTapped(){
        searchView.isHidden = false
        textField.becomeFirstResponder()
    }
    
    @objc func filterTapped(){
        print("Filter Tapped")
        let selectedFilters:[String] = viewModel.currentFilters.map{$0.identifier}
        let filterOptions = CTHomeLandingFilterOption.allCases.map{ CTFilterOptionDataModel(displayName: $0.displayName, identifier: $0.identifier, selected: selectedFilters.contains($0.identifier)) }
        let filterVM = CTFilterPopupVM(input: filterOptions)
        let filterVC = CTFilterPopupVC(viewModel: filterVM)
        filterVM.setDelegate(filterVC)
        filterVC.setUpdateDelegate(self)
        self.present(filterVC, animated: true)
    }
    
    @objc func closeButtonTapped() {
        textField.text = nil
        searchView.isHidden = true
        viewModel.resetDataSource()
    }
    
    func search() {
        print("Search executed")
    }
    
}


extension CTHomeLandingVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CTHomeLandingListTVC.reuseIdentifier) as? CTHomeLandingListTVC, let data = viewModel.dataForCell(at: indexPath){
            cell.configure(with: data)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRow(at: indexPath)
    }
}

extension CTHomeLandingVC: CTFilterPopupDelegate{
    
    func filtersUpdated(options: [CTFilterOptionDataModel]) {
        let updateOptions = options.map{ CTHomeLandingFilterOption(identifier: $0.identifier) }.compactMap{$0}
        viewModel.updateFilter(options: updateOptions)
    }
    
}

extension CTHomeLandingVC: CTHomeLandingVMDelegate{
    
    func refreshTable(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}

extension CTHomeLandingVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        performSearch(query: updatedText)
        return true
    }
    
    func performSearch(query: String) {
        print("Searching for: \(query)")
        viewModel.performSearch(for: query)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        viewModel.resetDataSource()
        return true
    }
    
}


