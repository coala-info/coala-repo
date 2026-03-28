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

+ [Build assets](./)

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

# Build assets

* [Introduction](#introduction)
* [What assets can refgenie build?](#what-assets-can-refgenie-build)
* [Recipes require inputs](#recipes-require-inputs)
* [Recipes require software](#recipes-require-software)
  + [Install build software natively](#install-build-software-natively)
  + [Build assets with docker](#build-assets-with-docker)
  + [Build assets with bulker](#build-assets-with-bulker)
* [Versioning the assets](#versioning-the-assets)
* [Build assets concurrently](#build-assets-concurrently)
* [Automatically pull parents of derived assets](#automatically-pull-parents-of-derived-assets)

## Introduction

Once you've [installed refgenie](../install/), you can use `refgenie pull` to [download pre-built assets](../pull/) without installing any additional software. However, you may need to use the `build` function for genomes or assets that are not available on the server. You can build assets for any genome for which you can provide the required inputs.

Building assets is a bit more complicated than pulling them. You'll need to set up 2 things: 1) any *inputs* required by the asset build recipe; 2) Any *software* required by the recipe. Below, we'll walk you through each of these requirements, but first, how can you tell *what* refgenie can build in the first place?

## What assets can refgenie build?

At the moment the building functionality is under rapid development and may change in the future. While refgenie is totally flexible with respect to genome, it is more restricted in terms of what assets it can build. We are planning to allow users to specify their own recipes for arbitrary assets, but at the moment, `refgenie` can only build a handful of assets for which we have already created building recipes. If you type `refgenie list`, you'll get a list of all the assets you can build with refgenie (under *recipes*). You can also browse the [list of available assets](../available_assets/) here. If you need refgenie to manage an asset not in this list, you can either 1) wait for our pending implementation of custom recipes, or 2) [add custom assets](../custom_assets/), which you would build separately and then use refgenie just to manage them as recipes define reasonable defaults, which rarely require changing.

## Recipes require inputs

Each asset requires some inputs, which we classify as *assets*, *files* or *parameters*.

| **input class** | **recipe name** | **command line argument** | **input type** |
| --- | --- | --- | --- |
| assets | `required_assets` | `--assets` | asset registry path |
| files | `required_files` | `--files` | file/dir path |
| parameters | `required_parametes` | `--params` | string |

To view required inputs for an asset, add an `-q` or `--requirements` flag to the `refgenie build` command:

```
$ refgenie build hg38/bowtie2_index -q

'bowtie2_index' recipe requirements:
- assets:
    fasta (fasta asset for genome); default: fasta
```

Notice how 'fasta' appears under `assets` and not under `files` or `params`. This means to build a bowtie2 index, you do *not* provide a fasta file as an *argument*; instead, you *must already have a fasta asset managed by `refgenie`*. One advantage of this is that it allows refgenie to keep a record of how you've built your assets, so refgenie can remember the link between this bowtie2 asset and the fasta asset, which turns out to be very useful for maintaining provenance of your assets. It also makes it easier to build derived assets like this, because you don't actually have to pass any additional arguments to build them.

So, you'll need to build the `fasta` asset for `hg38` genome before building `bowtie2_index`, but once you have that, building this asset is as simple as typing:

```
$ refgenie build hg38/bowtie2_index
```

For many of the built-in recipes, a pre-existing `fasta` asset is the only requirement and refgenie will use the correct one by default. However, if you wish to build an asset with a different asset as an input, refgenie provides full flexibility. For instance, you can use `fasta:other_tag` (non-default tag) or even `hg38_cdna/fasta` (`fasta` asset from a different namespace) by adding `--assets` argument to the `refgenie build` command, like so:

```
$ refgenie build hg38/bowtie2_index --assets fasta=hg38_cdna/fasta
```

This will build a `bowtie2_index` asset in `hg38` namespace but based on a transcriptome `fasta`.

Next, here's an example of an asset that requires an argument, but not a pre-existing asset:

```
$ refgenie build hg38/refgene_anno -q

'refgene_anno' recipe requirements:
- files:
    refgene (gzipped RefGene database annotation file)
```

You'll need to provide this recipe with a `refgene` file, like this:

```
$ refgenie build hg38/refgene_anno --files refgene=REFGENE_FILE.txt.gz
```

You can see the [example build output](../build_output/).

## Recipes require software

If you want to build assets, you'll need to get the software required by the asset you want to build. You have three choices to get that software: you can either install it natively, use a docker image, or use a bulker manifest.

### Install build software natively

`Refgenie` expects to find in your `PATH` any tools needed for building a desired asset. You'll need to follow the instructions for each of these individually. You could find some basic ideas for how to install these programatically in the [dockerfile](https://github.com/databio/refgenie/blob/dev/containers/Dockerfile_refgenie). We discourage this approach because it makes the assets dependent on your particular uncontrolled environment, which is not ideal. As a result, we don't have great documentation for what is required if you want to use this native approach. As we develop a custom asset system, we're planning to revamp this to provide more detailed way to see what requirements are for a specific recipe.

### Build assets with docker

If you don't want to install all the software needed to build all these assets (and I don't blame you), then you can just use `docker`. Each of our recipes knows about a `docker image` that has everything it needs. If you have `docker` installed, you should be able to simply run `refgenie build` with the `-d` flag. For example:

```
refgenie build -d genome/asset ...
```

This tells `refgenie` to execute the building in a `docker container` requested by the particular asset recipe you specify. `Docker` will automatically pull the image it needs when you call this. If you like, you can build the `docker container` yourself like this:

```
git clone https://github.com/databio/refgenie.git
cd refgenie/containers
make refgenie
```

or pull it directly from [dockerhub](https://hub.docker.com/r/databio/refgenie) like this:

```
docker pull databio/refgenie
```

### Build assets with bulker

For an even more seamless integration of containers with `refgenie`, learn about [bulker](http://bulker.io), our multi-container environment manager. Here, you'd just need to do this:

```
pip install bulker

# Next, configure bulker according to your local compute environment

bulker load databio/refgenie:0.7.0
bulker activate databio/refgenie:0.7.0
refgenie build ...
```

Bulker works on both singularity and docker systems. The bulker docs also contain a [more complete tutorial of using bulker and refgenie together](http://bulker.databio.org/en/latest/refgenie_tutorial/).

## Versioning the assets

Refgenie supports tags to facilitate management of multiple "versions" of the same asset. Simply add a `:your_tag_name` appendix to the asset registry path in the `refgenie build` command and the created asset will be tagged:

```
refgenie build hg38/bowtie2_index:my_tag
```

You can also learn more about [tagging refgenie assets](../tag/).

## Build assets concurrently

Starting with refgenie 0.11.1, the assets may be built following the *MapReduce* programming model, whereby the `refgenie build` process is split into two tasks: building assets (*Map* procedure) and gathering asset metadata (*Reduce* procedure). These tasks can be launched with `--map` and `--reduce` flags, respectively.

*Map* procedure builds the assets as usual, but stores the metadata in a separate, newly created genome configuration file. This avoids any conflicts in concurrent asset builds.

*Reduce* procedure finds the genome configuration files produced in the *Map* step, updates the main genome configuration file with their contents and removes them.

```
# run multiple, possibly hundreds of concurrent builds
refgenie build genome/asset --map
refgenie build genome1/asset --map
refgenie build genome1/asset2 --map

# combine built assets metadata in the main config
refgenie build --reduce
```

**Refgenie does not account for assets dependancy.** Therefore, for best results, consider the following order of building assets:

1. `refgenie build --map` all fasta assets to establish genome namespaces
2. Wait until jobs are completed, call `refgenie build --reduce`
3. `refgenie build --map` all other top-level assets, e.g. fasta\_txome, gencode\_gtf
4. Wait until jobs are completed, call `refgenie build --reduce`
5. `refgenie build --map` all derived assets, e.g. bowtie2\_index, bwa\_index
6. Wait until jobs are completed, call `refgenie build --reduce`

Alternatively, the assets can be automatically retrieved from refgenieserver, if they exist.

## Automatically pull parents of *derived assets*

Starting with refgenie 0.11.1, `refgenie build` command can automatically pull the default parent assets if required but not provided. This feature can be toggled on with `--pull-parents` option.

For example you can build a `bowtie2_index` asset right after refgenie initialization, like so:

```
export REFGENIE=refgenie_config.yaml
refgenie init -c $REFGENIE
refgenie build hg38/bowtie2_index --pull-parents
```

The `refgenie build --pull-parents` command will first try to download the default parent for `hg38/bowtie2_index` asset, which is `hg38/fasta`, and build the `hg38/bowtie2_index` asset right after.

In case the default asset parents are not available on any of the servers you have `refgneie subscribe`d to, the build will not start and exit with `1`.

* [Previous](../pull/)
* [Next](../custom_assets/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/build.md)

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