class Jdkcerts < Formula
  desc "Tool to manage JDK certificates"
  homepage "https://github.com/ADarko22/JDKCertsTool"
  url "https://github.com/ADarko22/JDKCertsTool/releases/download/v2.0.0/JDKCertsTool-v2.0.0.jar"
  sha256 "6c2b4f22b1ac1c4c76785d255daafc160c8d0cbc63368dad927952beeec48241"
  license "MIT"

  depends_on "openjdk@21"

  def pour_bottle?
    false
  end

  def install
    # 1. Move the jar to libexec
    libexec.install "JDKCertsTool-v2.0.0.jar" => "jdkcertstool.jar"

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