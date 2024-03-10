//
//  OddChannel.swift
//  Example
//
//  Created by Kristóf Kálai on 10/03/2024.
//

import Channel

final class OddChannel: AsyncChannel<Int> {
    override func send(value: Int) {
        if !value.isMultiple(of: 2) {
            super.send(value: value)
        }
    }
}
