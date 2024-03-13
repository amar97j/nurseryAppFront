import UIKit
import Alamofire

class NurseryViewController: UITableViewController {
    var nurseries: [Nursery] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchNurseriesData()
        setUpNav()
        setupNavigationBar()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nurseries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let nursery = nurseries[indexPath.row]
        cell.textLabel?.text = nursery.name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNursery = nurseries[indexPath.row]
        showNurseryDetails(for: selectedNursery)
    }

    func fetchNurseriesData() {
        NetworkManager.shared.fetchNurseries { fetchedNurseries in
            DispatchQueue.main.async {
                self.nurseries = fetchedNurseries ?? []
                self.tableView.reloadData()
            }
        }
    }

    func showNurseryDetails(for nursery: Nursery) {
      
    }

    func setUpNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNurseryTapped))
    }

    @objc private func addNurseryTapped() {
    }
}
