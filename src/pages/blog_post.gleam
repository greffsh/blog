import components/header
import gleam/int
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import markdown.{type Post}

pub fn page(post: Post) -> Element(a) {
  html.html([attribute.attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute.charset("UTF-8")]),
      html.meta([
        attribute.attribute("name", "viewport"),
        attribute.attribute("content", "width=device-width, initial-scale=1.0"),
      ]),
      html.title([], post.title),
      html.link([
        attribute.rel("icon"),
        attribute.attribute("type", "image/png"),
        attribute.attribute("href", "/blue.png"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.attribute("href", "/global.css"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.attribute("href", "/highlight.css"),
      ]),
    ]),
    html.body([], [
      header.header("/blog"),
      case post.toc_html {
        "" -> element.none()
        toc -> element.unsafe_raw_html("div", "div", [], toc)
      },
      html.main([attribute.class("main-content")], [
        html.div([attribute.class("post-wrapper")], [
          html.div([attribute.class("post-meta-bar")], [
            element.element(
              "svg",
              [
                attribute.attribute("xmlns", "http://www.w3.org/2000/svg"),
                attribute.attribute("width", "20"),
                attribute.attribute("height", "20"),
                attribute.attribute("viewBox", "0 0 24 24"),
                attribute.attribute("fill", "none"),
                attribute.attribute("stroke", "currentColor"),
                attribute.attribute("stroke-width", "2"),
                attribute.attribute("stroke-linecap", "round"),
                attribute.attribute("stroke-linejoin", "round"),
                attribute.class("back-arrow"),
                attribute.attribute("onclick", "window.location.href='/blog'"),
              ],
              [
                element.element(
                  "path",
                  [attribute.attribute("d", "m12 19-7-7 7-7")],
                  [],
                ),
                element.element(
                  "path",
                  [attribute.attribute("d", "M19 12H5")],
                  [],
                ),
              ],
            ),
            html.p([attribute.class("reading-time")], [
              element.text(
                "~" <> int.to_string(post.reading_time) <> " min read",
              ),
            ]),
          ]),
          html.article([attribute.class("prose")], [
            element.unsafe_raw_html("div", "div", [], post.html),
          ]),
          html.p([attribute.class("post-pub-date")], [
            element.text(post.pub_date),
          ]),
        ]),
      ]),
      html.script(
        [
          attribute.attribute("src", "/post.js"),
          attribute.attribute("defer", ""),
        ],
        "",
      ),
    ]),
  ])
}
