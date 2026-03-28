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

+ [Download pre-built assets](../pull/)

+ [Build assets](../build/)

+ [Add custom assets](../custom_assets/)

+ [Retrieve paths to assets](../seek/)

+ [Use asset tags](../tag/)

+ [Use aliases](../aliases/)

+ [Populate refgenie paths](../populate/)

+ [Compare genomes](./)

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

# Genomes compatibility

## Motivation

Many genomic analyses require less stringent comparison: simple compatibility between assets that are not necessarily identical.
For example, if we wanted to annotate genomic regions based on aligned BAM file using feature annotations we would need the reads to share just the coordinate system (the sequence lengths and names). Importantly, it does not require sequence identity at all. In this case, we would like to confirm that the given `bowtie2_index` asset is at least compatible with the coordinate system of feature annotation file.

To sum up, we need a more detailed comparison that may ignore sequences but allow to compare other aspects of the reference genome.

## Solution

Refgenie facilitates such fine-grained comparison of genomes via `refgenie compare` command. A useful "byproduct" of genome initialization described in [Use aliases how-to guide](../aliases/) is a JSON file with annotated sequence digests, that are required to compare FASTA file contents.

## Usage

In order to compare two initialized genomes one needs to issue the following command

```
refgenie compare hg38 hg38_plus
```

The result is a set of informative flags that determine the level of compatibility of the genomes, for example:

```
Flag: 2005
Binary: 0b11111010101

CONTENT_ALL_A_IN_B
LENGTHS_ALL_A_IN_B
NAMES_ALL_A_IN_B
CONTENT_A_ORDER
CONTENT_B_ORDER
CONTENT_ANY_SHARED
LENGTHS_ANY_SHARED
NAMES_ANY_SHARED
```

Based on the output above we can conclude that genome `hg38_plus` is a superset of `hg38`.

* [Previous](../populate/)
* [Next](../refgenieserver/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/compare.md)

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