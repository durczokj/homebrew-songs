class Songs < Formula
  desc "Synchronize music playlists"
  homepage "https://github.com/durczokj/songs"
  url "https://github.com/durczokj/songs/releases/download/v0.1.2/songs.jar"
  sha256 "1c61240dbe5b688dbd25a8297edb85b3b06b48b1624e06a1c41d38a7d75cffa1"
  version "0.1.2"

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
