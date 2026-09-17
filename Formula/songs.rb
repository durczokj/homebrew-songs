class Songs < Formula
  desc "Synchronize music playlists"
  homepage "https://github.com/durczokj/songs"
  url "https://github.com/durczokj/songs/releases/download/v0.1.5/songs.jar"
  sha256 "c2541bc2b63b1684cdd4ecb1f149e96042d5433edce8bfd90f8e4679ed870bfd"
  version "0.1.5"

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
