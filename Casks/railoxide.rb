cask "railoxide" do
  version "0.2.0-beta.13"
  sha256 "c4a9f0b16e0a115b8d71b56cb5a96df44c46a9d73e91de6b7cb5c161c06b72e4"

  url "https://github.com/triamazikamno/railoxide/releases/download/v#{version}/RailOxide-v#{version}-macos-arm64.dmg"
  name "RailOxide"
  desc "Desktop wallet for RAILGUN private transactions"
  homepage "https://github.com/triamazikamno/railoxide"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "RailOxide.app"

  # Remove quarantine from the installed app only; the app is ad-hoc signed and not notarized.
  postflight_steps do
    run "/usr/bin/find",
        args:           ["{{appdir}}/RailOxide.app", "-xattrname", "com.apple.quarantine",
                         "-exec", "/usr/bin/xattr", "-s", "-d", "com.apple.quarantine", "{}", "+"],
        writable_paths: ["{{appdir}}/RailOxide.app"]
  end

  caveats <<~EOS
    RailOxide is ad-hoc signed and is not notarized by Apple. This cask removes
    the app's quarantine attribute to bypass the usual first-launch Gatekeeper
    assessment. Installing through this tap means trusting the project's published
    binaries and release process. Homebrew verifies the download checksum; it does
    not certify the app's safety.
  EOS
end
