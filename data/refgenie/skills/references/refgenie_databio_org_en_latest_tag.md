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

+ [Use asset tags](./)

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

# Tagging assets

## Why to tag assets?

It is natural in a research environment to use various flavors of the reference genome related resources that may result from different versions of the software used to create them. And this is what inspired the introduction of assets tagging concept in `refgenie`.

Tag can be **any text or number**, so it is well suited to contain software version information or even a concise description, like `0.4.1` or `new_build_strategy`.

## How to tag assets?

Asset tagging is very flexible. You can tag assets when you build them, add or change tags to already built assets, or just not use tags at all if you don't need them.

### Tagging when assets are built

Here we'll demonstrate how you can specify a tag when building an asset:

```
export REFGENIE="genome_config.yaml"
refgenie init -c $REFGENIE
refgenie pull hg38/fasta
refgenie build hg38/bowtie2_index:2.3.5.1
```

or

```
refgenie build hg38/bowtie2_index:2.3.3.1
```

### Tagging already built/pulled assets (re-tagging)

If you already built an asset, you can add a tag to it. Here, we'll add a tag for `most_recent` to our bowtie2 index asset:

```
refgenie tag hg38/bowtie2_index:2.3.5.1 --tag most_recent
```

Now you could retrieve this asset using either of those tags. In other words, *assets can have more than 1 tag*.

### No tagging at all

Importantly, you don't have to care about tags at all if you don't need to because there is a **default** tag for every asset in your assets inventory. Building without specifying a tag will tag the asset as `default`. If you don't specify a tag when trying to retrieve an asset path, it will assume you're looking for the default tagged asset.

```
refgenie build hg38/bwa_index
```

### Default tags

If you pull or build the first asset of a given kind it will become the default one, which `refgenie` will use for any actions when no tag is explicitly specified. For example the

```
refgenie seek hg38/bowtie2_index
```

call would return the path to the asset tagged with `most_recent` since it was the first `bowtie2_index` asset built/pulled for `hg38` genome.

To retrieve the path to any other asset, you need to specify the tag:

```
refgenie seek hg38/bowtie2_index:2.3.3.1
```

### Changing the default tag

If you want to make a tag the default one, use the `-d`/`--default` option in `refgenie tag` command:

```
refgenie tag hg38/bowtie2_index:2.3.3.1 -d
```

* [Previous](../seek/)
* [Next](../aliases/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/tag.md)

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