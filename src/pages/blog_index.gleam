import components/header
import gleam/int
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import markdown.{type Post}

const posts_per_page = 12

pub fn page(posts: List(Post)) -> Element(a) {
  html.html([attribute.attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute.charset("UTF-8")]),
      html.meta([
        attribute.attribute("name", "viewport"),
        attribute.attribute("content", "width=device-width, initial-scale=1.0"),
      ]),
      html.title([], "blog"),
      html.link([
        attribute.rel("icon"),
        attribute.attribute("type", "image/png"),
        attribute.attribute("href", "/blue.png"),
      ]),
      html.link([
        attribute.rel("stylesheet"),
        attribute.attribute("href", "/global.css"),
      ]),
    ]),
    html.body([], [
      header.header("/blog"),
      html.main([attribute.class("main-content")], [
        html.div([attribute.class("blog-index")], [
          html.h1([attribute.class("blog-index-title")], [
            element.text("Posts"),
          ]),
          html.section(
            [attribute.class("post-list")],
            list.index_map(posts, render_post_item),
          ),
          case list.length(posts) > posts_per_page {
            True ->
              html.button(
                [
                  attribute.id("load-more"),
                  attribute.class("load-more-btn"),
                  attribute.data("per-page", int.to_string(posts_per_page)),
                ],
                [element.text("Show more")],
              )
            False -> element.none()
          },
        ]),
      ]),
      html.script(
        [
          attribute.attribute("src", "/blog.js"),
          attribute.attribute("defer", ""),
        ],
        "",
      ),
    ]),
  ])
}

fn render_post_item(post: Post, index: Int) -> Element(a) {
  let hidden = case index >= posts_per_page {
    True -> "post-item hidden"
    False -> "post-item"
  }
  html.div([attribute.class(hidden)], [
    html.a(
      [
        attribute.href("/blog/" <> post.slug <> "/"),
        attribute.class("post-link"),
      ],
      [
        html.h2([attribute.class("post-title")], [element.text(post.title)]),
        html.p([attribute.class("post-date")], [element.text(post.pub_date)]),
      ],
    ),
  ])
}
