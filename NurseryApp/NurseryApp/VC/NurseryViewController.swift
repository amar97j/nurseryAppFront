import UIKit
import Alamofire

class NurseryViewController: UITableViewController {
    var nurseries: [Nursery] = []
    var favoriteStates: [Bool] = []
    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NurseryTableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchNurseriesData()
        setUpNav()
        setupNavigationBar()
        setupTableView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nurseries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NurseryTableViewCell
        let nursery = nurseries[indexPath.row]
        cell.configure(with: nursery, isFavorite: favoriteStates[indexPath.row])
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNursery = nurseries[indexPath.row]
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
                self.tableView.reloadData()
            }
        }
    }

    func showNurseryDetails(for nursery: Nursery) {
    }

    func setUpNav() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 53/255, green: 152/255, blue: 219/255, alpha: 1.0)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        title = "Nurseries"
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNurseryTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc private func addNurseryTapped() {
    }

    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        favoriteStates[index].toggle() 
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)     }

    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 140
        tableView.estimatedRowHeight = 140
        tableView.backgroundColor = UIColor(red: 236/255, green: 240/255, blue: 241/255, alpha: 1.0)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
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

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            nurseryImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nurseryImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            nurseryImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            nurseryImageView.widthAnchor.constraint(equalToConstant: 80), // Adjust the width here

            nameLabel.leadingAnchor.constraint(equalTo: nurseryImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),

            locationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),

            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            favoriteButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
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
