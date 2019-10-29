class Nsqd < Formula
  desc "Message queueing daemon for NSQ"
  homepage "https://nsq.io"
  url "https://movableink-developer-binaries.s3-us-west-2.amazonaws.com/nsq_0.3.8_darwin.zip"
  sha256 "92067e42af27b8a15e5f037e2cb9014858ec369140ce76b5aedd563bf1c2ccf8"

  def install
    bin.install "#{buildpath}/bin/nsqd"

    mkdir "#{var}/nsq"
  end

  plist_options :startup => true

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <true/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{bin}/nsqd</string>
          <string>-data-path=#{var}/nsq</string>
          <string>-broadcast-address=localhost</string>
          <string>-lookupd-tcp-address=127.0.0.1:4160</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{var}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/nsqd.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/nsqd.log</string>
      </dict>
    </plist>
  EOS
  end

  test do
    system "true"
  end
end