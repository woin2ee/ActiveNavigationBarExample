//
//  HomeViewController.swift
//  ActiveNavigationBarExample
//
//  Created by Jaewon Yun on 5/15/24.
//

import PinLayout
import SFSafeSymbols
import SnapKit
import TaskStore
import Then
import UIKit
import UIKitPlus

struct CellImageUpdateKey: Hashable {
    let cellID: ObjectIdentifier
    let indexPath: IndexPath
}

final class HomeViewController: UITableViewController {

    let network: Network<RandomDogResponse> = Network<RandomDogResponse>()
    let imageLoader: ImageLoading = ImageLoader(urlSession: .shared)
    
    private var taskStore = TaskStore<CellImageUpdateKey>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Home"
        
        tableView.register(ImageTableViewCell.self)
    }
}

extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ImageTableViewCell.self, for: indexPath)
        let cellID = ObjectIdentifier(cell)
        
        taskStore.tasks(where: { $0.cellID == cellID })
            .forEach { $0.cancel() }
        
        cell.transitionToSkeletonView()
        
        let imageUpdateTask = Task {
            let randomDogURLString = "https://dog.ceo/api/breeds/image/random"
            guard let randomDogURL = URL(string: randomDogURLString) else {
                logger.error("Invalid URL: \(randomDogURLString)")
                return
            }
            guard let response = await network.request(url: randomDogURL) else {
                logger.error("Failed to receive response.")
                return
            }
            try Task.checkCancellation()
            guard let imageURL = URL(string: response.message) else {
                logger.error("Invalid URL: \(response.message)")
                return
            }
            let image = await imageLoader.load(from: imageURL)
            try Task.checkCancellation()
            
            cell.update(image: image ?? UIImage())
        }
        taskStore.setTask(imageUpdateTask, forKey: CellImageUpdateKey(cellID: cellID, indexPath: indexPath))
        
        cell.update(name: indexPath.description)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? ImageTableViewCell else {
            return
        }
        
        let detailViewState = DetailViewController.State(
            topImage: selectedCell.primaryImageView.image ?? UIImage(),
            title: selectedCell.nameLabel.text ?? ""
        )
        let detailViewController = DetailViewController(state: detailViewState)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
