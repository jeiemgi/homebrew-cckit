# Homebrew formula for cckit.
# Install (HEAD) once this lives in a tap (jeiemgi/homebrew-cckit):
#   brew tap jeiemgi/cckit && brew install --HEAD cckit
# A stable `url`/`sha256` block is added automatically by the release workflow on the first tag.
class Cckit < Formula
  desc "Project operating system for coding agents — the full GitHub work lifecycle as a CLI"
  homepage "https://cckit.dev"
  url "https://github.com/jeiemgi/cckit/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "52a8eea9c3d05dff67b1692905970e8c6622fb7bb734a495f1ea7f0ef8bd1955"
  version "0.11.0"
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
