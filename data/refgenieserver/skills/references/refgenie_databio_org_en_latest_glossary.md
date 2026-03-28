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

+ [Glossary](./)

+ [Buildable assets](../available_assets/)

+ [Usage](../usage/)

+ [Python API](../autodoc_build/refgenconf/)

+ [FAQ](../faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](../contributing/)

+ [Changelog](../changelog/)

# Glossary

A common set of concepts is central to these and other genomics resources docs,
but often terminology differs between sources, or even within the same one (and may here).

Here are some clarifications regarding wording and meaning.

* **Assembly**: a particular version of a consensus genomic sequence for an organism
* **Asset**: a folder consisting of one or more files related to a specific reference genome
* **Asset registry path**: a string used to refer to assets, of the form: `genome/asset:tag`. If using an asset with more than 1 seek key, additional keys are appended like: `genome/asset:key:tag`.
* **Genome**: here, this is used interchangeably with *assembly*
* **Reference assembly**: another synonym for *assembly*
* **Reference genome**: yet another synonym for assembly
* **Seek key** a string identifier for a particular file or folder contained within an asset. A seek key is used to retrieve a path with refgenie seek. Seek keys allow a single asset to provide more than one endpoint for retrieval.
* **Tag**: a unique string identifier that allows for multiple assets of the same name to co-exist. One common use case for tags is to maintain multiple versions of an asset.

* [Previous](../genome_config/)
* [Next](../available_assets/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/glossary.md)

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