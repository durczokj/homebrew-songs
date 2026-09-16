class Songs < Formula
  desc "Synchronize music playlists"
  homepage "https://github.com/durczokj/songs"
  url "https://github.com/durczokj/songs/releases/download/v0.1.0/songs.jar"
  sha256 "2b73d37d1135867c70dac93374e20928fd4a0df85bdf15b36353912e78a0b2af"
  version "0.1.0"

  depends_on "openjdk@21"
  depends_on "ffmpeg"
  depends_on "yt-dlp"
  depends_on "node"

  def install
    libexec.install "songs.jar"
    bin.write_jar_script libexec/"songs.jar", "songs", java_version: "21"
  end

  def post_install
    system bin/"songs", "setup-browser"
  end

  test do
    assert_match "Synchronize music playlists", shell_output("#{bin}/songs --help")
  end
end
