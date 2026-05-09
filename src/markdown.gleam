import gleam/list
import gleam/string

pub type Post {
  Post(
    slug: String,
    title: String,
    description: String,
    pub_date: String,
    html: String,
    reading_time: Int,
    toc_html: String,
  )
}

@external(javascript, "./markdown_ffi.mjs", "read_file")
fn do_read_file(path: String) -> String

@external(javascript, "./markdown_ffi.mjs", "read_dir")
fn do_read_dir(path: String) -> List(String)

@external(javascript, "./markdown_ffi.mjs", "parse_markdown")
fn do_parse_markdown(md: String) -> String

@external(javascript, "./markdown_ffi.mjs", "get_title")
fn do_get_title(md: String) -> String

@external(javascript, "./markdown_ffi.mjs", "get_description")
fn do_get_description(md: String) -> String

@external(javascript, "./markdown_ffi.mjs", "get_pub_date")
fn do_get_pub_date(md: String) -> String

@external(javascript, "./markdown_ffi.mjs", "get_content")
fn do_get_content(md: String) -> String

@external(javascript, "./markdown_ffi.mjs", "word_count")
fn do_word_count(md: String) -> Int

@external(javascript, "./markdown_ffi.mjs", "get_toc_html")
fn do_get_toc_html(md: String) -> String

pub fn load_posts(posts_dir: String) -> List(Post) {
  posts_dir
  |> do_read_dir
  |> list.filter(fn(f) { string.ends_with(f, ".md") })
  |> list.map(fn(filename) {
    let slug = string.drop_end(filename, 3)
    let raw = do_read_file(posts_dir <> "/" <> filename)
    parse_post(slug, raw)
  })
  |> list.sort(fn(a, b) { string.compare(b.pub_date, a.pub_date) })
}

fn parse_post(slug: String, raw: String) -> Post {
  let content = do_get_content(raw)
  let words = do_word_count(raw)
  Post(
    slug: slug,
    title: do_get_title(raw),
    description: do_get_description(raw),
    pub_date: do_get_pub_date(raw),
    html: do_parse_markdown(content),
    reading_time: words / 200 + 1,
    toc_html: do_get_toc_html(raw),
  )
}
