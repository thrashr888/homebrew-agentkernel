# Homebrew formula for agentkernel
# Install: brew tap thrashr888/agentkernel && brew install agentkernel
# Update SHA256 values when releasing a new version.

class Agentkernel < Formula
  desc "Run AI coding agents in secure, isolated microVMs"
  homepage "https://github.com/thrashr888/agentkernel"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-arm64.tar.gz"
      sha256 "1558827510893636edcc788e5379be4fd65aeef9d5a607e508ccd301cf5533f6"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-darwin-x64.tar.gz"
      sha256 "5b83a112ae320baef07734527f104a683eda44b37b8e9b2cd9c00185fb2ce72a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-arm64.tar.gz"
      sha256 "02045555abb4a7e0354ca5b6c7eb79a7b73b760ce99ddabb5cbb4cd4c01d2b0b"
    end
    on_intel do
      url "https://github.com/thrashr888/agentkernel/releases/download/v#{version}/agentkernel-linux-x64.tar.gz"
      sha256 "37dbc836abd284dde88fdcc62ca5848594232aaebd0b90843927ba5ac909dcf0"
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
        brew services start agentkernel

      To restart agentkernel after an upgrade:
        brew services restart agentkernel

      Or, if you don't want/need a background service you can just run:
        #{opt_bin}/agentkernel serve
    EOS
  end

  test do
    assert_match "agentkernel", shell_output("#{bin}/agentkernel --version")
  end
end
