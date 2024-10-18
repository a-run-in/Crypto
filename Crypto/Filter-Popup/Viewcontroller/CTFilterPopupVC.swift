//
//  CTFilterPopupVC.swift
//  Crypto
//
//  Created by Arun on 16/10/24.
//

import UIKit

class CTFilterPopupVC: UIViewController{
    
    // MARK: - Properties
    private let collectionView: UICollectionView
    private let applyButton = UIButton()
    private let cancelButton = UIButton()
    
    private let containerView = UIView()
    
    var viewModel:CTFilterPopupVM
    
    weak var updateDelegate:CTFilterPopupDelegate? = nil
    
    // MARK: - Initializer
    init(viewModel: CTFilterPopupVM) {
        self.viewModel = viewModel
        let layout = LeftAlignedFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setCancelButtonState()
        setupContainer()
        setupCollectionView()
        setupButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCollectionViewHeight()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view{
            dismiss(animated: true, completion: nil)
        }
    }
    
    func setUpdateDelegate(_ delegate:CTFilterPopupDelegate){
        updateDelegate = delegate
    }
    
    //Update the size of the collection view after layout
    private func updateCollectionViewHeight() {
        let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        collectionView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
        view.layoutIfNeeded()
    }
    
    private func setupContainer(){
        self.view.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Setup Collection View
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilterItemCVC.self, forCellWithReuseIdentifier: "FilterItemCVC")
        collectionView.isScrollEnabled = false
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        ])
    }
    
    // MARK: - Setup Buttons
    private func setupButtons() {
        applyButton.setTitle("Apply", for: .normal)
        applyButton.backgroundColor = .white
        applyButton.layer.borderWidth = 1.0
        applyButton.layer.cornerRadius = 12
        applyButton.layer.borderColor = UIColor.systemBlue.cgColor
        applyButton.setTitleColor(.systemBlue, for: .normal)
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        
        updateCancelButtonDisplay()
        cancelButton.backgroundColor = .white
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 12
        cancelButton.layer.borderColor = UIColor.systemRed.cgColor
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        containerView.addSubview(applyButton)
        containerView.addSubview(cancelButton)
        
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for buttons
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            applyButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            applyButton.heightAnchor.constraint(equalToConstant: viewModel.buttonHeight),
            applyButton.widthAnchor.constraint(equalToConstant: (view.bounds.width - 60)/2),
            applyButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            cancelButton.centerYAnchor.constraint(equalTo: applyButton.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: (view.frame.width - 60)/2),
            cancelButton.heightAnchor.constraint(equalToConstant: viewModel.buttonHeight)
        ])
    }
    
    // MARK: - Button Actions
    @objc private func applyButtonTapped() {
        updateDelegate?.filtersUpdated(options: viewModel.selectedOptions)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        if !viewModel.shouldShowCancel{
            updateDelegate?.filtersUpdated(options: [])
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension CTFilterPopupVC: CTFilterViewModelDelegate{
    
    func updateCancelButtonDisplay(){
        cancelButton.setTitle(viewModel.cencelButtonTitle, for: .normal)
    }
    
}

extension CTFilterPopupVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionView DataSource & Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = viewModel.dataForItem(at: indexPath) else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterItemCVC", for: indexPath) as! FilterItemCVC
        if data.selected{
            cell.label.textColor = .white
            cell.label.layer.borderColor = UIColor.systemBlue.cgColor
            cell.label.backgroundColor = .systemBlue
        }else{
            cell.label.textColor = .black
            cell.label.layer.borderColor = UIColor.black.cgColor
            cell.label.backgroundColor = .white
        }
        cell.label.text = data.displayName
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let data = viewModel.dataForItem(at: indexPath) else {
            return .zero
        }
        let label = UILabel()
        label.text = data.displayName
        label.sizeToFit()
        let width = label.frame.width + 20
        return CGSize(width: width, height: viewModel.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.toggleSelection(at: indexPath)
        viewModel.setCancelButtonState()
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterItemCVC, let data = viewModel.dataForItem(at: indexPath) {
            if data.selected{
                cell.label.textColor = .white
                cell.label.layer.borderColor = UIColor.systemBlue.cgColor
                cell.label.backgroundColor = .systemBlue
            }else{
                cell.label.textColor = .black
                cell.label.layer.borderColor = UIColor.black.cgColor
                cell.label.backgroundColor = .white
            }
        }
    }
    
}




