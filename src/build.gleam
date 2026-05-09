import lustre/element
import markdown
import pages/blog_index
import pages/home
import simplifile

const posts_dir = "./src/posts"

pub fn main() {
  let assert Ok(_) = simplifile.create_directory_all("./dist")
  let assert Ok(_) = simplifile.copy_directory("./public", "./dist")

  let posts = markdown.load_posts(posts_dir)

  let assert Ok(_) =
    home.page()
    |> element.to_document_string
    |> simplifile.write("./dist/index.html", _)

  let assert Ok(_) = simplifile.create_directory_all("./dist/blog")

  let assert Ok(_) =
    blog_index.page(posts)
    |> element.to_document_string
    |> simplifile.write("./dist/blog/index.html", _)

  Nil
}
