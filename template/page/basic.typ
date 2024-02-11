#import "@preview/hydra:0.3.0": hydra // 页眉自定义
#import "@preview/mitex:0.2.1": mitex // latex 支持

//---------------------------------
// 基本模板
//---------------------------------
#let basic(
  //---------
  // 参数
  //---------
  title: none, // 标题
  authors: (), // 作者
  abstract: [], // 摘要
  doc, // 正文
  chapter: none, // 章节
) = {
  //---------
  // 初始化
  //---------
  let chapter_num = 0 // 章节码初始化
  if chapter == 0 {
    chapter_num = -1
  } else {
    chapter_num = chapter + (-1)
  }

  //-----------------------------
  //----------- 首页 -------------
  //-----------------------------

  //---------
  // 标题
  //---------
  set heading(
    numbering: (..args)=>numbering("1.1", args.pos().at(0) + chapter_num, ..args.pos().slice(1)),
  )
  show heading: it => {
    if it.level == 1 {
      set align(center)
      text(20pt)[#it]
    } else {
      it;
    }
    text()[#v(0.3em, weak: true)];
    text()[#h(0em)]
  }
  align(center)[#text(30pt)[*#title*]] // 中心标题

  //---------
  // 作者
  //---------
  if authors != none and authors != "" and authors != [] {
    set align(center)
    set par(leading: 0.5em)
    let n_counter = authors.len() // 作者数目
    let n_columns = calc.min(n_counter, 2) // 列数

    box(width: 1fr, line(length: 100%))
    grid(columns: (1fr,) * n_columns, row-gutter: 24pt, ..
    authors.map(author=>[
      #author.name \
      #author.affiliation \
      #link("mailto:" + author.email)
    ]))
    box(width: 1fr, line(length: 100%))
  }

  //---------
  // 摘要
  //---------
  if abstract != none and abstract != "" and abstract != [] {
    align(center)[
      *摘要*\
      #abstract
    ]
  }

  //-----------------------------
  //----------- 主页 -------------
  //-----------------------------

  //----------
  // 页面
  //----------
  set page(
    paper: "a4", // 页面大小
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3.0cm, right: 2.0cm), // 页边距
    header: locate(loc=>{ // 页眉
      let hydra = hydra.with(loc: loc, paper: "a4") // 页眉标题
      if calc.even(loc.page()) {
        align(left, hydra(1))
      } else {
        align(right, hydra(2))
      }
    }),
    footer: [
      #set align(center)
      #set text(8pt)
      #counter(page).display("—— 1 ——")
    ],
  )

  //---------
  // 文本
  //---------
  set text(
    size: 11pt, // 字号
    font: ("Times New Roman Cyr", "Source Han Serif SC"), // 字体族
    lang: "zh", // 语言
    region: "cn", // 区域
    fill: black, // 字体颜色
    cjk-latin-spacing: auto, // CJK和拉丁文间自动插入行距
  )
  show math.equation: set text(font: ("Libertinus Math", "Source Han Serif SC")) // 数学字体

  //---------
  // 缩进
  //---------
  set par(
    justify: true,
    first-line-indent: 2em, // 首行缩进两空格
    leading: 1.5em, // 标题与正文间距2行距
  )

  //---------
  // 行间展示数学公式
  //----------
  show math.equation.where(block: false): it => {
    if it.has("label") and it.label == label("displayed-inline-math-equation") {
      it
    } else {
      [$display(it)$<displayed-inline-math-equation>]
    }
  }

  //---------
  // 杂项
  //---------

  set underline(offset: 2.5pt)// 下划线

  //---------
  // 正文
  //---------
  columns(1, doc)
}
