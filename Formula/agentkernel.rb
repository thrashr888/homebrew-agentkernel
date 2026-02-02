# Homebrew formula for agentkernel
# Install: brew tap thrashr888/agentkernel && brew install agentkernel
# Update SHA256 values when releasing a new version.

class Agentkernel < Formula
  desc "Run AI coding agents in secure, isolated microVMs"
  homepage "https://thrashr888.github.io/agentkernel/"
  version "0.7.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-arm64.tar.gz"
      sha256 "e5ede47d16013e9e8f1f44d7cbf6934dcabac8df64970b14c0c2821806906d2a"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-x64.tar.gz"
      sha256 "d02fe84e90c6725a88f6b389f47cbbe016fe37f60d1e35d598f9d95148d28844"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-arm64.tar.gz"
      sha256 "a712b2ff398a09cc1fbc68dc8a85b913a33d0cabf95bcadb03c9ab3abf3a806c"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-x64.tar.gz"
      sha256 "f5143eb6653a81b5b41be3d6888a0d7cb90dce39a99d1010a15dabd1e93a7281"
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
      To start agentkernel as a background service (listens on localhost:18888):
        brew services start thrashr888/agentkernel/agentkernel

      To restart agentkernel after an upgrade:
        brew services restart thrashr888/agentkernel/agentkernel

      Or, if you don't want/need a background service you can just run:
        #{opt_bin}/agentkernel serve

      The sandbox backend is auto-detected:
        - macOS 26+: Apple Containers (VM isolation)
        - macOS:     Docker or Podman (container isolation)
        - Linux:     Firecracker microVMs if KVM available, otherwise Docker/Podman
    EOS
  end

  test do
    assert_match "agentkernel", shell_output("#{bin}/agentkernel --version")
  end
end
