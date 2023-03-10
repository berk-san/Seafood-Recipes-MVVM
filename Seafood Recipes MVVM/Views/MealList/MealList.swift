//
//  MealList.swift
//  Seafood Recipes MVVM
//
//  Created by Berk on 22.02.2023.
//

import UIKit

class MealList: UIViewController {
    
    private let viewModel: MealListViewModel = MealListViewModel()
    
    var cellViewModelArray: [MealCellViewModel] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBinders()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()
    }
    
    func configureUI() {
        self.title = "Meals"
        self.view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    func setupBinders() {
        viewModel.isLoading.bind { [weak self] loading in
            guard let self = self, let loading = loading else { return }
            DispatchQueue.main.async {
                if loading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataArray.bind { [weak self] mealArray in
            guard let self = self, let mealArray = mealArray else { return }
            self.cellViewModelArray = mealArray
            self.reloadTableView()
        }
    }
}

extension MealList: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        
        registerCell()
    }
    
    func registerCell() {
        tableView.register(MealCell.register(), forCellReuseIdentifier: MealCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.setNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.identifier, for: indexPath) as? MealCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = cellViewModelArray[indexPath.row]
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mealID = cellViewModelArray[indexPath.row].id
        print(mealID)
        DispatchQueue.main.async {
            let recipeViewModel = RecipeViewModel(id: mealID)
            let destinationVC = Recipe(viewModel: recipeViewModel)
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
