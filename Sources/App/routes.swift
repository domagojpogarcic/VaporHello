import Vapor
import Fluent

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works, hello!!!!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!!!!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    
    
    router.post("api", "users") { req -> Future<User> in
        let user = try req.content.syncDecode(User.self)
        return user.save(on: req)
    }
    
    router.get("api", "users") { req -> Future<[User]> in
        return User.query(on: req).all()
    }
    
    router.get("api", "users", User.parameter) { req -> Future<User> in
        return try req.parameters.next(User.self)
    }
    
    router.get("api/users/search") { req -> Future<[User]> in
        guard let searchName = req.query[String.self, at: "term"] else {
            throw Abort(.badRequest)
        }
        
        return User.query(on: req).filter(\.name == searchName).all()
    }
}
