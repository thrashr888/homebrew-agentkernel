# Homebrew formula for agentkernel
# Install: brew tap thrashr888/agentkernel && brew install agentkernel
# Update SHA256 values when releasing a new version.

class Agentkernel < Formula
  desc "Run AI coding agents in secure, isolated microVMs"
  homepage "https://thrashr888.github.io/agentkernel/"
  version "0.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-arm64.tar.gz"
      sha256 "02f0eff979ec46e8f050802119c1ba71c33b1672b5b17b4122e88e95b0412379"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-x64.tar.gz"
      sha256 "c48de496b8f57e3784ebccf3145219c9aaee21cea2dd39a7c96e98592d6cb8bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-arm64.tar.gz"
      sha256 "f763cd127fef8797a3e6bf71c337e949ac82e03c02e2421a0bc33eb4f7187f87"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-x64.tar.gz"
      sha256 "083a9695bf88c974a9d2273e0066b0c2ad6f75591497e2e1876fcc01643dc27e"
    end
  end

  def install
    bin.install "agentkernel"
  end

  service do
    run [opt_bin/"agentkernel", "serve", "--host", "127.0.0.1", "--port", "18888"]
    keep_alive true
    log_path var/"log/agentkernel.log"
    error_log_path var/"log/agentkernel.error.log"
    working_dir HOMEBREW_PREFIX
  end

  def caveats
    <<~EOS
      The service listens on localhost:18888.

      Requires Docker, Podman, or Firecracker (Linux with KVM).
      Run `agentkernel doctor` to check your setup.
    EOS
  end

  test do
    assert_match "agentkernel", shell_output("#{bin}/agentkernel --version")
  end
end
