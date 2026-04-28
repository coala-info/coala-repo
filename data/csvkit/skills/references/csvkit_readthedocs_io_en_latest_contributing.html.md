Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[csvkit 2.2.0 documentation](index.html)

[csvkit 2.2.0 documentation](index.html)

* [Tutorial](tutorial.html)[ ]
* [Reference](cli.html)[ ]
* [Tips and Troubleshooting](tricks.html)
* Contributing to csvkit
* [Release process](release.html)
* [License](license.html)
* [Changelog](changelog.html)

Back to top

[View this page](_sources/contributing.rst.txt "View this page")

# Contributing to csvkit[¶](#contributing-to-csvkit "Link to this heading")

csvkit actively encourages contributions from people of all genders, races, ethnicities, ages, creeds, nationalities, persuasions, alignments, sizes, shapes, and journalistic affiliations. You are welcome here.

We seek contributions from developers and non-developers of all skill levels. We will typically accept bug fixes and documentation updates with minimal fuss. If you want to work on a larger feature—great! The maintainers will be happy to provide feedback and code review on your implementation.

Before making any changes or additions to csvkit, please be sure to read the rest of this document, especially the “Principles of development” section.

## Getting started[¶](#getting-started "Link to this heading")

```
git clone git://github.com/wireservice/csvkit.git
cd csvkit
pip install -e .[test]
```

## Principles of development[¶](#principles-of-development "Link to this heading")

csvkit is to tables as Unix text processing commands (cut, grep, cat, sort) are to text. As such, csvkit adheres to [the Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy).

1. Small is beautiful.
2. Make each program do one thing well.
3. Build a prototype as soon as possible.
4. Choose portability over efficiency.
5. Store data in flat text files.
6. Use software leverage to your advantage.
7. Use shell scripts to increase leverage and portability.
8. Avoid captive user interfaces.
9. Make every program a filter.

As there is no single, standard CSV format, csvkit encourages popular formatting options:

* Output targets broad compatibility: Quoting is done with double-quotes and only when required. Fields are delimited with commas. Rows are terminated with Unix line endings (”\n”).
* Output favors consistency over brevity: Numbers always include at least one decimal place, even if they are round. Dates and times are output in ISO 8601 format. Null values are rendered as empty strings.

## How to contribute[¶](#how-to-contribute "Link to this heading")

1. Fork the project on [GitHub](https://github.com/wireservice/csvkit).
2. Look through the [open issues](https://github.com/wireservice/csvkit/issues) for a task that you can realistically expect to complete in a few days. Don’t worry about the issue’s priority; instead, choose something you’ll enjoy. You’re more likely to finish something if you enjoy hacking on it.
3. Comment on the issue to let people know you’re going to work on it so that no one duplicates your effort. It’s good practice to provide a general idea of how you plan to resolve the issue so that others can make suggestions.
4. Write tests for any changes to the code’s behavior. Follow the format of the tests in the `tests/` directory to see how this works. You can run tests with the command `pytest`.
5. Write the code. Try to be consistent with the style and organization of the existing code. A good contribution won’t be refused for stylistic reasons, but large parts of it may be rewritten and nobody wants that.
6. As you’re working, periodically merge in changes from the upstream master branch to avoid having to resolve large merge conflicts. Check that you haven’t broken anything by running the tests.
7. Write documentation for any user-facing features.
8. Once it works, is tested, and is documented, submit a pull request on GitHub.
9. Wait for it to be merged or for a comment about what needs to be changed.
10. Rejoice.

## A note on new tools[¶](#a-note-on-new-tools "Link to this heading")

As a general rule, csvkit is no longer adding new tools. This is the result of limited maintenance time as well as a desire to keep the toolkit focused on the most common use cases. Exceptions may be made to this rule on a case-by-case basis. We, of course, welcome patches to improve existing tools or add useful features.

If you decide to build your own tool, we encourage you to create and maintain it as a separate Python package. You will probably want to use the [agate](https://agate.readthedocs.io/) library, which csvkit uses for most of its CSV reading and writing. Doing so will safe time and make it easier to maintain common behavior with csvkit’s core tools.

## Streaming versus buffering[¶](#streaming-versus-buffering "Link to this heading")

csvkit tools operate in one of two fashions: Some, such as [csvsort](scripts/csvsort.html), buffer their entire input into memory before writing any output. Other tools—those that can operate on individual records—write write a row immediately after reading a row. Records are “streamed” through the tool. Streaming tools produce output faster and require less memory than buffering tools.

For performance reasons tools should always offer streaming when possible. If a new feature would undermine streaming functionality it must be balanced against the utility of having a tool that can efficiently operate over large datasets.

Currently, the following tools stream:

* [csvclean](scripts/csvclean.html)
* [csvcut](scripts/csvcut.html)
* [csvformat](scripts/csvformat.html) unless `--quoting 2` is set
* [csvgrep](scripts/csvgrep.html)
* [csvstack](scripts/csvstack.html)
* [sql2csv](scripts/sql2csv.html)

Currently, the following tools buffer:

* [csvjoin](scripts/csvjoin.html)
* [csvjson](scripts/csvjson.html) unless `--stream --no-inference --snifflimit 0` is set and `--skip-lines` isn’t set
* [csvlook](scripts/csvlook.html)
* [csvpy](scripts/csvpy.html)
* [csvsort](scripts/csvsort.html)
* [csvsql](scripts/csvsql.html)
* [csvstat](scripts/csvstat.html)
* [in2csv](scripts/in2csv.html) unless `--format ndjson --no-inference` is set, or unless `--format csv --no-inference --snifflimit 0` is set and `--no-header-row` and `--skip-lines` aren’t set

## Legalese[¶](#legalese "Link to this heading")

To the extent that contributors care, they should keep the following legal mumbo-jumbo in mind:

The source of csvkit and therefore of any contributions are licensed under the permissive [MIT license](https://www.opensource.org/licenses/mit-license.php). By submitting a patch or pull request you are agreeing to release your contribution under this license. You will be acknowledged in the AUTHORS file. As the owner of your specific contributions you retain the right to privately relicense your specific contributions (and no others), however, the released version of the code can never be retracted or relicensed.

[Next

Release process](release.html)
[Previous

Tips and Troubleshooting](tricks.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Contributing to csvkit
  + [Getting started](#getting-started)
  + [Principles of development](#principles-of-development)
  + [How to contribute](#how-to-contribute)
  + [A note on new tools](#a-note-on-new-tools)
  + [Streaming versus buffering](#streaming-versus-buffering)
  + [Legalese](#legalese)