import { marked } from "marked";
import matter from "gray-matter";
import fs from "fs";
import { toList } from "../prelude.mjs";

export function parse_markdown(md) {
  return marked.parse(md);
}

export function get_title(md) {
  return matter(md).data.title ?? "";
}

export function get_description(md) {
  return matter(md).data.description ?? "";
}

export function get_pub_date(md) {
  return matter(md).data.pubDate ?? "";
}

export function get_content(md) {
  return matter(md).content;
}

export function read_file(path) {
  return fs.readFileSync(path, "utf-8");
}

export function read_dir(path) {
  return toList(fs.readdirSync(path));
}
