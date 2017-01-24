module app;
import vibe.d;
import std.random,
       std.stdio,
       std.conv,
       std.file;
import dww.open;

void main() {
  string address = "127.0.0.1";
  ushort port    = uniform(ushort.min, ushort.max);
  string root    = getcwd;

  readOption("binding|b", &address, "Bind www to the specified IP.");
  readOption("port|p",    &port,    "TCP port number");
  readOption("root|r",    &root,    "Root directory");

  if (!finalizeCommandLineOptions()) return;

  auto settings = new HTTPServerSettings;
  settings.port = port;
  settings.bindAddresses = [address];

  auto router = new URLRouter;
  router.get("*", serveStaticFiles(root));

  listenHTTP(settings, router);
  string url = "http://" ~ address ~ ":" ~ port.to!string;
  openURLinBrowser(url);

  runEventLoop;
}
