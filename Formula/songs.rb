class Songs < Formula
  desc "Synchronize music playlists"
  homepage "https://github.com/durczokj/songs"
  url "https://github.com/durczokj/songs/releases/download/v0.2.0/songs.jar"
  sha256 "0f0147f23f500dad76c9618190eeececcaee9cd1bf754cff9fc8ef3cbaba624c"
  version "0.2.0"

  depends_on "openjdk@21"

  # ffmpeg, yt-dlp and node are runtime prerequisites rather than formula
  # dependencies: declaring them forces a full source rebuild on Intel macOS,
  # where Homebrew no longer ships bottles. `songs doctor` reports them.

  def install
    libexec.install "songs.jar"
    bin.write_jar_script libexec/"songs.jar", "songs", java_version: "21"
  end

  def caveats
    <<~EOS
      songs needs these tools on your PATH:
        brew install ffmpeg yt-dlp node

      Then install the browser used for Apple Music extraction:
        songs setup-browser

      Verify everything with:
        songs doctor
    EOS
  end

  test do
    assert_match "Synchronize music playlists", shell_output("#{bin}/songs --help")
  end
end
