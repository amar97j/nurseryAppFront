import UIKit
import Alamofire
import SnapKit
class NurseryViewController: UITableViewController {
    
    var nurseries: [Nursery] = []
    var favoriteStates: [Bool] = []
    var filteredNurseries: [Nursery] = []
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterOptions))
        navigationItem.rightBarButtonItem = filterButton
        
        
        tableView.register(NurseryTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        token = UserDefaults.standard.string(forKey: "tokenAuth")
        
        setUpNavigationBar()
        fetchNurseriesData()
        setUpNav()
        setupTableView()
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNurseries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NurseryTableViewCell
        let nursery = filteredNurseries[indexPath.row]
        cell.configure(with: nursery, isFavorite: favoriteStates[indexPath.row])
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNursery = filteredNurseries[indexPath.row]
        showNurseryDetails(for: selectedNursery)
    }
    
    func fetchNurseriesData() {
        guard let token = token else {
            return
        }
        
        NetworkManager.shared.fetchNurseries(token: token) { fetchedNurseries in
            DispatchQueue.main.async {
                self.nurseries = fetchedNurseries ?? []
                self.favoriteStates = Array(repeating: false, count: self.nurseries.count)
                self.filteredNurseries = self.nurseries
                self.tableView.reloadData()
            }
        }
    }
    
    func showNurseryDetails(for nursery: Nursery) {
        let detailNurseryController = DetailNurseryController()
        detailNurseryController.nursery = nursery
        self.present(detailNurseryController, animated: true)
    }
    
    
    func setUpNav() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 53/255, green: 152/255, blue: 219/255, alpha: 1.0)
        //        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Nurseries"
    }
    
    
    
    
    
    
    
    
    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        favoriteStates[index].toggle()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
        tableView.estimatedRowHeight = 140
        tableView.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    
    
    
    @objc private func showFilterOptions() {
        let alertController = UIAlertController(title: "Filter Options", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Choose Area", style: .default, handler: { _ in
            self.filterByArea()
        }))
        
        alertController.addAction(UIAlertAction(title: "Clear Filter", style: .destructive, handler: { _ in
            self.clearFilter()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // For iPad, present the alert controller as a popover
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: new area filter
    private func filterByArea() {
        let areaFilterAlert = UIAlertController(title: "Filter by Area", message: nil, preferredStyle: .actionSheet)
        
        let areas = [
            ["id": 1, "name": "Hawally"],
            ["id": 2, "name": "Al-Asimah"],
            ["id": 3, "name": "Mubarak Al-Kabir"],
            ["id": 4, "name": "Al-Ahmadi"],
            ["id": 5, "name": "Al-Farwaniya"],
            ["id": 6, "name": "Al-Jahra"]
        ]
        
        for area in areas {
            guard let areaName = area["name"] as? String, let areaId = area["id"] as? Int else {
                continue
            }
            
            let action = UIAlertAction(title: areaName, style: .default) { _ in
                self.filterNurseries(with: areaId)
            }
            areaFilterAlert.addAction(action)
        }
        
        areaFilterAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(areaFilterAlert, animated: true, completion: nil)
    }
    
    
    
    private func clearFilter() {
        filteredNurseries = nurseries
        tableView.reloadData()
    }
    
    private func filterNurseries(with filterId: Int) {
        filteredNurseries = nurseries.filter { nursery in
            return nursery.areaId.id == filterId || nursery.caseId.id == filterId
        }
        tableView.reloadData()
    }
    func setUpNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterOptions))
        navigationItem.rightBarButtonItem = filterButton
    }
    
}


class NurseryTableViewCell: UITableViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nurseryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        
        containerView.addSubview(nurseryImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(locationLabel)
        containerView.addSubview(favoriteButton)
        
        
        
        containerView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
        }
        
        nurseryImageView.snp.makeConstraints { make in
            make.leading.equalTo(containerView)
            make.top.equalTo(containerView)
            make.width.height.equalTo(90)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nurseryImageView.snp.trailing).offset(16)
            make.top.equalTo(containerView).offset(16)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView).offset(-16)
            make.bottom.equalTo(containerView).offset(-16)
            make.width.height.equalTo(24)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with nursery: Nursery, isFavorite: Bool) {
        nameLabel.text = nursery.name
        locationLabel.text = nursery.location
        guard let imageURLString = nursery.imageUrl, let imageUrl = URL(string: imageURLString) else {
            return
        }
        downloadImage(from: imageUrl)
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .red : .systemGray
    }
    
    private func downloadImage(from url: URL) {
        AF.request(url).responseData { response in
            guard let data = response.data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.nurseryImageView.image = image
            }
        }
    }
}

