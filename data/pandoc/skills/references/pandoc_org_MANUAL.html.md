[Please help Ukraine!](https://novaukraine.org)

[Sponsor](https://github.com/users/jgm/sponsorship)

![](https://www.paypalobjects.com/en_US/i/scr/pixel.gif)

Pandoc

a universal document converter

* [About](index.html)
* [Installing](installing.html)
* [Demos](demos.html)
* Documentation
  + [Getting started](getting-started.html)
  + [User's Guide](MANUAL.html)
  + [User's Guide (PDF)](MANUAL.pdf)
  + [Contributing](CONTRIBUTING.html)
  + [FAQ](faqs.html)
  + [Press](press.html)
  + [Filters](filters.html)
  + [Lua filters](lua-filters.html)
  + [Custom readers](custom-readers.html)
  + [Custom writers](custom-writers.html)
  + [pandoc-server](pandoc-server.html)
  + [Making an ebook](epub.html)
  + [Emacs Org mode support](org.html)
  + [JATS support](jats.html)
  + [Typst property attributes](typst-property-output.html)
  + [Using the Pandoc API](using-the-pandoc-api.html)
  + [API documentation](https://hackage.haskell.org/package/pandoc)
* [Help](help.html)
* [Extras](extras.html)
* [Releases](releases.html)
* Search

# Pandoc User’s Guide

# Synopsis

`pandoc` [*options*]
[*input-file*]…

# Description

Pandoc is a [Haskell](https://www.haskell.org)
library for converting from one markup format to another, and a
command-line tool that uses this library.

Pandoc can convert between numerous markup and word processing
formats, including, but not limited to, various flavors of [Markdown](https://daringfireball.net/projects/markdown/),
[HTML](https://www.w3.org/html/), [LaTeX](https://www.latex-project.org/) and [Word
docx](https://en.wikipedia.org/wiki/Office_Open_XML). For the full lists of input and output formats, see the
[`--from`](#option--from) and
[`--to`](#option--to) [options below](#general-options). Pandoc can also produce
[PDF](https://www.adobe.com/pdf/) output: see [creating a PDF](#creating-a-pdf), below.

Pandoc’s enhanced version of Markdown includes syntax for [tables](#tables), [definition
lists](#definition-lists), [metadata blocks](#metadata-blocks), [footnotes](#footnotes), [citations](#citations), [math](#math), and
much more. See below under [Pandoc’s
Markdown](#pandocs-markdown).

Pandoc has a modular design: it consists of a set of readers,
which parse text in a given format and produce a native
representation of the document (an *abstract syntax tree*
or AST), and a set of writers, which convert this native
representation into a target format. Thus, adding an input or
output format requires only adding a reader or writer. Users can
also run custom [pandoc
filters](https://pandoc.org/filters.html) to modify the intermediate AST.

Because pandoc’s intermediate representation of a document is
less expressive than many of the formats it converts between, one
should not expect perfect conversions between every format and
every other. Pandoc attempts to preserve the structural elements
of a document, but not formatting details such as margin size. And
some document elements, such as complex tables, may not fit into
pandoc’s simple document model. While conversions from pandoc’s
Markdown to all formats aspire to be perfect, conversions from
formats more expressive than pandoc’s Markdown can be expected to
be lossy.

## Using pandoc

If no *input-files* are specified, input is read from
*stdin*. Output goes to *stdout* by default. For
output to a file, use the [`-o`](#option--output)/[`--output`](#option--output) option:

```
pandoc -o output.html input.txt
```

By default, pandoc produces a document fragment. To produce a
standalone document (e.g. a valid HTML file including
`<head>` and `<body>`), use the
[`-s`](#option--standalone)
or [`--standalone`](#option--standalone) flag:

```
pandoc -s -o output.html input.txt
```

For more information on how standalone documents are produced,
see [Templates](#templates) below.

If multiple input files are given, pandoc will concatenate them
all (with blank lines between them) before parsing. (Use [`--file-scope`](#option--file-scope[) to parse files
individually.)

## Specifying formats

The format of the input and output can be specified explicitly
using command-line options. The input format can be specified
using the [`-f/--from`](#option--from) option, the output
format using the [`-t/--to`](#option--to) option. Thus, to convert
`hello.txt` from Markdown to LaTeX, you could type:

```
pandoc -f markdown -t latex hello.txt
```

To convert `hello.html` from HTML to Markdown:

```
pandoc -f html -t markdown hello.html
```

Supported input and output formats are listed below under [Options](#options) (see [`-f`](#option--from) for input formats and [`-t`](#option--to) for output
formats). You can also use
`pandoc --list-input-formats` and
`pandoc --list-output-formats` to print lists of
supported formats.

If the input or output format is not specified explicitly,
pandoc will attempt to guess it from the extensions of the
filenames. Thus, for example,

```
pandoc -o hello.tex hello.txt
```

will convert `hello.txt` from Markdown to LaTeX. If
no output file is specified (so that output goes to
*stdout*), or if the output file’s extension is unknown,
the output format will default to HTML. If no input file is
specified (so that input comes from *stdin*), or if the
input files’ extensions are unknown, the input format will be
assumed to be Markdown.

## Character encoding

Pandoc uses the UTF-8 character encoding for both input and
output. If your local character encoding is not UTF-8, you should
pipe input and output through [`iconv`](https://www.gnu.org/software/libiconv/):

```
iconv -t utf-8 input.txt | pandoc | iconv -f utf-8
```

Note that in some output formats (such as HTML, LaTeX, ConTeXt,
RTF, OPML, DocBook, and Texinfo), information about the character
encoding is included in the document header, which will only be
included if you use the [`-s/--standalone`](#option--standalone) option.

## Creating a PDF

To produce a PDF, specify an output file with a
`.pdf` extension:

```
pandoc test.txt -o test.pdf
```

By default, pandoc will use LaTeX to create the PDF, which
requires that a LaTeX engine be installed (see [`--pdf-engine`](#option--pdf-engine) below).
Alternatively, pandoc can use ConTeXt, roff ms, or HTML as an
intermediate format. To do this, specify an output file with a
`.pdf` extension, as before, but add the [`--pdf-engine`](#option--pdf-engine) option or [`-t context`](#option--to), [`-t html`](#option--to), or [`-t ms`](#option--to) to the
command line. The tool used to generate the PDF from the
intermediate format may be specified using [`--pdf-engine`](#option--pdf-engine).

You can control the PDF style using variables, depending on the
intermediate format used: see [variables for LaTeX](#variables-for-latex), [variables for ConTeXt](#variables-for-context), [variables for
`wkhtmltopdf`](#variables-for-wkhtmltopdf), [variables for ms](#variables-for-ms). When HTML is used
as an intermediate format, the output can be styled using [`--css`](#option--css).

To debug the PDF creation, it can be useful to look at the
intermediate representation: instead of [`-o test.pdf`](#option--output), use for example [`-s -o test.tex`](#option--standalone) to output the
generated LaTeX. You can then test it with
`pdflatex test.tex`.

When using LaTeX, the following packages need to be available
(they are included with all recent versions of [TeX Live](https://www.tug.org/texlive/)): [`amsfonts`](https://ctan.org/pkg/amsfonts), [`amsmath`](https://ctan.org/pkg/amsmath), [`lm`](https://ctan.org/pkg/lm), [`unicode-math`](https://ctan.org/pkg/unicode-math),
[`iftex`](https://ctan.org/pkg/iftex), [`listings`](https://ctan.org/pkg/listings) (if
the [`--listings`](#option--listings[) option is used), [`fancyvrb`](https://ctan.org/pkg/fancyvrb), [`longtable`](https://ctan.org/pkg/longtable),
[`booktabs`](https://ctan.org/pkg/booktabs),
[`multirow`](https://ctan.org/pkg/multirow)
(if the document contains a table with cells that cross multiple
rows), [`graphicx`](https://ctan.org/pkg/graphicx) (if
the document contains images), [`bookmark`](https://ctan.org/pkg/bookmark), [`xcolor`](https://ctan.org/pkg/xcolor), [`soul`](https://ctan.org/pkg/soul), [`geometry`](https://ctan.org/pkg/geometry)
(with the `geometry` variable set), [`setspace`](https://ctan.org/pkg/setspace)
(with `linestretch`), and [`babel`](https://ctan.org/pkg/babel) (with
`lang`). If `CJKmainfont` is set, [`xeCJK`](https://ctan.org/pkg/xecjk) is needed
if `xelatex` is used, else [`luatexja`](https://ctan.org/pkg/luatexja) is
needed if `lualatex` is used. [`framed`](https://ctan.org/pkg/framed) is
required if code is highlighted in a scheme that use a colored
background. The use of `xelatex` or
`lualatex` as the PDF engine requires [`fontspec`](https://ctan.org/pkg/fontspec).
`lualatex` uses [`selnolig`](https://ctan.org/pkg/selnolig) and
[`lua-ul`](https://ctan.org/pkg/lua-ul).
`xelatex` uses [`bidi`](https://ctan.org/pkg/bidi) (with the
`dir` variable set). If the `mathspec`
variable is set, `xelatex` will use [`mathspec`](https://ctan.org/pkg/mathspec)
instead of [`unicode-math`](https://ctan.org/pkg/unicode-math).
The [`csquotes`](https://ctan.org/pkg/csquotes)
package will be used for [typography](#typography) if
the `csquotes` variable or metadata field is set to a
true value. The [`natbib`](https://ctan.org/pkg/natbib), [`biblatex`](https://ctan.org/pkg/biblatex), [`bibtex`](https://ctan.org/pkg/bibtex), and [`biber`](https://ctan.org/pkg/biber) packages
can optionally be used for [citation
rendering](#citation-rendering). If math with `\cancel`,
`\bcancel`, or `\xcancel` is used, the [`cancel`](https://ctan.org/pkg/cancel) package
is needed. The following packages will be used to improve output
quality if present, but pandoc does not require them to be
present: [`upquote`](https://ctan.org/pkg/upquote) (for
straight quotes in verbatim environments), [`microtype`](https://ctan.org/pkg/microtype)
(for better spacing adjustments), [`parskip`](https://ctan.org/pkg/parskip) (for
better inter-paragraph spaces), [`xurl`](https://ctan.org/pkg/xurl) (for better
line breaks in URLs), and [`footnotehyper`](https://ctan.org/pkg/footnotehyper)
or [`footnote`](https://ctan.org/pkg/footnote) (to
allow footnotes in tables).

## Reading from the Web

Instead of an input file, an absolute URI may be given. In this
case pandoc will fetch the content using HTTP:

```
pandoc -f html -t markdown https://www.fsf.org
```

It is possible to supply a custom User-Agent string or other
header when requesting a document from a URL:

```
pandoc -f html -t markdown --request-header User-Agent:"Mozilla/5.0" \
  https://www.fsf.org
```

# Options

## General options

`-f` *FORMAT*, `-r` *FORMAT*, `--from=`*FORMAT*, `--read=`*FORMAT*
:   Specify input format. *FORMAT* can be:

    * `asciidoc` ([AsciiDoc](https://asciidoc.org/) markup)
    * `bibtex` ([BibTeX](https://ctan.org/pkg/bibtex) bibliography)
    * `biblatex` ([BibLaTeX](https://ctan.org/pkg/biblatex)
      bibliography)
    * `bits` ([BITS](https://jats.nlm.nih.gov/extensions/bits/) XML,
      alias for `jats`)
    * `commonmark` ([CommonMark](https://commonmark.org) Markdown)
    * `commonmark_x` ([CommonMark](https://commonmark.org) Markdown with
      extensions)
    * `creole` ([Creole
      1.0](http://www.wikicreole.org/wiki/Creole1.0))
    * `csljson` ([CSL
      JSON](https://citeproc-js.readthedocs.io/en/latest/csl-json/markup.html) bibliography)
    * `csv` ([CSV](https://tools.ietf.org/html/rfc4180) table)
    * `tsv` ([TSV](https://www.iana.org/assignments/media-types/text/tab-separated-values)
      table)
    * `djot` ([Djot
      markup](https://djot.net))
    * `docbook` ([DocBook](https://docbook.org))
    * `docx` ([Word
      docx](https://en.wikipedia.org/wiki/Office_Open_XML))
    * `dokuwiki` ([DokuWiki markup](https://www.dokuwiki.org/dokuwiki))
    * `endnotexml` ([EndNote
      XML bibliography](https://support.clarivate.com/Endnote/s/article/EndNote-XML-Document-Type-Definition))
    * `epub` ([EPUB](http://idpf.org/epub))
    * `fb2` ([FictionBook2](http://www.fictionbook.org/index.php/Eng%3AXML_Schema_Fictionbook_2.1)
      e-book)
    * `gfm` ([GitHub-Flavored
      Markdown](https://help.github.com/articles/github-flavored-markdown/)), or the deprecated and less accurate
      `markdown_github`; use [`markdown_github`](#markdown-variants) only if
      you need extensions not supported in [`gfm`](#markdown-variants).
    * `haddock` ([Haddock
      markup](https://www.haskell.org/haddock/doc/html/ch03s08.html))
    * `html` ([HTML](https://www.w3.org/html/))
    * `ipynb` ([Jupyter
      notebook](https://nbformat.readthedocs.io/en/latest/))
    * `jats` ([JATS](https://jats.nlm.nih.gov)
      XML)
    * `jira` ([Jira](https://jira.atlassian.com/secure/WikiRendererHelpAction.jspa?section=all)/Confluence
      wiki markup)
    * `json` (JSON version of native AST)
    * `latex` ([LaTeX](https://www.latex-project.org/))
    * `markdown` ([Pandoc’s
      Markdown](#pandocs-markdown))
    * `markdown_mmd` ([MultiMarkdown](https://fletcherpenney.net/multimarkdown/))
    * `markdown_phpextra` ([PHP
      Markdown Extra](https://michelf.ca/projects/php-markdown/extra/))
    * `markdown_strict` (original unextended [Markdown](https://daringfireball.net/projects/markdown/))
    * `mediawiki` ([MediaWiki
      markup](https://www.mediawiki.org/wiki/Help%3AFormatting))
    * `man` ([roff
      man](https://man.cx/groff_man%287%29))
    * `mdoc` ([mdoc](https://mandoc.bsd.lv/man/mdoc.7.html) manual page
      markup)
    * `muse` ([Muse](https://amusewiki.org/library/manual))
    * `native` (native Haskell)
    * `odt` ([OpenDocument
      text document](https://en.wikipedia.org/wiki/OpenDocument))
    * `opml` ([OPML](https://opml.org/spec2.opml))
    * `org` ([Emacs Org
      mode](https://orgmode.org))
    * `pod` (Perl’s [Plain Old
      Documentation](https://perldoc.perl.org/perlpod))
    * `pptx` ([PowerPoint](https://en.wikipedia.org/wiki/Microsoft_PowerPoint))
    * `ris` ([RIS](https://en.wikipedia.org/wiki/RIS_%28file_format%29)
      bibliography)
    * `rtf` ([Rich Text
      Format](https://en.wikipedia.org/wiki/Rich_Text_Format))
    * `rst` ([reStructuredText](https://docutils.sourceforge.io/docs/ref/rst/introduction.html))
    * `t2t` ([txt2tags](https://txt2tags.org))
    * `textile` ([Textile](https://textile-lang.com))
    * `tikiwiki` ([TikiWiki
      markup](https://doc.tiki.org/Wiki-Syntax-Text#The_Markup_Language_Wiki-Syntax))
    * `twiki` ([TWiki
      markup](https://twiki.org/cgi-bin/view/TWiki/TextFormattingRules))
    * `typst` ([typst](https://typst.app))
    * `vimwiki` ([Vimwiki](https://vimwiki.github.io))
    * `xlsx` ([Excel
      spreadsheet](https://en.wikipedia.org/wiki/Microsoft_Excel#File_formats))
    * `xml` (XML version of native AST)
    * the path of a custom Lua reader, see [Custom readers and writers](#custom-readers-and-writers)
      below

    Extensions can be individually 