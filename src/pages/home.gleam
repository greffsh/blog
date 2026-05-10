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
      html.main([attribute.class("main-content")], [
        html.div([attribute.class("content-wrapper")], [
          html.section([attribute.class("about-section")], [
            html.h1([], [element.text("About me")]),
            html.div([attribute.class("section-body")], [
              html.p([], [
                element.text(
                  "Hi there! Im greff, your good natured engineer. Im a 23 brazilian
          software engineer and computer science enthusiast that has been deeply
          invested in learning stuff from a wide variaty of topics, such as:",
                ),
              ]),
              html.ul(
                [attribute.class("topic-list")],
                list_items([
                  "Functional Programming",
                  "Software Architecture",
                  "Web Frameworks",
                  "Distributed Systems",
                ]),
              ),
            ]),
          ]),
          html.section([attribute.class("stack-section")], [
            html.h1([], [element.text("Main Stack")]),
            html.div([attribute.class("section-body")], [
              html.p([], [
                element.text(
                  "Currently, Im working as a fullstack engineer, developing web products
          and AI agents. My main stack at work is:",
                ),
              ]),
              html.ul(
                [attribute.class("topic-list")],
                list_items([
                  "Typescript",
                  "React",
                  "Nest",
                  "MongoDB",
                  "Langchain",
                  "Langgraph",
                ]),
              ),
            ]),
          ]),
        ]),
      ]),
    ]),
  ])
}

fn list_items(items: List(String)) -> List(Element(a)) {
  list.map(items, fn(item) { html.li([], [element.text(item)]) })
}
