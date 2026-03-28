[![](../img/refgenie_logo_light.svg)](..)

* [Refgenomes server](../servers)

* Search
* [Manuscripts](../manuscripts)
* [GitHub](https://github.com/databio/refgenie/)
* [PyPI](https://pypi.org/project/refgenie)
* [Databio.org](http://databio.org)

* #### Getting Started

+ [Introduction](..)

+ [Demo videos](../demo_videos/)

+ [Overview](../overview/)

+ [Install and configure](../install/)

+ [Basic tutorial](../tutorial/)

+ [Citing refgenie](../manuscripts/)

* #### How-to guides

+ [Refer to assets](../asset_registry_paths/)

+ [Download pre-built assets](./)

+ [Build assets](../build/)

+ [Add custom assets](../custom_assets/)

+ [Retrieve paths to assets](../seek/)

+ [Use asset tags](../tag/)

+ [Use aliases](../aliases/)

+ [Populate refgenie paths](../populate/)

+ [Compare genomes](../compare/)

+ [Run my own asset server](../refgenieserver/)

+ [Use refgenie from Python](../refgenconf/)

+ [Use refgenie in your pipeline](../code_snippets/)

+ [Use refgenie on the cloud](../remote/)

+ [Use refgenie with iGenomes](../igenomes/)

+ [Upgrade from config 0.3 to 0.4](../config_upgrade_03_to_04/)

* #### Reference

+ [Studies using refgenie](../uses_refgenie/)

+ [Genome configuration file](../genome_config/)

+ [Glossary](../glossary/)

+ [Buildable assets](../available_assets/)

+ [Usage](../usage/)

+ [Python API](../autodoc_build/refgenconf/)

+ [FAQ](../faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](../contributing/)

+ [Changelog](../changelog/)

# Download pre-built reference genome assets

## Introduction

Use the `refgenie` command-line interface to download and organize genome assets. You do this by simply running `refgenie` from the command line.

The `listr` command *lists remote assets* to see what's available:

```
refgenie listr
```

The `pull` *downloads* the specific asset of your choice:

```
refgenie pull GENOME/ASSET
```

Where `GENOME` refers to a genome key (*e.g.* hg38) and `ASSET` refers to one or more specific asset keys (*e.g.* bowtie2\_index). For example:

```
refgenie pull hg38/bowtie2_index
```

You can also pull many assets at once:

```
refgenie pull --genome mm10 bowtie2_index hisat2_index
```

To see more details, consult the usage docs by running `refgenie pull --help`.

That's it! Easy.

## Downloading manually

You can also browse and download pre-built `refgenie` assemblies manually at [refgenomes.databio.org](http://refgenomes.databio.org).

* [Previous](../asset_registry_paths/)
* [Next](../build/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/pull.md)

[Sheffield Computational Biology Lab](http://databio.org/)

##### Search

×Close

From here you can search these documents. Enter
your search terms below.

#### Keyboard Shortcuts

×Close

| Keys | Action |
| --- | --- |
| `?` | Open this help |
| `n` | Next page |
| `p` | Previous page |
| `s` | Search |