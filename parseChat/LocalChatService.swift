//
//  LocalChatService.swift
//  parseChat — replaces Parse SDK with in-memory store + UserDefaults auth
//

import Foundation

struct ChatMessage {
    let text: String
    let username: String
    let createdAt: Date
}

@MainActor
final class LocalChatService {

    static let shared = LocalChatService()
    private init() {}

    private(set) var messages: [ChatMessage] = []

    var currentUsername: String? {
        get { UserDefaults.standard.string(forKey: "currentUser") }
        set { UserDefaults.standard.set(newValue, forKey: "currentUser") }
    }

    var isLoggedIn: Bool { currentUsername != nil }

    func login(username: String, password: String) throws {
        guard !username.isEmpty, !password.isEmpty else {
            throw NSError(domain: "Auth", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Username and password required"])
        }
        currentUsername = username
    }

    func signup(username: String, password: String) throws {
        try login(username: username, password: password)
    }

    func logout() {
        currentUsername = nil
    }

    func send(text: String) {
        guard let user = currentUsername else { return }
        messages.insert(ChatMessage(text: text, username: user, createdAt: Date()), at: 0)
    }

    func fetchMessages() -> [ChatMessage] {
        messages
    }
}
