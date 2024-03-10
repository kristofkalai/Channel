# Channel
Handle callbacks and updates as easy as pie! 🥧

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/Channel", exact: .init(0, 0, 1))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app)

## Usage

```swift
import SwiftUI
import Combine

final class Producer {
    private let channel: BaseChannel<Int>
    private let startDate = Date()
    private var cancellables = Set<AnyCancellable>()

    init(channel: BaseChannel<Int>) {
        self.channel = channel
    }

    func start() {
        cancellables.forEach { $0.cancel() }
        cancellables = .init()

        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .map { [unowned self] in Int($0.timeIntervalSince(startDate)) }
            .sink { [unowned self] in channel.send(value: $0) }
            .store(in: &cancellables)
    }
}

// ...

struct ContentView: View {
    private let channel = ClosureChannel<Int>()
    private let producer: Producer

    init() {
        self.producer = .init(channel: channel)
    }

    var body: some View {
        Text("Hello, world!")
            .task  {
                producer.start()
                try? await Task.sleep(nanoseconds: 500_000_000)
                channel.receiveOutput = {
                    print($0)
                }
            }
    }
}
```

For details see the Example app.
