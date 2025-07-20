#import "@preview/polylux:0.4.0": *
#import "@preview/friendly-polylux:0.1.0" as friendly
#import friendly: titled-block

#show: friendly.setup.with(
  short-title: [MindMap Idea Sources],
  short-speaker: [Zhihao Li],
)

#set text(size: 30pt, font: "Andika")
#show raw: set text(font: "Fantasque Sans Mono")
#show math.equation: set text(font: "Times New Roman")
#show figure.caption: set text(size: 20pt)
#show link: set text(fill: rgb("#6d94cb"))

#friendly.title-slide(
  title: [MindMap Templates],
  date: [April 21, 2025],
  speaker: [Zhihao Li],
  speaker-website: none, // use `none` to disable
  slides-url: "https://lzhms.github.io/", // use `none` to disable
  qr-caption: text(font: "Excalifont")[About me],
  logo: image("images/idea.jpg"),
)

#slide[
  = Colors
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    [
      #figure(
        image("images/colors/color_1.png", width: 100%),
        caption: [Color Example]
      )
    ],
    [
      *Using Morandi Colors*

      #titled-block(title: [A Coloring Tutorial])[#link("https://liuzhaoze.github.io/posts/论文绘图配色/")[paper drawing coloring]]
    ]
  )
]

#slide[
  = Shapes
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 1em,
    [
    ],
    [
    ]
  )
]

#slide[
  = Frameworks
  == Block Diagram
  #figure(
    image("images/frameworks/img1.png", width: 65%)
  )
  == Timeline—Research Survey
  #figure(
    image("images/frameworks/img2.png", width: 100%)
  )
  == Mind Map—Research Survey
  #figure(
    image("images/frameworks/img3.png", width: 70%)
  )
  == Style Diagram
  #figure(
    image("images/frameworks/img4.png", width: 80%)
  )
]

#slide[
  = Materials
  == Artistic Text
  *Appealing*: Using this styled text as the title of github repo. 
  #figure(
    image("images/materials/img1.png", width: 60%)
  )
]

#friendly.last-slide(
  title: [That's it!],
  project-url: "https://github.com/ResearchChips/MindMap",
  qr-caption: text(font: "Excalifont")[My project on GitHub],
  contact-appeal: [Get in touch #emoji.hand.wave],
  // leave out any of the following if they don't apply to you:
  email: "zhihaoli2003@outlook.com",
  website: "https://lzhms.github.io/"
)
