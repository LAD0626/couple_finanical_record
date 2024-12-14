import UIKit

class mainViewController: UIViewController {

    // 模擬的數據變數
    var user1Income: Int = 10000
    var user1Savings: Int = 15000
    var user1Expenses: Int = 5000

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemGray6

        // 頭像視圖
        let avatarView = CoupleAvatarView(user1Image: UIImage(systemName: "person.circle"), user2Image: UIImage(systemName: "person.circle.fill"))
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        // 卡片視圖
        let userCard1 = UserCardView(userName: "User 1", income: "¥10000", expense: "¥5000", savings: "¥15000", budget: "¥12000", cardColor: UIColor.systemGreen)
        let userCard2 = UserCardView(userName: "User 2", income: "¥12000", expense: "¥7000", savings: "¥10000", budget: "¥8000", cardColor: UIColor.systemRed)
               
        // 按鈕區域
        let buttonsView = ButtonsView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false

        // 設置按鈕事件
        buttonsView.onAddIncome = { [weak self] in
            self?.showInputAlert(title: "記錄收入", isAddingIncome: true)
        }

        buttonsView.onAddExpense = { [weak self] in
            self?.showInputAlert(title: "記錄支出", isAddingIncome: false)
        }

        buttonsView.onSettings = { [weak self] in
            self?.showSettingsScreen()
        }

        // 使用 StackView 垂直排列所有視圖
        let stackView = UIStackView(arrangedSubviews: [avatarView, userCard1,userCard2, buttonsView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // 小視窗 - 記錄收入或支出
    func showInputAlert(title: String, isAddingIncome: Bool) {
        let alert = UIAlertController(title: title, message: "請輸入金額", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "金額"
            textField.keyboardType = .numberPad
        }
        let submitAction = UIAlertAction(title: "確定", style: .default) { [weak self] _ in
            if let amountText = alert.textFields?.first?.text, let amount = Int(amountText) {
                self?.updateFinancialData(amount: amount, isAddingIncome: isAddingIncome)
            }
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    // 更新數據
    func updateFinancialData(amount: Int, isAddingIncome: Bool) {
        if isAddingIncome {
            user1Income += amount
            user1Savings += amount
        } else {
            user1Income -= amount
            user1Savings -= amount
        }
        viewDidLoad() // 重新載入畫面以更新數據
    }

    // 設定畫面
    func showSettingsScreen() {
        let settingsVC = UIViewController()
        settingsVC.view.backgroundColor = UIColor.systemBackground
        settingsVC.title = "設定"
        let navigationController = UINavigationController(rootViewController: settingsVC)
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - 頭像視圖
class CoupleAvatarView: UIView {
    
    init(user1Image: UIImage?, user2Image: UIImage?) {
        super.init(frame: .zero)
        
        // User 1 頭像
        let user1Avatar = UIImageView(image: user1Image ?? UIImage(systemName: "person.circle"))
        user1Avatar.contentMode = .scaleAspectFill
        user1Avatar.layer.cornerRadius = 40
        user1Avatar.layer.masksToBounds = true
        user1Avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let user1Label = UILabel()
        user1Label.text = "User 1"
        user1Label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        user1Label.textAlignment = .center
        
        let user1Stack = UIStackView(arrangedSubviews: [user1Avatar, user1Label])
        user1Stack.axis = .vertical
        user1Stack.alignment = .center
        user1Stack.spacing = 8
        
        // 愛心圖案
        let heartImage = UIImageView(image: UIImage(systemName: "heart.fill"))
        heartImage.tintColor = .systemRed
        heartImage.contentMode = .scaleAspectFit
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        
        // User 2 頭像
        let user2Avatar = UIImageView(image: user2Image ?? UIImage(systemName: "person.circle"))
        user2Avatar.contentMode = .scaleAspectFill
        user2Avatar.layer.cornerRadius = 40
        user2Avatar.layer.masksToBounds = true
        user2Avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let user2Label = UILabel()
        user2Label.text = "User 2"
        user2Label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        user2Label.textAlignment = .center
        
        let user2Stack = UIStackView(arrangedSubviews: [user2Avatar, user2Label])
        user2Stack.axis = .vertical
        user2Stack.alignment = .center
        user2Stack.spacing = 8
        
        // 主視圖 StackView
        let mainStackView = UIStackView(arrangedSubviews: [user1Stack, heartImage, user2Stack])
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        
        // 設置約束
        NSLayoutConstraint.activate([
            user1Avatar.widthAnchor.constraint(equalToConstant: 80),
            user1Avatar.heightAnchor.constraint(equalToConstant: 80),
            user2Avatar.widthAnchor.constraint(equalToConstant: 80),
            user2Avatar.heightAnchor.constraint(equalToConstant: 80),
            heartImage.widthAnchor.constraint(equalToConstant: 30),
            heartImage.heightAnchor.constraint(equalToConstant: 30),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 按鈕區塊
class ButtonsView: UIView {
    var onAddIncome: (() -> Void)?
    var onAddExpense: (() -> Void)?
    var onSettings: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        let incomeButton = createButton(title: "記錄收入", action: #selector(addIncomeTapped))
        let expenseButton = createButton(title: "記錄支出", action: #selector(addExpenseTapped))
        let settingsButton = createButton(title: "其他設定", action: #selector(settingsTapped))

        let stackView = UIStackView(arrangedSubviews: [incomeButton, expenseButton, settingsButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }

    @objc func addIncomeTapped() { onAddIncome?() }
    @objc func addExpenseTapped() { onAddExpense?() }
    @objc func settingsTapped() { onSettings?() }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 卡片視圖
class UserCardView: UIView {
    init(userName: String, income: String, expense: String, savings: String, budget: String, cardColor: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        // 使用者名稱標題
        let titleLabel = UILabel()
        titleLabel.text = userName
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.backgroundColor = cardColor
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = 8
        titleLabel.clipsToBounds = true
        
        // 資訊區塊
        let infoStackView = UIStackView(arrangedSubviews: [
            createRow(title: "本月收入：", value: income),
            createRow(title: "本月支出：", value: expense),
            createRow(title: "目前存款：", value: savings),
            createRow(title: "本月可支配支出：", value: budget)
        ])
        infoStackView.axis = .vertical
        infoStackView.spacing = 8
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, infoStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = 12
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func createRow(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .darkGray
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16)
        valueLabel.textColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
