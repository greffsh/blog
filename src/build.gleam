import lustre/element
import pages/home
import simplifile

pub fn main() {
  let assert Ok(_) = simplifile.create_directory_all("./dist")
  let assert Ok(_) = simplifile.copy_directory("./public", "./dist")

  let assert Ok(_) =
    home.page()
    |> element.to_document_string
    |> simplifile.write("./dist/index.html", _)

  Nil
}
