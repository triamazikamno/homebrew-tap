cask "railoxide" do
  version "0.2.0-beta.12"
  sha256 "b8dc9e2208181cde3a15d4c4dcafd99fd893cb0309f96b7aa428971a058e3824"

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
