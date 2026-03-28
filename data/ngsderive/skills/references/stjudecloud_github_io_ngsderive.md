[ngsderive](.)

* [Home](.)
* Subcommands
  + [strandedness](subcommands/strandedness/)
  + [instrument](subcommands/instrument/)
  + [readlen](subcommands/readlen/)
  + [encoding](subcommands/encoding/)
  + [junction-annotation](subcommands/junction_annotation/)

* Search
* Previous
* [Next](subcommands/strandedness/)
* [Edit on GitHub](https://github.com/stjudecloud/ngsderive/edit/master/docs/index.md)

* [🎨 Features](#features)
* [📚 Getting Started](#getting-started)
* [🖥️ Development](#development)
* [🚧️ Tests](#tests)
* [🤝 Contributing](#contributing)
* [📝 License](#license)

# ngsderive

[![Actions: CI Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fstjudecloud%2Fngsderive%2Fbadge&style=flat)](https://actions-badge.atrox.dev/stjudecloud/ngsderive/goto)
[![PyPI](https://img.shields.io/pypi/v/ngsderive?color=orange)](https://pypi.org/project/ngsderive/)
[![PyPI: Downloads](https://img.shields.io/pypi/dm/ngsderive?color=orange)](https://pypi.python.org/pypi/ngsderive/)
[![PyPI: Downloads](https://img.shields.io/pypi/pyversions/ngsderive?color=orange)](https://pypi.python.org/pypi/ngsderive/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/stjudecloud/ngsderive/blob/master/LICENSE.md)

Forensic analysis tool useful in backwards computing information from next-generation sequencing data and annotating splice junctions.

[**Explore the docs »**](https://stjudecloud.github.io/ngsderive/)

[Request Feature](https://github.com/stjudecloud/ngsderive/issues/new?assignees=&labels=&template=feature_request.md&title=Descriptive%20Title&labels=enhancement)
·
[Report Bug](https://github.com/stjudecloud/ngsderive/issues/new?assignees=&labels=&template=bug_report.md&title=Descriptive%20Title&labels=bug)
·
⭐ Consider starring the repo! ⭐

> Notice: `ngsderive` is largely a forensic analysis tool useful in backwards computing information
> from next-generation sequencing data. Notably, most results are provided as a 'best guess' —
> the tool does not claim 100% accuracy and results should be considered with that understanding.
> An exception would be the `junction-annotation` tool which analyzes more concrete evidence than the other tools.

## 🎨 Features

The following attributes can be guessed using ngsderive:

* **Illumina Instrument.** Infer which Illumina instrument was used to generate the data by matching against known instrument and flowcell naming patterns. Each guess comes with a confidence score.
* **RNA-Seq Strandedness.** Infer from the data whether RNA-Seq data was generated using a Stranded-Forward, Stranded-Reverse, or Unstranded protocol.
* **Pre-trimmed Read Length.** Compute the distribution of read lengths in the file and attempt to guess what the original read length of the experiment was.
* **PHRED Score Encoding.** Infers which encoding scheme was used to store PHRED scores as ASCII characters.
* **Junction Annotation.** Annotates splice junctions as novel, partial novel, or known in comparison to a reference gene model.

## 📚 Getting Started

### Installation

You can install ngsderive using the Python Package Index ([PyPI](https://pypi.org/)).

```
pip install ngsderive
```

## 🖥️ Development

If you are interested in contributing to the code, please first review our [CONTRIBUTING.md](https://github.com/stjudecloud/ngsderive/blob/master/CONTRIBUTING.md) document.

To bootstrap a development environment, please use the following commands.

```
# Clone the repository
git clone git@github.com:stjudecloud/ngsderive.git
cd ngsderive

# Install the project using poetry
poetry install
```

## 🚧️ Tests

ngsderive provides a (currently patchy) set of tests — both unit and end-to-end.

```
py.test
```

## 🤝 Contributing

Contributions, issues and feature requests are welcome!
Feel free to check [issues page](https://github.com/stjudecloud/ngsderive/issues). You can also take a look at the [contributing guide](https://github.com/stjudecloud/ngsderive/blob/master/CONTRIBUTING.md).

## 📝 License

This project is licensed as follows:

* All code related to the `instrument` subcommand is licensed under the [AGPL v2.0](http://www.affero.org/agpl2.html). This is not due to any strict requirement, but out of deference to some [code](https://github.com/10XGenomics/supernova/blob/master/tenkit/lib/python/tenkit/illumina_instrument.py) I drew inspiration from (and copied patterns from), the decision was made to license this code consistently.
* The rest of the project is licensed under the MIT License - see the <LICENSE.md> file for details.

Copyright © 2020 [St. Jude Cloud Team](https://github.com/stjudecloud).

---

© 2020 St. Jude Children's Research Hospital

Documentation built with [MkDocs](https://www.mkdocs.org/).

#### Search

×Close

From here you can search these documents. Enter your search terms below.

#### Keyboard Shortcuts

×Close

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |