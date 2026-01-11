class Jdkcerts < Formula
  desc "Tool to manage JDK certificates"
  homepage "https://github.com/ADarko22/JDKCertsTool"
  # These placeholders are filled automatically by the GitHub Action
  url "https://github.com/ADarko22/JDKCertsTool/releases/download/v1.0.0/JDKCertsTool-v1.0.0.jar"
  sha256 "..."
  license "MIT"

  depends_on "openjdk@21"

  def install
    # 1. Move the JAR to libexec (internal library folder)
    # We rename it to a clean name without version strings
    libexec.install Dir["JDKCertsTool-*.jar"].first => "jdkcertstool.jar"

    # 2. Create the executable wrapper
    # This creates a file at /usr/local/bin/jdkcerts (on Intel Mac)
    # or /opt/homebrew/bin/jdkcerts (on Apple Silicon/Linux)
    (bin/"jdkcerts").write_jar_script libexec/"jdkcertstool.jar", "jdkcerts", java_version: "21"
  end

  test do
    # This ensures 'jdkcerts --help' exits with 0
    system "#{bin}/jdkcerts", "--help"
  end
end