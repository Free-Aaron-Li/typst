// 缩进
#let indent = h(2em)

// 注意
#let NOTE(doc)={
  rect(fill: luma(225), stroke: (left: 0.25em), width: 100%)[
    #text(size: 18pt, weight: "bold", fill: rgb("259AE8"))[
      #image("../asset/basic/emoji/notepad.png", width: 5%)
    ]
    #doc
  ]
  indent
}

#let TIP(doc)={
  rect(fill: luma(225), stroke: (left: 0.25em), width: 100%)[
    #text(
      size: 18pt,
      weight: "bold",
      fill: rgb("#75664d"),
    )[#image("../asset/basic/emoji/lamp.png", width: 5%)]
    #text(weight: "regular")[
      #doc
    ]
  ]
  indent
}

#let THEOREM(title: none, des: none)={
  rect(fill: luma(225), radius: 5pt, width: 100%)[
    #text(size: 18pt, weight: "bold")[#title]

    #text(weight: "regular")[
      #des
    ]
  ]
  indent
}

// 要点
#let POINT(doc)={
  text(13pt)[*#doc*]
}

#let skew(angle, vscale: 1, body) = {
  let (a, b, c, d) = (1, vscale * calc.tan(angle), 0, vscale)
  let E = (a + d) / 2
  let F = (a - d) / 2
  let G = (b + c) / 2
  let H = (c - b) / 2
  let Q = calc.sqrt(E * E + H * H)
  let R = calc.sqrt(F * F + G * G)
  let sx = Q + R
  let sy = Q - R
  let a1 = calc.atan2(F, G)
  let a2 = calc.atan2(E, H)
  let theta = (a2 - a1) / 2
  let phi = (a2 + a1) / 2

  set rotate(origin: bottom + center)
  set scale(origin: bottom + center)

  rotate(phi, scale(x: sx * 100%, y: sy * 100%, rotate(theta, body)))
}

// 中文伪斜体
#let cn_fake-italic(body) = skew(-12deg, body)

// 中文添加阴影效果
#let shadowed(body) = box(
  place(skew(-50deg, vscale: 0.8, text(fill: luma(200), body))) + place(body),
)

// 例题
#let examples_num = counter("none")
#let example(title: none, solutions: none)={
  pad(x: 0em)[
    #set enum(numbering: "(a)")
    #examples_num.step()
    *例 #examples_num.display():*
    #title \
    *解：*
    #solutions
    \
  ]
}
// 例题——文档版本
#let example_dc(title: none, solutions: none)={
  pad(x: 2em)[
    #examples_num.step()
    *例 #examples_num.display():*
    #title 

    #pad(x:0em)[*解：* #solutions]
  ]
  indent
}

// 下划线
#let line_cs = {
  box(width: 1fr, line(length: 100%))
  pad(left: 0em)[]
  indent
}
#let line_end = {
  box()[
    #box(width: 1fr, line_cs)
    #text(size:15pt)[*END*]
    #box(width: 1fr, line_cs)
  ]
  indent
}
#let line_dc = {
  align(center)[
    #line(length: 80%)
  ]
  indent
}

// 概念复习
#let Concept_review(doc)={
  rect(width: 100%)[
    #POINT[概念复习] \
    #doc
  ]
}

// 楷体文本
#let regular_script(doc)={
  text(font:("FZKai-Z03S"),size:11pt)[
    #doc
  ]
}
