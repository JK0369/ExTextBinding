//
//  ViewController.swift
//  ExTextBinding
//
//  Created by 김종권 on 2023/11/29.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
private let textField = {
        let v = UITextField()
        v.textColor = .black
        v.placeholder = "input..."
        v.font = .systemFont(ofSize: 24)
        v.backgroundColor = .lightGray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    private let button = {
        let button = UIButton()
        button.setTitle("adding text", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let disposeBag = DisposeBag()
    private var observer: NSKeyValueObservation?
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
            
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        textField.rx.text
            .bind { text in
                print("textView.rx.text>", text!)
            }
            .disposed(by: disposeBag)
        
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(allEditingEvents), for: .allEditingEvents)
        textField.delegate = self
    }
    
    @objc private func tap() {
        textField.insertText("new ")
    }
    
    @objc private func editingChanged() {
        print("editingChanged>", textField.text!)
    }
    
    @objc private func allEditingEvents() {
        print("allEditingEvents> ", textField.text!)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("shouldChangeCharactersIn>", textField.text!, string)
        return true
    }
}
