import components/header
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn page() -> Element(a) {
  html.html([attribute.attribute("lang", "en")], [
    html.head([], [
      html.meta([attribute.charset("UTF-8")]),
      html.meta([
        attribute.attribute("name", "viewport"),
        attribute.attribute("content", "width=device-width, initial-scale=1.0"),
      ]),
      html.title([], "greff.sh"),
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
      header.header("/"),
      html.main([attribute.class("main-content home-main")], [
        html.div([attribute.class("home-wrapper")], [
          html.div([attribute.class("content-wrapper")], [
            html.section([attribute.class("about-section")], [
              html.h1([], [element.text("About me")]),
              html.div([attribute.class("section-body")], [
                html.p([], [
                  element.text(
                    "Hi there! I'm Greff, a good-natured 24-year-old Brazilian software engineer and computer science enthusiast who's curious about a wide variety of topics, including:",
                  ),
                ]),
                html.ul(
                  [attribute.class("topic-list")],
                  list_items([
                    "Functional Programming",
                    "Software Architecture",
                    "Distributed Systems",
                    "Math",
                    "Networks",
                  ]),
                ),
              ]),
            ]),
            html.section([attribute.class("stack-section")], [
              html.h1([], [element.text("Main Stack")]),
              html.div([attribute.class("section-body")], [
                html.p([], [
                  element.text(
                    "These days, I'm working as a software engineer, building web products and AI tools for internal teams and clients. I'm pretty tooling-agnostic, but my day-to-day stack is mostly:",
                  ),
                ]),
                html.ul(
                  [attribute.class("topic-list")],
                  list_items([
                    "TypeScript",
                    "React",
                    "NestJS",
                    "PostgreSQL",
                    "LangChain",
                    "AWS",
                  ]),
                ),
                html.br([]),
                html.p([], [
                  element.text(
                    "Outside work, I also like exploring languages and ideas beyond my day-to-day stack, especially Gleam, Rust, and proof assistants like Lean.",
                  ),
                ]),
              ]),
            ]),
          ]),
          html.img([
            attribute.class("kakashi-divider"),
            attribute.src("/kakashi.jpg"),
            attribute.alt("kakashi"),
            attribute.loading("eager"),
            attribute.width(500),
            attribute.height(580),
          ]),
        ]),
      ]),
    ]),
  ])
}

fn list_items(items: List(String)) -> List(Element(a)) {
  list.map(items, fn(item) { html.li([], [element.text(item)]) })
}
