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

+ [Refer to assets](./)

+ [Download pre-built assets](../pull/)

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

# Asset registry paths

Each asset is defined by four components:

1. genome name
2. asset name
3. tag name
4. seek key

All `refgenie` commands require a genome name, and most also require an asset name. Tag and seek keys are used only when needed and otherwise use sensible defaults.

The most convenient way to provide this information on the command line is with an *asset registry path*, which take this form:

```
genome/asset.seek_key:tag
```

For example, `hg38/fasta.fai:default`. Yes, that's a lot of typing if you want to be explicit, but `refgenie` makes usage of asset registry paths easy with a system of defaults, such that all the commands below return the same path:

```
$ refgenie seek rCRSd/fasta
path/to/genomes/archive/rCRSd/fasta/default/rCRSd.fa

$ refgenie seek rCRSd/fasta.fasta
path/to/genomes/archive/rCRSd/fasta/default/rCRSd.fa

$ refgenie seek rCRSd/fasta.fasta:default
path/to/genomes/archive/rCRSd/fasta/default/rCRSd.fa
```

How did it work?

* **default tag** is determined by `default_tag` pointer in the config
* **seek\_key** defaults to the name of the asset

## Using arguments instead of registry paths

Alternatively, you can specify all of these namespace components as command line arguments:

```
refgenie seek -g rCRSd -a fasta -t default
```

One advantage of this approach is that it allows you to refer to multiple assets belonging to the same genome.

* [Previous](../manuscripts/)
* [Next](../pull/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/asset_registry_paths.md)

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