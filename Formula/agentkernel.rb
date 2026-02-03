# Homebrew formula for agentkernel
# Install: brew tap thrashr888/agentkernel && brew install agentkernel
# Update SHA256 values when releasing a new version.

class Agentkernel < Formula
  desc "Run AI coding agents in secure, isolated microVMs"
  homepage "https://thrashr888.github.io/agentkernel/"
  version "0.8.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-arm64.tar.gz"
      sha256 "b9737cdfe023635cfd3de14f153004857cca330c70a0beba159317efa35d87e9"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-x64.tar.gz"
      sha256 "c80c44df5217bb4e61f810ff0343344630fd72f2601d7dbfc6285a9c42cbe0f3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-arm64.tar.gz"
      sha256 "85a0e55331f2509d917fb7b80fbfde915a4a585372e98ee108fe68752d0abf28"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-x64.tar.gz"
      sha256 "a442cd18acea77bcfffe6c32182ac69408ae63506e171f1fb42612599c69d7ec"
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
