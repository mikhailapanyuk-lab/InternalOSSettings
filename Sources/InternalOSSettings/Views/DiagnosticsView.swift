import SwiftUI

struct DiagnosticsView: View {
    let metrics: [MetricCard] = [
        MetricCard(title: "CPU", value: "32.4°C", detail: "Nominal"),
        MetricCard(title: "Memory", value: "5.1 GB", detail: "Free"),
        MetricCard(title: "Storage", value: "18.4 GB", detail: "Available"),
        MetricCard(title: "Battery", value: "87%", detail: "Charging")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(metrics) { metric in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(metric.title)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(metric.value)
                                .font(.title2)
                                .fontWeight(.semibold)

                            Text(metric.detail)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    }
                }
                .padding()
            }
            .navigationTitle("Diagnostics")
        }
    }
}
