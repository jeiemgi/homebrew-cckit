# Homebrew formula for cckit.
# Install (HEAD) once this lives in a tap (jeiemgi/homebrew-cckit):
#   brew tap jeiemgi/cckit && brew install --HEAD cckit
# A stable `url`/`sha256` block is added automatically by the release workflow on the first tag.
class Cckit < Formula
  desc "Project operating system for coding agents — the full GitHub work lifecycle as a CLI"
  homepage "https://cckit.vercel.app"
  url "https://github.com/jeiemgi/cckit/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "71a23ae6d905f4d23170e8dcbad17630948fb53e7c5e7a4339c4ec4d2abf8466"
  version "0.4.1"
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
