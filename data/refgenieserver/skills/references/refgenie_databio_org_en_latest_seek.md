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

+ [Retrieve paths to assets](./)

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

# Retrieve paths to *local* assets

Once you've assembled a few assets, either by downloading or by building them, you'll be able to use `refgenie seek` to retrieve the paths. It's quite simple, really -- say you've built the `bowtie2_index` and `fasta` assets for `hg38`. If you type:

```
refgenie seek hg38/bowtie2_index
```

You'll get back the absolute path on your system to the `bowtie2_index` asset, something like:

```
/path/to/genomes_folder/hg38/bowtie2_index
```

## Seek keys

Refgenie `seek` uses a concept called *seek keys*. Let's formally define how these differ from an asset:

* **asset**: a folder consisting of one or more files related to a specific reference genome
* **seek key**: a string identifier for a particular file or folder contained within an asset that can be located with `refgenie seek`.

As asset can have multiple seek keys. When an asset recipe is defined, the author records which files in the asset are potentially interesting for a user to retrieve a path to. These files are added to the recipe as seek keys.

Many assets have only a single seek key, because the asset really only consists of a single thing. For example, a bowtie2\_index asset has only 1 thing you'd need to *seek* to: the folder containing the indexes. But other assets can have multiple seek keys. For example, the `fasta` asset provides not only a fasta file, but a `.fai` fasta index as well as a *chrom\_sizes* file that is required by some tools (notably, ucsc tools). These files are really tightly coupled with a particular fasta file and it doesn't make sense to make separate assets for each of them, and this is where seek keys come in.

Once you have built a `fasta` asset, you'll be able to retrieve not just the fasta file, but also the `fai`, and `chrom_sizes` files. These will show up when you type `refgenie list` as `fasta.fai` and `fasta.chrom_sizes` seek keys.

## Seek keys make things portable

Why is this useful? Instead of writing your shell script to take a path to each the `chrom_sizes` file and the `bowtie2_index` path, you just take the genome name, and use `refgenie seek` to find the correct path. Not only have you simplified the interface to your analysis, but both the script itself *and your call of it* are now portable.

In other words, you just write:

```
python script.py --genome hg38
```

and then use refgenie to *seek* any assets you need. Previously, you would have done:

```
python script.py --chrom_sizes /local/path/to/hg38/chrom_size \
  --bt2_index /local/path/to/hg38/bowtie2_index
```

This second command obviously differs by computing environment, whereas the first does not.

## Examples

```
GENOME="hg38"

refgenie seek -g $GENOME -a bowtie2_index
refgenie seek -g $GENOME -a fasta.chrom_sizes
refgenie seek -g $GENOME -a fasta
```

or:

```
refgenie seek hg38/bowtie2_index
refgenie seek hg38/fasta.chrom_sizes
refgenie seek hg38/fasta
```

* [Previous](../custom_assets/)
* [Next](../tag/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/seek.md)

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