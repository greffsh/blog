# lustre_blog

[![Package Version](https://img.shields.io/hexpm/v/lustre_blog)](https://hex.pm/packages/lustre_blog)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/lustre_blog/)

```sh
gleam add lustre_blog@1
```
```gleam
import lustre_blog

pub fn main() -> Nil {
  // TODO: An example of the project in use
}
```

Further documentation can be found at <https://hexdocs.pm/lustre_blog>.

## Development

The site is statically generated into `dist/`. Build it with:

```sh
gleam run --target javascript -m build
```

To rebuild automatically when files in `src/`, `content/`, or `public/` change, install `inotify-tools` (provides `inotifywait`) and run the watcher:

```sh
sh watch.sh
```

For example, install the dependency on Fedora with `sudo dnf install inotify-tools`, or on Debian/Ubuntu with `sudo apt install inotify-tools`.

In another terminal, serve the generated site locally:

```sh
python3 -m http.server 8000 --bind 127.0.0.1 --directory dist
```

Open <http://127.0.0.1:8000> and refresh the browser after a rebuild. Run tests with:

```sh
gleam test
```
