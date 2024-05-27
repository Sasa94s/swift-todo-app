Swift Todo App
-----
"**Todos CLI**" app - a user-friendly command-line tool to manage tasks. This isn't just any to-do list; it's a playground to explore the depth of Swift programming.

The main code for the project can be found in `starter/main.swift`.

# Project Instructions
## Prerequisites
- Base SDK: `macOs 14.5`
- `Xcode v15.2`

## What am I building?

At the heart of this application are tasks. You can add them, mark them as done or pending, and sweep them away when they're no longer needed. Swift's object-oriented features shine here. You'll work with classes, structures, and arrays, diving deep into how they operate.

But there's more! Ever wondered how apps remember data after they're closed? That's where our caching mechanism comes into play. Through the Cache protocol, you'll get hands-on experience in data storage, choosing between saving data temporarily in memory or more permanently on your computer's file system.

Throughout this journey, not only will you hone your coding skills, but you'll also get a taste of designing intuitive software, all while immersing yourself in Swift's elegant syntax and capabilities.

## Program Sample Output

```sh
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
list
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
add Todo1
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
list
0: Todo: Todo1 [❌]
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
toggle 0
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
list
0: Todo: Todo1 [✅]
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
toggle 0
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
list
0: Todo: Todo1 [❌]
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
delete 0
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
list
Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):
exit
Program ended with exit code: 0
```

## Why am I building this?
You're building this command-line task management application for several compelling reasons. Firstly, it's a practical way to understand the fundamental principles of Swift. Rather than diving into abstract concepts, you'll be applying what you learn immediately, seeing the real-world impact of your code.

Secondly, by working on this project, you'll grasp the significance of functions and Object-Oriented Programming in Swift. These aren't just theoretical concepts; they are the very essence of most modern applications.

Additionally, the use of protocols in this project showcases how to write modular and adaptable Swift code. It's not about just building an app; it's about understanding the best practices that professional Swift developers use daily in the apps that we rely on everyday.

In conclusion, while you'll end up with a fully functional Todo application, the real takeaway is the deeper understanding and appreciation of Swift as a robust programming language, preparing you for more advanced coding adventures.

## How I build this?
### Starter Project - A simple empty project to start with

In this project, you will start with a "Starter Project," which lays the groundwork for your Swift application. This method allows for a structured approach, making it easier to build your application in manageable steps and simplifying the testing process.

To run and test the application refer to information on its README file.

### Designing Data - The Todo Struct
* `Todo` struct.
* Ensure it has properties: id (UUID), title (String), and isCompleted (Bool).

### Managing Data - TodosManager Class
* Build the `TodosManager` class.
* Design methods to add a todo, list todos, toggle a todo's completion status, and delete a todo.

### Interacting with App - The App Class
* `App` class with a run method:
  * Use an infinite loop to keep the app active.
  * Listen for user commands and execute respective actions.
* Implement the `Command` enum to define user commands:
  * **add**: Add a todo.
  * **list**: Show todos.
  * **toggle**: Change a todo's completion status.
  * **delete**: Remove a todo.
  * **exit**: Close the app.


### Refining Data Representation
* Enhance the `Todo` struct by conforming to the `CustomStringConvertible` [protocol](https://developer.apple.com/documentation/swift/customstringconvertible). This helps customize how a todo is displayed.
* Conform `Todo` to the `Codable` [protocol](https://developer.apple.com/documentation/swift/codable) to ease the process of encoding and decoding for caching.

### Introducing Persistence - Caching with Protocols
* `Cache` protocol to outline essential functionalities for data persistence.
* Two classes based on the Cache protocol: `FileSystemCache` for file-based storage and `InMemoryCache` for in-session storage.

## Documentation
### Todo Structure
The `Todo` struct has these attributes:
* `id`: A unique identifier using `UUID`.
* `title`: A string that describes the todo.
* `isCompleted`: A boolean to track if the todo is done.

### Managing Todos
The `TodosManager` class offers:
* A function `func listTodos()` to display all todos.
* A function named `func addTodo(with title: String)` to insert a new todo.
* A function named `func toggleCompletion(forTodoAtIndex index: Int)` to alter the completion status of a specific todo using its index.
* A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.

### App Interaction
* The `App` class has a `func run()` method, this method is perpetually await user input and execute commands.
* `Command` enum to specify user commands. Include cases such as `add`, `list`, `toggle`, `delete`, and `exit`.
  * The enum is nested inside the definition of the `App` class

### Enhancements with Protocols
* The `Todo` struct also conforms to the `Codable` protocol for encoding and decoding purposes.

### Persisting Todos
* A `Cache` protocol with the following methods are created:
  * `func save(todos: [Todo])`: Persists the given todos.
  * `func load() -> [Todo]?`: Retrieves and returns the saved todos, or nil if none exist.
* Two class implementations of this protocol offered:
  * `FileSystemCache`: This implementation utilizes the file system to persist and retrieve the list of todos. Utilize Swift's `FileManager` to handle file operations.
  * `InMemoryCache`: Keeps todos in an array or similar structure during the session. This won't retain todos across different app launches, but serves as a quick in-session cache.
* Integrating the cache into TodosManager:
  * The `TodosManager` class incorporates caching.
  * Upon initialization, one caching strategy (`FileSystemCache` or `InMemoryCache`) are employed based on the student's preference.
  * Adding, toggling, and deleting todos, also save the changes in the chosen cache.
  * Any existing todos are populated in the current list when initializing the `TodosManager`.

## Resources

|Resource Description|Link|
|---|---|
|CustomStringConvertible \| Apple documentation|[https://developer.apple.com/documentation/swift/customstringconvertible](https://developer.apple.com/documentation/swift/customstringconvertible)|
|Codable \| Apple documentation|[https://developer.apple.com/documentation/swift/codable](https://developer.apple.com/documentation/swift/codable)|
|Codable Basics|[https://www.swiftbysundell.com/basics/codable/](https://www.swiftbysundell.com/basics/codable/)|
|FileManager \| Apple documentation|[https://developer.apple.com/documentation/foundation/filemanager](https://developer.apple.com/documentation/foundation/filemanager)|
|Writing data to the documents directory|[https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory](https://www.hackingwithswift.com/books/ios-swiftui/writing-data-to-the-documents-directory)|
|Getting started with Unit Tests in Swift|[https://www.avanderlee.com/swift/unit-tests-best-practices/](https://www.avanderlee.com/swift/unit-tests-best-practices/)|
|How do you read from the command line?|[https://www.hackingwithswift.com/example-code/system/how-do-you-read-from-the-command-line](https://www.hackingwithswift.com/example-code/system/how-do-you-read-from-the-command-line)|
|Swift readLine(), Swift print()|[https://www.digitalocean.com/community/tutorials/swift-readline-swift-print](https://www.digitalocean.com/community/tutorials/swift-readline-swift-print)|
