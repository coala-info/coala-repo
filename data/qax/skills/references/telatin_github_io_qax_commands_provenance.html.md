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
* provenance.md

---

# Provenance

## Synopsis

## Example

To show the provenance of an artifact:

```
qax provenance input/taxonomy.qzv
```

Output:

```
environment:plugins:metadata
6e46b89a-0fcb-4a5f-860c-ec8ce26e7140    top     2020-01-24 09:01        reference_reads         [inputs: <none>]
ffdfda2e-be68-47f6-9bf5-07ccdd869689    top     2020-01-24 09:01        reference_taxonomy              [inputs: <none>]
71429e7c-6489-42d6-bbca-f4a6d9b85b48    |       2020-01-24 09:01        classifier              [inputs: 6e46b89a-0fcb-4a5f-860c-ec8ce26e7140;ffdfda2e-be68-47f6-9bf5-07ccdd869689;null]
a1ad1da7-8cc8-439b-bec5-c66a1125786f    top     2020-02-28 11:02        per_sample_sequences            [inputs: <none>]
3c984d76-82a7-4ff6-b64b-561834df9327    |       2020-02-28 11:02        demultiplexed_seqs              [inputs: a1ad1da7-8cc8-439b-bec5-c66a1125786f]
bb1b2e93-0c45-4c8e-a140-2afa2110b5fb    |       2020-02-28 13:02        reads           [inputs: 3c984d76-82a7-4ff6-b64b-561834df9327]
9df28153-4e38-44aa-bbc4-58a37d699580    |       2020-02-28 13:02        input           [inputs: bb1b2e93-0c45-4c8e-a140-2afa2110b5fb;71429e7c-6489-42d6-bbca-f4a6d9b85b48]
35c32fe7-3eb5-4b31-aa34-85ef27545f00    child   2020-02-28 13:02        visualization           [inputs: 9df28153-4e38-44aa-bbc4-58a37d699580:input.tsv]
```

[Previous](/qax/commands/view.html "View")

[Next](/qax/commands/make.html "Make")

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