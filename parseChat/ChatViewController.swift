//
//  ChatViewController.swift
//  parseChat
//
//  Created by Gerard Recinto on 2/23/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@MainActor
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!

    private var messages: [ChatMessage] = []
    private var refreshTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        refreshMessages()
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.refreshMessages()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMessages()
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.refreshMessages()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        refreshTimer?.invalidate()
    }

    private func refreshMessages() {
        messages = LocalChatService.shared.fetchMessages()
        tableView.reloadData()
    }

    @IBAction func onSendButton(_ sender: Any) {
        let text = messageTextField.text ?? ""
        guard !text.isEmpty else { return }
        LocalChatService.shared.send(text: text)
        messageTextField.text = ""
        refreshMessages()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "ChatCell")
        let msg = messages[indexPath.row]
        cell.textLabel?.text = msg.text
        cell.detailTextLabel?.text = msg.username
        return cell
    }
}
