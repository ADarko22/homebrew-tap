class Jdkcerts < Formula
  desc "Tool to manage JDK certificates"
  homepage "https://github.com/ADarko22/JDKCertsTool"
  # These placeholders are filled automatically by the GitHub Action
  url "https://github.com/ADarko22/JDKCertsTool/releases/download/v2.0.0/JDKCertsTool-v2.0.0.jar"
  sha256 "6c2b4f22b1ac1c4c76785d255daafc160c8d0cbc63368dad927952beeec48241"
  license "MIT"

  depends_on "openjdk@21"

  # It tells Homebrew to always skip the bottle search and install from the URL.
  def pour_bottle?
    false
  end

  def install
    # 1. Move the JAR to libexec (internal library folder) and renames it to a clean name
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