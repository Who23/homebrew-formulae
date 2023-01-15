class Nchook < Formula
  include Language::Python::Virtualenv

  desc "A hook for macos's notification center"
  homepage "https://github.com/who23/nchook"
  url "https://github.com/Who23/nchook/releases/download/0.1.1/nchook-v0.1.1.tar.gz"
  sha256 "0a1e95d2ec29a8ae8840bd1965711e91fc18d91de677a85052494bdda668e563"
  head "https://github.com/who23/nchook.git"

  depends_on "python@3.9"
  depends_on :macos => :big_sur

  resource "watchdog" do
    url "https://files.pythonhosted.org/packages/17/8c/fe6b8554e6a107437375ea6f76c62fbb0deb22288c2eb846c2f92b0d843e/watchdog-2.0.2.tar.gz"
    sha256 "532fedd993e75554671faa36cd04c580ced3fae084254a779afbbd8aaf00566b"
  end

  resource "apsw" do
    url "https://files.pythonhosted.org/packages/b5/a1/3de5a2d35fc34939672f4e1bd7d68cca359a31b76926f00d95f434c63aaa/apsw-3.9.2-r1.tar.gz"
    sha256 "dab96fd164dde9e59f7f27228291498217fa0e74048e2c08c7059d7e39589270"
  end

  def caveats; <<~EOF
    Logs in:
      #{var}/log/nchook/
    EOF
  end

  def plist; <<~EOF
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{bin}/nchook</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>KeepAlive</key>
      <true/>
      <key>StandardOutPath</key>
      <string>#{var}/log/nchook/nchook.out.log</string>
      <key>StandardErrorPath</key>
      <string>#{var}/log/nchook/nchook.err.log</string>
    </dict>
    </plist>
    EOF
  end

  def install
    virtualenv_install_with_resources
    (var/"log/nchook").mkpath
  end
end
