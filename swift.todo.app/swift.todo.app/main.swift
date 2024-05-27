//
//  main.swift
//  swift.todo.app
//
//  Created by Mostafa ElSheikh on 27/05/2024.

import Foundation

struct Todo: Codable {
    let id: UUID
    let title: String
    var isCompleted: Bool
}

protocol Cache {
    func save(todos: [Todo]) -> [Todo]
    func load() -> [Todo]?
}

final class JSONFileManagerCache: Cache {
    private let fileName = "todos.json"
    private let fileManager = FileManager.default

    private var fileURL: URL? {
        fileManager.urls(for: .documentationDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }

    func save(todos: [Todo]) -> [Todo] {
        guard let fileURL = fileURL else {
            return []
        }
        do {
            let data = try JSONEncoder().encode(todos)
            try data.write(to: fileURL)
            return todos
        } catch {
            print("❗Failed to save todos: \(error)")
            return []
        }
    }

    func load() -> [Todo]? {
        guard let fileURL = fileURL else {
            return nil
        }
        do {
            if !fileManager.fileExists(atPath: fileURL.path) {
                try createEmptyFile(at: fileURL)
                return []
            }
            let data = try Data(contentsOf: fileURL)
            let todos = try JSONDecoder().decode([Todo].self, from: data)
            return todos
        } catch {
            print("❗Failed to load todos: \(error)")
            return nil
        }
    }

    private func createEmptyFile(at url: URL) throws {
        try fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
        try Data().write(to: url)
    }


}

final class InMemoryCache: Cache {
    private var todos: [Todo] = []

    func save(todos: [Todo]) -> [Todo] {
        self.todos = todos
        return todos
    }

    func load() -> [Todo]? {
        todos
    }


}

final class TodoManager {
    private var todos: [Todo]
    private let cache: Cache

    init(cache: Cache) {
        self.cache = cache
        self.todos = cache.load() ?? []
    }

    func listTodos() {
        for (index, todo) in todos.enumerated() {
            let status = todo.isCompleted ? "✅" : "❌"
            print("\(index): \(todo.title) [\(status)]")
        }
    }

    func addTodo(with title: String) {
        let todo = Todo(id: UUID(), title: title, isCompleted: false)
        todos.append(todo)
        cache.save(todos: todos)
    }

    func toggleCompletion(forTodoAtIndex index: Int) {
        guard index >= 0 && index < todos.count else {
            return
        }
        todos[index].isCompleted.toggle()
    }

    func deleteTodo(atIndex index: Int) {
        guard index >= 0 && index < todos.count else {
            return
        }
        todos.remove(at: index)
        cache.save(todos: todos)
    }
}


final class App {
    private let todoManager: TodoManager

    init(cache: Cache) {
        self.todoManager = TodoManager(cache: cache)
    }

    func run() {
        while true {
            print("Enter a command (📌 add, 📝 list, toggle, 🗑️ delete, 👋 exit):")
            guard let input = readLine() else {
                continue
            }
            let components = input.split(separator: " ")
            guard let commandString = components.first, let command = Command(rawValue: String(commandString)) else {
                continue
            }

            switch command {
            case .add:
                if components.count > 1 {
                    let title = components.dropFirst().joined(separator: " ")
                    todoManager.addTodo(with: title)
                } else {
                    print("Title is required for add command.")
                }
            case .list:
                todoManager.listTodos()
            case .toggle:
                if let indexString = components.dropFirst().first, let index = Int(indexString) {
                    todoManager.toggleCompletion(forTodoAtIndex: index)
                } else {
                    print("Index is required for toggle command.")
                }
            case .delete:
                if let indexString = components.dropFirst().first, let index = Int(indexString) {
                    todoManager.deleteTodo(atIndex: index)
                } else {
                    print("Index is required for delete command.")
                }
            case .exit:
                return
            }
        }
    }

    enum Command: String {
        case add
        case list
        case toggle
        case delete
        case exit
    }
}

let cache = JSONFileManagerCache()
//let cache = InMemoryCache()

let app = App(cache: cache)
app.run()
