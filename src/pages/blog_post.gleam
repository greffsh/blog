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
      post_scripts(),
    ]),
  ])
}

fn post_scripts() -> Element(a) {
  element.unsafe_raw_html(
    "script",
    "script",
    [],
    "
    document.addEventListener('DOMContentLoaded', () => {
      // Copy buttons for code blocks
      document.querySelectorAll('.prose pre').forEach(pre => {
        const wrapper = document.createElement('div');
        wrapper.style.position = 'relative';
        pre.parentNode.insertBefore(wrapper, pre);
        wrapper.appendChild(pre);

        const btn = document.createElement('button');
        btn.className = 'copy-button';
        btn.setAttribute('aria-label', 'Copy code');
        btn.innerHTML = '<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"><rect width=\"14\" height=\"14\" x=\"8\" y=\"8\" rx=\"2\" ry=\"2\"/><path d=\"M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2\"/></svg>';
        btn.addEventListener('click', async () => {
          await navigator.clipboard.writeText(pre.textContent || '');
          btn.innerHTML = '<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"><polyline points=\"20 6 9 17 4 12\"/></svg>';
          setTimeout(() => {
            btn.innerHTML = '<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\"><rect width=\"14\" height=\"14\" x=\"8\" y=\"8\" rx=\"2\" ry=\"2\"/><path d=\"M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2\"/></svg>';
          }, 2000);
        });
        wrapper.appendChild(btn);
      });

      // External links open in new tab
      document.querySelectorAll('.prose a').forEach(link => {
        const href = link.getAttribute('href');
        if (href && !href.startsWith('#')) {
          link.setAttribute('target', '_blank');
          link.setAttribute('rel', 'noopener noreferrer');
        }
      });

      // TOC active state on hash change
      const updateToc = () => {
        document.querySelectorAll('.toc-link').forEach(l => l.classList.remove('toc-active'));
        const hash = window.location.hash;
        if (hash) {
          const active = document.querySelector('.toc-link[href=\"' + hash + '\"]');
          if (active) active.classList.add('toc-active');
        }
      };
      updateToc();
      window.addEventListener('hashchange', updateToc);
    });
  ",
  )
}
