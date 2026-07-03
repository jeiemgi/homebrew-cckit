# Homebrew formula for cckit — published to the jeiemgi/homebrew-cckit tap.
#   brew tap jeiemgi/cckit && brew install cckit
# The stable url/sha256 are bumped per release.
class Cckit < Formula
  desc "Project operating system for coding agents — the full GitHub work lifecycle as a CLI"
  homepage "https://cckit.vercel.app"
  url "https://github.com/jeiemgi/cckit/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "526a52169ad2bf2a54135238040c220da98e40bbfa3fb23098828cde76a306bb"
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
