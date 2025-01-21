import SwiftUI

struct HistoryView: View {
    @State private var searchText: String = "" // 搜索框绑定的文本
    let historyItems = [
        HistoryItem(title: "Salary", type: "income", date: "2025/04/01", description: "Monthly Salary", amount: "$5000"),
        HistoryItem(title: "Shopping", type: "expense", date: "2025/04/02", description: "Bought clothes", amount: "$200"),
        HistoryItem(title: "Investment", type: "income", date: "2025/04/03", description: "Stock earnings", amount: "$300"),
        HistoryItem(title: "Dining", type: "expense", date: "2025/04/04", description: "Restaurant bill", amount: "$50")
    ]

    var filteredItems: [HistoryItem] {
        if searchText.isEmpty {
            return historyItems
        } else {
            return historyItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            UserCard(imagePath: "person.circle")

            // 调用提取出来的 TextField 函数
            SearchBar(text: $searchText)

            // 调用提取出的 ScrollView 视图
            HistoryListView(filteredItems: filteredItems)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
    }
}

struct UserCard: View {
    let imagePath: String

    var body: some View {
        HStack(spacing:15) {
            Image(systemName: imagePath)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 10)

            Text("Level:")
                .font(.headline)

            Image(systemName: imagePath)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
        .padding([.leading, .trailing],45)
        .padding(.bottom, 10)
    }
}


struct HistoryDetailComponent: View {
    let item: HistoryItem

    var body: some View {
        let (iconName, iconColor): (String, Color) = {
            switch item.type {
            case "income":
                return ("arrow.up.circle", .green)
            case "expense":
                return ("arrow.down.circle", .red)
            default:
                return ("questionmark.circle", .gray)
            }
        }()

        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.headline)

                DetailText(title: "日期", value: item.date)
                DetailText(title: "描述", value: item.description)
                DetailText(title: "金額", value: item.amount)
            }
            .padding()

            Spacer()

            Button(action: {
                print("\(item.title) button tapped!")
            }) {
                Image(systemName: iconName)
                    .font(.largeTitle)
                    .foregroundColor(iconColor)
                    .padding(.trailing, 20)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal, 10)
    }
}

struct DetailText: View {
    let title: String
    let value: String

    var body: some View {
        Text("\(title): \(value)")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("搜尋記錄...", text: $text)
                .padding(.horizontal, 10) // 为文本添加左右内边距
                .padding(.vertical, 8) // 为文本添加上下内边距，增加高度
                .background(Color.gray.opacity(0.2)) // 灰色背景
                .cornerRadius(25)
                .overlay( // 添加边框
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(maxWidth: UIScreen.main.bounds.width / 3)
                .font(.subheadline)
        }
        .padding(.horizontal, 30) // 给 HStack 添加左右内边距
        .frame(maxWidth: .infinity, alignment: .leading) // 将 HStack 对齐到左侧
    }
}



struct HistoryListView: View {
    let filteredItems: [HistoryItem]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                if filteredItems.isEmpty {
                    Text("未找到符合的記錄")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ForEach(filteredItems) { item in
                        HistoryDetailComponent(item: item)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

// 数据模型
struct HistoryItem: Identifiable {
    let id = UUID() // 确保每个条目都是唯一的
    let title: String
    let type: String
    let date: String
    let description: String
    let amount: String
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
