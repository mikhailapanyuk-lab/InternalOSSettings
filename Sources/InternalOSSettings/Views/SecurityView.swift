import SwiftUI

struct SecurityView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Security")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(.primary)

                        Text("Code signing, entitlements, and security policies")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)

                    VStack(spacing: 0) {
                        SectionHeader("Code Signing")

                        VStack(spacing: 0) {
                            SettingRow(label: "Enforcement", value: "Disabled")
                            SettingRow(label: "Mode", value: "Development")
                            SettingRow(label: "Signature", value: "Valid")
                            SettingRow(label: "Team ID", value: "XXXXXXXXXX")
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("Entitlements")

                        VStack(spacing: 8) {
                            EntitlementPill("com.apple.private.security.no-container", granted: true)
                            EntitlementPill("platform-application", granted: true)
                            EntitlementPill("com.apple.private.amfi", granted: false)
                            EntitlementPill("task_for_pid-allow", granted: false)
                            EntitlementPill("run-unsigned-code", granted: true)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("Security Policies")

                        VStack(spacing: 0) {
                            PolicyRow(name: "Sandbox", status: "Enabled", icon: "checkmark.circle.fill", color: .green)
                            PolicyRow(name: "ASLR", status: "Enabled", icon: "checkmark.circle.fill", color: .green)
                            PolicyRow(name: "DEP", status: "Enabled", icon: "checkmark.circle.fill", color: .green)
                            PolicyRow(name: "PAC", status: "Enabled", icon: "checkmark.circle.fill", color: .green)
                        }
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal, 16)

                    VStack(spacing: 0) {
                        SectionHeader("Trust & Certificates")

                        VStack(spacing: 0) {
                            SettingRow(label: "Root Certs", value: "168")
                            SettingRow(label: "Trusted CAs", value: "42")
                            SettingRow(label: "Device Cert", value: "Valid")
                        }
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

struct EntitlementPill: View {
    let value: String
    let granted: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: granted ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(granted ? .green : .red)

            Text(value)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(.primary)

            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

struct PolicyRow: View {
    let name: String
    let status: String
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.primary)

                Text(status)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(color)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
    }
}

#Preview {
    SecurityView()
}
