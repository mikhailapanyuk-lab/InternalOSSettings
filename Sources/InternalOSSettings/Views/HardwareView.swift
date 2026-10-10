import SwiftUI

struct HardwareView: View {
    let hardware: [DeviceInfo] = [
        DeviceInfo(title: "Model", value: "iPhone 14 Pro"),
        DeviceInfo(title: "Board", value: "N41AP"),
        DeviceInfo(title: "SoC", value: "Apple A16 Bionic"),
        DeviceInfo(title: "Memory", value: "6 GB LPDDR5"),
        DeviceInfo(title: "Storage", value: "512 GB NVMe"),
        DeviceInfo(title: "Battery", value: "92% health")
    ]

    var body: some View {
        NavigationStack {
            List {
                Section("Device") {
                    ForEach(hardware) { item in
                        SettingRow(label: item.title, value: item.value)
                    }
                }
            }
            .navigationTitle("Hardware")
        }
    }
}
