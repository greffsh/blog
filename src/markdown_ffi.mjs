import { marked } from "marked";
import { markedHighlight } from "marked-highlight";
import hljs from "highlight.js";
import gleamLang from "highlightjs-gleam";
import matter from "gray-matter";
import fs from "fs";
import { toList } from "../prelude.mjs";

hljs.registerLanguage("gleam", gleamLang);

function slugify(text) {
  return text.toLowerCase().replace(/[^\w\s-]/g, "").replace(/\s+/g, "-").trim();
}

const renderer = new marked.Renderer();
renderer.heading = ({ text, depth }) => {
  const slug = slugify(text);
  return `<h${depth} id="${slug}">${text}</h${depth}>\n`;
};

marked.use(markedHighlight({
  highlight(code, lang) {
    const language = hljs.getLanguage(lang) ? lang : "plaintext";
    return hljs.highlight(code, { language }).value;
  }
}));

marked.use({ renderer });

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

export function word_count(md) {
  const content = matter(md).content;
  return content.trim().split(/\s+/).length;
}

export function get_toc_html(md) {
  const content = matter(md).content;
  const headings = [];

  for (const line of content.split("\n")) {
    const match = line.match(/^(#{1,3})\s+(.+)$/);
    if (match) {
      const depth = match[1].length;
      const text = match[2].trim();
      const slug = slugify(text);
      headings.push({ depth, text, slug });
    }
  }

  if (headings.length === 0) return "";

  const items = headings.map(h => {
    const indent = (h.depth - 1) * 0.75;
    const cls = h.depth === 1 ? "toc-h1" : h.depth === 2 ? "toc-h2" : "toc-h3";
    return `<li style="padding-left:${indent}rem"><a href="#${h.slug}" class="toc-link ${cls}">${h.text}</a></li>`;
  }).join("");

  return `<nav class="toc-nav"><h2 class="toc-title">Sections</h2><ul class="toc-list">${items}</ul></nav>`;
}

export function read_file(path) {
  return fs.readFileSync(path, "utf-8");
}

export function read_dir(path) {
  return toList(fs.readdirSync(path));
}
