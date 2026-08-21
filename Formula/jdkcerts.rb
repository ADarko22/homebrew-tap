class Jdkcerts < Formula
  desc "Tool to manage JDK certificates"
  homepage "https://github.com/ADarko22/JDKCertsTool"
  url "https://github.com/ADarko22/JDKCertsTool/releases/download/v2.1.1/JDKCertsTool-v2.1.1.jar"
  sha256 "2fe40aed335d7d656b909ff7bb334ec49b693bfb9f846440f2ba5aec2a381b63"
  license "MIT"

  depends_on "openjdk@21"

  def pour_bottle?
    false
  end

  def install
    # 1. Move the jar to libexec: https://github.com/yugabyte/linuxbrew/blob/master/Library/Homebrew/formula.rb#L428
    libexec.install cached_download => "jdkcertstool.jar"

    # 2. Create the script.
      bin.write_jar_script(
        libexec/"jdkcertstool.jar",
        "jdkcerts",
        java_version: "21"
      )
  end

  test do
    assert_match "JDK Management Tool", shell_output("#{bin}/jdkcerts info")
  end
end