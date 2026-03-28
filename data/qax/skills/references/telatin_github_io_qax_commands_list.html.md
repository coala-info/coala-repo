[QAX](/qax/ "Qiime Artifacts eXtractor Documentation")

v0.9.8 - migrate to Nim 2 and NimYaml 2

* [1. Installation](/qax/installation)
* [2. General usage](/qax/usage)
* [3. Usage examples](/qax/examples)

 [Commands](/qax/commands/)

* [1. List](/qax/commands/list.html)
* [2. View](/qax/commands/view.html)
* [3. Provenance](/qax/commands/provenance.html)
* [4. Make](/qax/commands/make.html)
* [5. List](/qax/commands/extract.html)
* [6. Citations](/qax/commands/citations.html)

 [Releases](/qax/releases/)

* [v0.9.5](/qax/releases/v0.9.5.html)
* [v0.9.6](/qax/releases/v0.9.6.html)
* [v0.9.6](/qax/releases/v0.9.7.html)

[QAX](/qax/)

* [commands](/qax/commands/)
* list.md

---

# List

## Synopsis

```
Usage: list [options] [<inputfile> ...]

Options:
  --abs                  Show absolute paths [default: false]
  -a, --all              Show all fields [default: false]
  -b, --basename         Use basename instead of path [default: false]
  -s, --sortby SORT      Column to sort (uuid, type, format, date) [default: type]
  -f, --force            Accept non standard extensions
  --verbose              Verbose output
  --help                 Show this help

Nice output (default):
  -d, --datetime         Show artifact's date time [default: false]
  -u, --uuid             Show uuid [default: false]

Raw table output:
  -r, --rawtable         Print a CSV table (-s) with all fields [default: false]
  -h, --header           Print header [default: false]
  -z, --separator SEP    Separator when using --rawtable [default: tab]
```

## Examples

To list a set of artifacts data:

```
qax list input/*.qz?
```

Will produce:

```
┌────────────────────┬─────────────────────────┬─────────────────────────────┐
│ Path               │ Type                    │ Format                      │
├────────────────────┼─────────────────────────┼─────────────────────────────┤
│ input/rep-seqs.qza │ FeatureData[Sequence]   │ DNASequencesDirectoryFormat │
│ input/table.qza    │ FeatureTable[Frequency] │ BIOMV210DirFmt              │
│ input/taxonomy.qzv │ Visualization           │ HTML                        │
└────────────────────┴─────────────────────────┴─────────────────────────────┘
```

Adding `--all` and `--basename` to print all fields, and showing only the filename of the artifacts:

```
┌──────────────────────────────────────┬──────────────┬─────────────────────────┬─────────────────────────────┬───────────┬──────────────────┬───────┐
│ ID                                   │ Basename     │ Type                    │ Format                      │ Version   │ Date             │ Files │
├──────────────────────────────────────┼──────────────┼─────────────────────────┼─────────────────────────────┼───────────┼──────────────────┼───────┤
│ bb1b2e93-0c45-4c8e-a140-2afa2110b5fb │ rep-seqs.qza │ FeatureData[Sequence]   │ DNASequencesDirectoryFormat │ 2019.10.0 │ 2022-05-13;14:26 │ 1     │
│ 313a0cf3-e2ec-48cf-95af-befad4ebf2f3 │ table.qza    │ FeatureTable[Frequency] │ BIOMV210DirFmt              │ 2019.10.0 │ 2022-05-13;14:26 │ 1     │
│ 35c32fe7-3eb5-4b31-aa34-85ef27545f00 │ taxonomy.qzv │ Visualization           │ HTML                        │ 2019.10.0 │ 2022-05-13;14:26 │ 18    │
└──────────────────────────────────────┴──────────────┴─────────────────────────┴─────────────────────────────┴───────────┴──────────────────┴───────┘
```

[Next](/qax/commands/view.html "View")

---

2020-2026, [Andrea Telatin](https://github.com/telatin) Revision [7b2b202](https://github.com/telatin/qax/commit/7b2b2026bd53c876dc2703245deae696dc9a0b12 "7b2b2026bd53c876dc2703245deae696dc9a0b12")

Built with [GitHub Pages](https://pages.github.com "github-pages v232") using a theme provided by RunDocs.

QAX

main

GitHub
:   [Homepage](https://github.com/telatin/qax "Stars: 5")
:   [Issues](https://github.com/telatin/qax/issues "Open issues: 0")
:   [Download](https://github.com/telatin/qax/zipball/main "Size: 16022 Kb")

---

This [Software](/qax/ "QAX") is under the terms of [GNU General Public License v3.0](https://github.com/telatin/qax).