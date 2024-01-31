import Foundation

class ToDoItem {
    var title: String
    var dueDate: Date
    var isCompleted: Bool

    init(title: String, dueDate: Date, isCompleted: Bool = false) {
        self.title = title
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}
Next, create another Swift file called "ToDoList.swift" and add the following code:

Copy code
import Foundation

class ToDoList {
    var items: [ToDoItem]

    init() {
        self.items = []
    }

    func addItem(title: String, dueDate: Date) {
        let item = ToDoItem(title: title, dueDate: dueDate)
        items.append(item)
    }

    func markItemCompleted(at index: Int) {
        items[index].isCompleted = true
    }

    func getItemsWithinDays(days: Int) -> [ToDoItem] {
        let calendar = Calendar.current
        let today = Date()
        let endDate = calendar.date(byAdding: .day, value: days, to: today)!
        return items.filter { item in
            return calendar.isDate(item.dueDate, inSameDayAs: today) || calendar.isDate(item.dueDate, before: endDate)
        }
    }
}