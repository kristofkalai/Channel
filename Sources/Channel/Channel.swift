//
//  Channel.swift
//
//
//  Created by Kristóf Kálai on 10/03/2024.
//

public protocol Channel {
    associatedtype Output

    func send(value: Output)
}
