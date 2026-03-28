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

+ [Overview](./)

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

+ [Glossary](../glossary/)

+ [Buildable assets](../available_assets/)

+ [Usage](../usage/)

+ [Python API](../autodoc_build/refgenconf/)

+ [FAQ](../faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](../contributing/)

+ [Changelog](../changelog/)

# Refgenie overview

## Motivation

Reference genome assemblies are the starting point for many downstream tools, such as sequence alignment and annotation. Many tools produce independent assets that accompany a genome assembly; for instance, aligners like `bwa` or `bowtie2` must *hash* the genome, creating *indexes* to improve alignment performance. These indexes are typically shared across tools, so it's common for a research group to organize a central folder for reference genome assets, which includes indexes and other files like annotations. In addition to saving disk space, this simplifies sharing software among group members. Structuring assets uniformly allows software to adapt from one reference assembly to the next. However, each group typically does this independently. If we could standardize this across groups, it would make it easier to share scripts and software that use genome-related resources.

One effort to distribute standard, organized reference sequences and annotation files is Illumina's *IGenomes* project, which distributes pre-built archives of common assets for common genomes. This allows multiple groups to share one standard, but it has a few limitations: IGenomes doesn't provide software to produce a standard reference for an arbitrary genome. This is problematic because we often need to align to a custom genome, such as a spike-in control or a personal genome assembly. Furthermore, packaging many resources together in a single archive precludes itemized access to individual genome assets, costing computational resources.

![](../img/refgenie_interfaces.svg)

### Functionality

**Refgenie simultaneously provides structure to manually build assets while improving modular access to pre-built assets in the same system.** Refgenie does this by providing two ways to obtain genome assets (see figure at right).

1. Web-based access to individual pre-built assets via web interface or application programming interface (API)
2. An interface for scripted asset "builds," each of which produces structured output for arbitrary genome inputs.

This two-pronged approach enables users to either retrieve or produce *identically structured* outputs on demand for *any genome* of interest, including new assemblies, private assemblies, or custom genomes for which a public set of assets cannot exist.

## Refgenie ecosystem

Refgenie consists of 3 independent tools that work together:

### 1. The `refgenie` command-line interface (CLI)

The component that most users will interact with is the command-line interface. A simple `pip install refgenie` provides the `refgenie` command, which can be used to `pull` or `build` an asset of interest.

### 2. The `refgenieserver` package

While the `refgenie` CLI is useful by itself by allowing `refgenie build` without any remote component, it becomes even more powerful when it can communicate with a remote server via `refgenie pull`. In order to do this, we provide a remote counterpart called `refgenieserver`, which provides a web interface and an API that can be used by the CLI (or by any other tool), and allows users to list available assets and download them. We host a public instance at [refgenomes.databio.org](http://refgenomes.databio.org), but you can also use the software to run your own instance if you like.

### 3. The `refgenconf` Python package

Both the server and the CLI rely on `refgenconf`. This package provides a Python API to interact with the genome configuration files produced by refgenie. This provides a simple interface whereby any third-party Python packages can easily leverage the asset organization that refgenie implements.

* [Previous](../demo_videos/)
* [Next](../install/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/overview.md)

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