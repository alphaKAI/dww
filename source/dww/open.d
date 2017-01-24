module dww.open;
import std.process;

void openURLinBrowser(string url) {
  version (OSX) {
    executeShell("open " ~ url);
  } else version(linux) {
    executeShell("xdg-open " ~ url);
  } else {
    throw new Exception("Your OS is not supported.");
  }
}
