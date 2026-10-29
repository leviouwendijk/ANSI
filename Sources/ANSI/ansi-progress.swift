public enum ANSIProgress: Sendable, Hashable {
    case inactive
    case normal(percentage: Int)
    case error(percentage: Int? = nil)
    case indeterminate
    case paused(percentage: Int? = nil)

    public func encoded(terminator: ANSITerminator = .bel) -> String {
        let state: Int
        let percentage: Int

        switch self {
        case .inactive:
            state = 0
            percentage = 0
        case .normal(let value):
            state = 1
            percentage = value
        case .error(let value):
            state = 2
            percentage = value ?? 0
        case .indeterminate:
            state = 3
            percentage = 0
        case .paused(let value):
            state = 4
            percentage = value ?? 0
        }

        return "\u{001B}]9;4;\(state);\(min(100, max(0, percentage)))\(terminator.value)"
    }
}
