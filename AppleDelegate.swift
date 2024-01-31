import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let toDoList = ToDoList()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Save the to-do list data here
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Present the notification here
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the user's response to the notification here
    }

    func scheduleReminder(for item: ToDoItem) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder: \(item.title)"
        content.body = "Due today: \(item.dueDate)"
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: item.dueDate), repeats: false)

        let requestIdentifier = "toDoItem-\(item.title)"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling reminder for \(item.title): \(error.localizedDescription)")
            }
        }
    }

    func addItem(title: String, dueDate: Date) {
        toDoList.addItem(title: title, dueDate: dueDate)
        scheduleReminder(for: toDoList.items.last!)
    }

    func markItemCompleted(at index: Int) {
        toDoList.markItemCompleted(at: index)
    }

    func getItemsWithinDays(days: Int) -> [ToDoItem] {
        return toDoList.getItemsWithinDays(days: days)
    }
}