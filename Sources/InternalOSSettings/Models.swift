import Foundation

struct DeviceInfo: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}

struct MetricCard: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let detail: String
}
