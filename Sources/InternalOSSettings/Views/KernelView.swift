import SwiftUI
import Foundation

struct KernelView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Kernel")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.primary)

                        Text("System core information and debugging flags")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                    VStack(spacing: 0) {
                        SectionHeader("Kernel Version")

                        VStack(spacing: 0) {
                            SettingRow(label: "Version", value: "xnu-2423.1.73~3")
                            SettingRow(label: "Build", value: "23A249d")
                            SettingRow(label: "Type", value: "Release")
                            SettingRow(label: "Compiled", value: "2026-09-15")
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("Debug Settings")

                        VStack(spacing: 0) {
                            ToggleRow(label: "Verbose Logging", isOn: true)
                            ToggleRow(label: "Kernel Panic Logs", isOn: true)
                            ToggleRow(label: "Memory Debugging", isOn: false)
                            ToggleRow(label: "Performance Monitoring", isOn: true)
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("System Flags")

                        VStack(spacing: 8) {
                            FlagPill("debug=0x14e")
                            FlagPill("rd=disk0s1s3")
                            FlagPill("amfi=0xff")
                            FlagPill("cs_enforcement_disable=1")
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("Performance Metrics")

                        HStack(spacing: 12) {
                            MetricBox(title: "Uptime", value: "42h 15m", icon: "clock.fill")
                            MetricBox(title: "Processes", value: "487", icon: "square.stack.3d.up.fill")
                            MetricBox(title: "Threads", value: "2,847", icon: "network")
                        }
                        .padding(12)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}

struct SectionHeader: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
    }
}

struct ToggleRow: View {
    let label: String
    @State var isOn: Bool

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.primary)

            Spacer()

            Toggle("", isOn: $isOn)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}

struct FlagPill: View {
    let value: String

    init(_ value: String) {
        self.value = value
    }

    var body: some View {
        Text(value)
            .font(.system(size: 13, weight: .regular))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.blue.opacity(0.12))
            .foregroundStyle(.blue)
            .clipShape(Capsule())
    }
}

struct MetricBox: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.blue)
                Spacer()
            }

            Text(value)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.primary)

            Text(title)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    KernelView()
}
