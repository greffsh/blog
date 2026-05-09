import gleam/list
import gleam/string
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

type Link {
  Link(href: String, label: String, is_external: Bool)
}

const nav_links = [
  Link(href: "/", label: "~/about", is_external: False),
  Link(href: "/blog", label: "~/blog", is_external: False),
  Link(
    href: "https://www.goodreads.com/user/show/149662263-vitor-greff",
    label: "~/books",
    is_external: True,
  ),
  Link(
    href: "https://github.com/VitorGreff",
    label: "~/code",
    is_external: True,
  ),
  Link(href: "/resume.pdf", label: "~/resume", is_external: True),
]

pub fn header(current_path: String) -> Element(a) {
  html.header([attribute.class("site-header")], [
    html.nav([attribute.attribute("aria-label", "Main navigation")], [
      html.ul(
        [attribute.class("nav-links")],
        list.map(nav_links, fn(link) { render_link(link, current_path) }),
      ),
    ]),
  ])
}

fn render_link(link: Link, current_path: String) -> Element(a) {
  let is_active =
    link.href == current_path
    || string.starts_with(current_path, link.href)
    && link.href != "/"

  let link_class = case is_active {
    True -> "nav-link active"
    False -> "nav-link"
  }

  let attrs = case link.is_external {
    True -> [
      attribute.href(link.href),
      attribute.target("_blank"),
      attribute.rel("noopener noreferrer"),
      attribute.class(link_class),
    ]
    False -> [attribute.href(link.href), attribute.class(link_class)]
  }

  html.li([], [html.a(attrs, [element.text(link.label)])])
}
