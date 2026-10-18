cask "pr-checker" do
  version "0.3.0"
  sha256 "bf1f6bddb081e03260b962f16c040a79e65238fa41248d7133da726cbebe705a"

  url "https://github.com/itsberkelium/PR-Checker/releases/download/macOS-v#{version}/PR-Checker-#{version}.zip"
  name "PR Checker"
  desc "Menu bar app for Bitbucket Server/Data Center pull requests"
  homepage "https://github.com/itsberkelium/PR-Checker"

  livecheck do
    url :url
    regex(/^macOS-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"] || release["prerelease"]

        release["tag_name"]&.[](regex, 1)
      end
    end
  end

  auto_updates true
  depends_on macos: :sequoia

  app "PR Checker.app"

  zap trash: [
    "~/Library/Application Support/dev.berke.PRChecker",
    "~/Library/Caches/dev.berke.PRChecker",
    "~/Library/Preferences/dev.berke.PRChecker.plist",
  ]
end
