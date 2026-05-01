* [![FFmpeg](img/ffmpeg3d_white_20.png)
  FFmpeg](.)
* [About](about.html)
* [News](index.html#news)
* [Download](download.html)
* [Documentation](documentation.html)
* [Community](community.html)
  + [Code of Conduct](community.html#Code-of-Conduct)
  + [Mailing Lists](contact.html#MailingLists)
  + [IRC](contact.html#IRCChannels)
  + [Forums](contact.html#Forums)
  + [Bug Reports](bugreports.html)
  + [Wiki](https://trac.ffmpeg.org)
  + [Conferences](https://trac.ffmpeg.org/wiki/Conferences)
* [Developers](developer.html)
  + [Source Code](download.html#get-sources)+ [Contribute](developer.html#Introduction)
    + [FATE](http://fate.ffmpeg.org)
    + [Code Coverage](http://coverage.ffmpeg.org)
    + [Funding through SPI](spi.html)
* More
  + [Donate](donations.html)
  + [Hire Developers](consulting.html)
  + [Contact](contact.html)
  + [Security](security.html)
  + [Legal](legal.html)

# drawvg - Language Reference

## Table of Contents

* [1 Introduction](#Introduction)
* [2 Syntax](#Syntax)
  + [2.1 Structure](#Structure)
  + [2.2 Comments](#Comments)
  + [2.3 Commands](#Commands)
    - [2.3.1 Single-Letter Aliases](#Single_002dLetter-Aliases)
    - [2.3.2 Implicit Commands](#Implicit-Commands)
  + [2.4 Arguments](#Arguments)
    - [2.4.1 Number Literals](#Number-Literals)
    - [2.4.2 Expressions](#Expressions)
    - [2.4.3 Variable Names](#Variable-Names)
    - [2.4.4 Colors](#Colors-1)
    - [2.4.5 Constants](#Constants)
* [3 Guide](#Guide)
  + [3.1 Paths](#Paths)
    - [3.1.1 Current Point](#Current-Point)
    - [3.1.2 Defining a Shape](#Defining-a-Shape)
    - [3.1.3 Fill](#Fill)
    - [3.1.4 Stroke](#Stroke)
    - [3.1.5 Clip](#Clip)
    - [3.1.6 Preserving Paths](#Preserving-Paths)
  + [3.2 Variables](#Variables)
    - [3.2.1 User Variables](#User-Variables-1)
  + [3.3 Patterns](#Patterns)
    - [3.3.1 Gradients](#Gradients)
    - [3.3.2 Variables](#Variables-1)
  + [3.4 Transformations](#Transformations)
  + [3.5 State Stack](#State-Stack-1)
  + [3.6 Frame Metadata](#Frame-Metadata-1)
  + [3.7 `if` / `repeat` Statements](#if-_002f-repeat-Statements)
    - [3.7.1 Comparison and Logical Operators](#Comparison-and-Logical-Operators)
    - [3.7.2 Early Exit](#Early-Exit)
  + [3.8 Procedures](#Procedures-1)
  + [3.9 Functions in Expressions](#Functions-in-Expressions)
    - [3.9.1 Function `p`](#Function-p)
    - [3.9.2 Function `pathlen`](#Function-pathlen)
    - [3.9.3 Function `randomg`](#Function-randomg)
  + [3.10 Tracing with `print`](#Tracing-with-print)
    - [3.10.1 Function print](#Function-print)
    - [3.10.2 Command `print`](#Command-print-1)
* [4 Commands](#Commands-1)
  + [4.1 `arc`](#arc)
  + [4.2 `arcn`](#arcn)
  + [4.3 `break`](#break)
  + [4.4 `call`](#call)
  + [4.5 `circle`](#circle)
  + [4.6 `clip`, `eoclip`](#clip_002c-eoclip)
  + [4.7 `Z`, `z`, `closepath`](#Z_002c-z_002c-closepath)
  + [4.8 `colorstop`](#colorstop)
  + [4.9 `C`, `curveto`](#C_002c-curveto)
  + [4.10 `c`, `rcurveto`](#c_002c-rcurveto)
  + [4.11 `defhsla`](#defhsla)
  + [4.12 `defrgba`](#defrgba)
  + [4.13 `ellipse`](#ellipse)
  + [4.14 `fill`, `eofill`](#fill_002c-eofill)
  + [4.15 `getmetadata`](#getmetadata)
  + [4.16 `H`, `h`](#H_002c-h)
  + [4.17 `if`](#if)
  + [4.18 `lineargrad`](#lineargrad)
  + [4.19 `L`, `lineto`](#L_002c-lineto)
  + [4.20 `l`, `rlineto`](#l_002c-rlineto)
  + [4.21 `M`, `moveto`](#M_002c-moveto)
  + [4.22 `m`, `rmoveto`](#m_002c-rmoveto)
  + [4.23 `newpath`](#newpath)
  + [4.24 `preserve`](#preserve)
  + [4.25 `print`](#print)
  + [4.26 `proc`](#proc)
  + [4.27 `Q`](#Q)
  + [4.28 `q`](#q)
  + [4.29 `radialgrad`](#radialgrad)
  + [4.30 `rect`](#rect)
  + [4.31 `repeat`](#repeat)
  + [4.32 `resetclip`](#resetclip)
  + [4.33 `resetdash`](#resetdash)
  + [4.34 `resetmatrix`](#resetmatrix)
  + [4.35 `restore`](#restore)
  + [4.36 `rotate`](#rotate)
  + [4.37 `roundedrect`](#roundedrect)
  + [4.38 `save`](#save)
  + [4.39 `scale`](#scale)
  + [4.40 `scalexy`](#scalexy)
  + [4.41 `setcolor`](#setcolor)
  + [4.42 `setdash`](#setdash)
  + [4.43 `setdashoffset`](#setdashoffset)
  + [4.44 `sethsla`](#sethsla)
  + [4.45 `setlinecap`](#setlinecap)
  + [4.46 `setlinejoin`](#setlinejoin)
  + [4.47 `setlinewidth`](#setlinewidth)
  + [4.48 `setrgba`](#setrgba)
  + [4.49 `setvar`](#setvar)
  + [4.50 `stroke`](#stroke)
  + [4.51 `S`, `s`](#S_002c-s)
  + [4.52 `translate`](#translate)
  + [4.53 `T`, `t`](#T_002c-t)
  + [4.54 `V`, `v`](#V_002c-v)

## [1 Introduction](#toc-Introduction)

drawvg (*draw vector graphics*) is a language to draw
two-dimensional graphics on top of video frames. It is not intended to
be used as a general-purpose language. Since its scope is limited, it
prioritizes being concise and easy to use.

For example, using the
[Canvas
API](https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API) we can render a triangle running this code in a Web browser:

```
const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");

ctx.beginPath();
ctx.moveTo(125, 50);
ctx.lineTo(100, 100);
ctx.lineTo(150, 100);
ctx.closePath();
ctx.stroke();
```

The same triangle can be written with this drawvg script:

```
moveto 125 50
lineto 100 100 150 100
closepath
stroke
```

It can be shortened using the aliases for [`moveto`](#cmd_005fmoveto), [`lineto`](#cmd_005flineto),
and [`closepath`](#cmd_005fclosepath):

```
M 125 50
L 100 100 150 100
Z
stroke
```

Both newlines (`U+000A`) and spaces (`U+0020`) can be used
interchangeably as delimiters, so multiple commands can appear on the
same line:

```
M 125 50 L 100 100 150 100 Z
stroke
```

Finally, drawvg can use [(ffmpeg-utils)FFmpeg expressions](ffmpeg-utils.html#Expression-Evaluation) and frame metadata in command arguments. In
this example, we are using the variables w (frame width) and h
(frame height) to create a circle in the middle of the frame.

```
circle (w / 2) (h / 2) (w / 3)
stroke
```

Many commands are a direct equivalent to a function in the
[Cairo graphics library](https://www.cairographics.org/). For such
commands, the reference below provides a link to the related Cairo
documentation.

## [2 Syntax](#toc-Syntax)

The syntax is heavily inspired by languages like
[Magick
Vector Graphics](https://imagemagick.org/script/magick-vector-graphics.php), or [SVG’s `<path>`](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Element/path). Many command names are taken from
[PostScript](https://en.wikipedia.org/wiki/PostScript).

### [2.1 Structure](#toc-Structure)

A drawvg script consists of a series of commands to describe 2D
graphics.

A command is an identifier (like [`setcolor`](#cmd_005fsetcolor) or [`lineto`](#cmd_005flineto))
followed by its arguments. Each item in the code (command name,
arguments, etc.) is separated by any of the following characters:

* Space (`' '`)
* Comma (`','`)
* Newline (`'\n'`)
* Tabs (`'\t'`)
* Return (`'\r'`)

The beginning of the item indicates how it will be interpreted:

`//`
:   Comment

`0`, …, `9`, `+`, `-`
:   Number literal

`(`
:   Expression

`{`, `}`
:   Block delimiters

Anything else
:   Name of a command, a color, etc.

### [2.2 Comments](#toc-Comments)

Comments start with two slashes (`//`), and stop at the end of the
line (either a `\n`, or the end of the script).

```
circle 100 100 50 // this is ignored
fill

// this is also ignored
```

`//` must appear after a space, or at the beginning of the line. If
`//` is preceded by any non-blank character, the parser will
consider `//` as part of the previous item.

For example, in this script:

```
circle 10 10 50// something
```

The parser throws an error because it tries to parse `50//` as a
number literal.

### [2.3 Commands](#toc-Commands)

The way commands are parsed is inspired by [SVG’s `<path>`](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Element/path):

* Every command in the script starts with its name, and it is followed by
  zero or more arguments.
* There are no explicit delimiters between commands or arguments.

  Most programming languages expect characters like parenthesis, commas,
  or semicolons, to separate items. For example:

  ```
  moveto(10, 10); lineto(20, 30);
  ```

  The equivalent in drawvg is:

  ```
  moveto 10 10 lineto 20 30
  ```
* If the command has no arguments (like [`closepath`](#cmd_005fclosepath) or
  [`stroke`](#cmd_005fstroke)), the next command starts at the next item.

|  |
| --- |
| In the next script there are 4 different commands:  ``` newpath rect 10 20 30 40 setcolor teal fill ```   1. [`newpath`](#cmd_005fnewpath) requires no arguments. 2. [`rect`](#cmd_005frect) requires 4 arguments, so it takes the next 4 numbers. 3. [`setcolor`](#cmd_005fsetcolor) requires 1 argument, so it takes the word `teal`. 4. [`fill`](#cmd_005ffill) requires no arguments. |

#### [2.3.1 Single-Letter Aliases](#toc-Single_002dLetter-Aliases)

Most commands in [SVG’s `<path>`](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Element/path) are also present in drawvg. For some of them,
there is an alias to a longer name:

* [`curveto`](#cmd_005fcurveto) for [`C`](#cmd_005fC).
* [`rcurveto`](#cmd_005frcurveto) for [`c`](#cmd_005fc).
* [`lineto`](#cmd_005flineto) for [`L`](#cmd_005fL).
* [`rlineto`](#cmd_005frlineto) for [`l`](#cmd_005fl).
* [`moveto`](#cmd_005fmoveto) for [`M`](#cmd_005fM).
* [`rmoveto`](#cmd_005frmoveto) for [`m`](#cmd_005fm).
* [`closepath`](#cmd_005fclosepath) for [`Z`](#cmd_005fZ), [`z`](#cmd_005fz).

Other commands only exist in a single-letter form:

* [`H`](#cmd_005fH), [`h`](#cmd_005fh)
* [`Q`](#cmd_005fQ), [`q`](#cmd_005fq)
* [`S`](#cmd_005fS), [`s`](#cmd_005fs)
* [`V`](#cmd_005fV), [`v`](#cmd_005fv)
* [`T`](#cmd_005fT), [`t`](#cmd_005ft)

This makes it possible to use a path in SVG to create the same shape in
a drawvg script.

#### [2.3.2 Implicit Commands](#toc-Implicit-Commands)

For many commands, the name can be omitted when it is used multiple
times in successive calls.

In the reference below, these commands has a *Can be Implicit* note
in their signature.

|  |
| --- |
| For example, in this script:  ``` M 50 50 l 10 10 l 10 -10 l 10 10 l 10 -10 l 10 10 stroke ```  After the first call to [`l`](#cmd_005fl) (alias to [`rlineto`](#cmd_005frlineto)), the command can be executed without the name, so it can be written as:  ``` M 50 50 l 10 10 10 -10 10 10 10 -10 10 10 stroke ``` |

To reuse the same command ([`l`](#cmd_005fl), in the previous example), the
parser checks if the item after the last argument is a numeric value,
like a number literal or a FFmpeg expression.

|  |
| --- |
| In this example:  ``` l 10 20 30 40 stroke ```  [`l`](#cmd_005fl) requires 2 arguments, and can be implicit, so the parser performs this operation:   1. Takes the two next items (`10` and `20`) and emits the first    instruction. 2. Checks if the item after `20` is a numeric value. Since it is    `30`, it takes `30` and `40` and emits the second    instruction (`l 30 40`). 3. Checks if the next item after `40` is a numeric value, but it is a    command ([`stroke`](#cmd_005fstroke)), so it stops reusing [`l`](#cmd_005fl). |

This is another feature taken from [SVG’s `<path>`](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Element/path). An important difference with
SVG is that the separator between items is always required. In SVG, it can be
omitted in some cases. For example, the expression `m1-2` is equivalent to
`m 1 -2` in SVG, but a syntax error in drawvg.

### [2.4 Arguments](#toc-Arguments)

Most commands expect numeric arguments, like number literals, variable
names, or expressions.

[`setcolor`](#cmd_005fsetcolor) and [`colorstop`](#cmd_005fcolorstop) expect a color.

[`setlinecap`](#cmd_005fsetlinecap) and [`setlinejoin`](#cmd_005fsetlinejoin) expect a constant value.

#### [2.4.1 Number Literals](#toc-Number-Literals)

A number literal is an item in the script that represents a constant
value. Any item that starts with a decimal digit (between `0` and
`9`), a `-` or a `+`, is interpreted as a number literal.

The value is parsed with
[`av_strtod`](https://ffmpeg.org/doxygen/trunk/eval_8c.html#a7d21905c92ee5af0bb529d2daf8cb7c3).
It supports the prefix `0x` to write a value with hexadecimal
digits, and
[many
units](https://ffmpeg.org/ffmpeg-utils.html#:~:text=The%20evaluator%20also%20recognizes%20the%20International%20System%20unit%20prefixes) (like `K` or `GiB`).

In the next example, all literals represent the same value:

```
10000
1e4
10K
0x2710
```

#### [2.4.2 Expressions](#toc-Expressions)

[(ffmpeg-utils)FFmpeg expressions](ffmpeg-utils.html#Expression-Evaluation) can be used as arguments for any command that expects a numeric
argument. The expression must be enclosed in parenthesis.

|  |
| --- |
| The variables w and h represent the width and height of the frame. We can compute the center of the frame by dividing them by `2`:  ``` M (w / 2) (h / 2) ```  They can also contain parenthesis (to group operations, to call functions, etc):  ``` moveto     ((w + 10) / 2)      // x     (h / (2 * cos(t)))  // y ``` |

The variables n and t can be used to compute a value that changes
over time.

|  |
| --- |
| To draw a circle oscillating from left to right, we can use an expression based on `sin(t)` for the `x` coordinate:  ``` circle     (w / 2 + sin(2 * t) * w / 4)  // x     (h / 2)                       // y     (w / 5)                       // radius  stroke ``` |

Expressions can be split in multiple lines, but they can’t contain
comments within them.

```
moveto   // This is a comment.
    (w   // This is part of the expression, not a comment.
     + h)
```

#### [2.4.3 Variable Names](#toc-Variable-Names)

When an expression is only a reference to a variable, the parenthesis
can be omitted, and the item is just the variable name.

|  |
| --- |
| The next 3 expressions are equivalent: in all cases, they create a rectangle covering the whole frame.  ``` rect (0) (0) (w) (h)  rect 0 0 w h  rect (0) 0 (w) h ``` |

It is possible to create a variable with the same name of a command, and
then use it as an argument. In the previous example, the item h is a
reference to a variable (frame height), but in other contexts it may be
a command ([`h`](#cmd_005fh)).

For [implicit commands](#implicit-commands), the parser prioritizes
commands over variable names when it has to determine if the command is
reused.

|  |
| --- |
| In this example, the variable c is used as the first argument in two calls to [`l`](#cmd_005fl). However, only the first one is valid, because in the second call the parser recognizes [`c`](#cmd_005fc) as a command.  ``` setvar c 5 l c 10 c 15 ```  This issue can be fixed by surrounding the start of the second call with parenthesis:  ``` setvar c 5 l c 10 (c) 15 ``` |

#### [2.4.4 Colors](#toc-Colors-1)

The color to stroke and to fill paths can be set with [`setcolor`](#cmd_005fsetcolor).
Its argument has the same syntax for colors in FFmpeg:

* A [(ffmpeg-utils)predefined color name](ffmpeg-utils.html#Color).
* In `#RRGGBB` fo