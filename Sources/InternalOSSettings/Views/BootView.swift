import SwiftUI

struct BootView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Boot")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.primary)

                        Text("Boot configuration, firmware, and initialization")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                    VStack(spacing: 0) {
                        SectionHeader("Firmware")

                        VStack(spacing: 0) {
                            SettingRow(label: "iBoot", value: "iBoot-1940.10.58")
                            SettingRow(label: "SecureROM", value: "e10000a.rom")
                            SettingRow(label: "Baseband", value: "mdm9615m")
                            SettingRow(label: "Bootloader", value: "LLB-1940.6.11")
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("Current Boot Arguments")

                        VStack(alignment: .leading, spacing: 12) {
                            BootArgItem(flag: "rd=disk0s1s3", description: "Root device specification")
                            BootArgItem(flag: "amfi=0xff", description: "AMFI debugging enabled")
                            BootArgItem(flag: "debug=0x14e", description: "Kernel debug flags")
                            BootArgItem(flag: "cs_enforcement_disable=1", description: "Code signature enforcement disabled")
                            BootArgItem(flag: "serial=3", description: "Serial debugging enabled")
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("NVRAM Settings")

                        VStack(spacing: 0) {
                            SettingRow(label: "boot-args", value: "rd=disk0s1s3...")
                            SettingRow(label: "auto-boot", value: "true")
                            SettingRow(label: "BootVolume", value: "disk0s1s1")
                            SettingRow(label: "SystemAudioVolume", value: "36%")
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("Boot Performance")

                        HStack(spacing: 12) {
                            BootMetric(label: "iBoot Time", value: "245ms", icon: "bolt.fill")
                            BootMetric(label: "Kernel Time", value: "1.2s", icon: "hare.fill")
                            BootMetric(label: "Total Boot", value: "18.5s", icon: "timer")
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

struct BootArgItem: View {
    let flag: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(flag)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.blue)
                .textSelection(.enabled)

            Text(description)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
    }
}

struct BootMetric: View {
    let label: String
    let value: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.orange)
                Spacer()
            }

            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.primary)

            Text(label)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    BootView()
}
