# Homebrew formula for cckit — published to the jeiemgi/homebrew-cckit tap.
#   brew tap jeiemgi/cckit && brew install cckit
# The stable url/sha256 are bumped per release.
class Cckit < Formula
  desc "Project operating system for coding agents — the full GitHub work lifecycle as a CLI"
  homepage "https://cckit.vercel.app"
  url "https://github.com/jeiemgi/cckit/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "6a3d97cbf4c68c0e87d5edf73032ec3d1181c2b60fd5caa8695d42280e464d93"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/jeiemgi/cckit.git", branch: "main"

  depends_on "git"
  depends_on "jq" => :recommended

  def install
    # Ship the bash bundle + plugin assets under libexec; expose only the dispatcher on PATH.
    libexec.install Dir["*"]
    (bin/"cckit").write_env_script libexec/"bin/cckit", {}
    chmod 0755, libexec/"bin/cckit"
  end

  test do
    assert_match "cckit", shell_output("#{bin}/cckit version")
  end
end
