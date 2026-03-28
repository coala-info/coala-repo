[![](img/refgenie_logo_light.svg)](.)

* [Refgenomes server](servers)

* Search
* [Manuscripts](manuscripts)
* [GitHub](https://github.com/databio/refgenie/)
* [PyPI](https://pypi.org/project/refgenie)
* [Databio.org](http://databio.org)

* #### Getting Started

+ [Introduction](.)

+ [Demo videos](demo_videos/)

+ [Overview](overview/)

+ [Install and configure](install/)

+ [Basic tutorial](tutorial/)

+ [Citing refgenie](manuscripts/)

* #### How-to guides

+ [Refer to assets](asset_registry_paths/)

+ [Download pre-built assets](pull/)

+ [Build assets](build/)

+ [Add custom assets](custom_assets/)

+ [Retrieve paths to assets](seek/)

+ [Use asset tags](tag/)

+ [Use aliases](aliases/)

+ [Populate refgenie paths](populate/)

+ [Compare genomes](compare/)

+ [Run my own asset server](refgenieserver/)

+ [Use refgenie from Python](refgenconf/)

+ [Use refgenie in your pipeline](code_snippets/)

+ [Use refgenie on the cloud](remote/)

+ [Use refgenie with iGenomes](igenomes/)

+ [Upgrade from config 0.3 to 0.4](config_upgrade_03_to_04/)

* #### Reference

+ [Studies using refgenie](uses_refgenie/)

+ [Genome configuration file](genome_config/)

+ [Glossary](glossary/)

+ [Buildable assets](available_assets/)

+ [Usage](usage/)

+ [Python API](autodoc_build/refgenconf/)

+ [FAQ](faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](contributing/)

+ [Changelog](changelog/)

# ![](img/refgenie_logo.svg) reference genome manager

[![PEP compatible](https://pepkit.github.io/img/PEP-compatible-green.svg)](https://pepkit.github.io)
[![PyPi](https://img.shields.io/pypi/v/refgenie.svg)](https://pypi.org/project/refgenie/)

## What is refgenie?

Refgenie manages storage, access, and transfer of reference genome resources. It provides command-line and Python interfaces to *download* pre-built reference genome "assets", like indexes used by bioinformatics tools. It can also *build* assets for custom genome assemblies. Refgenie provides programmatic access to a standard genome folder structure, so software can swap from one genome to another.

**In a hurry?** Check out the [demo videos](demo_videos/) that present the most relevant refgenie features in 3 minutes!

## What makes refgenie better?

1. **It provides a command-line interface to download individual resources**. Think of it as `GitHub` for reference genomes. You just type `refgenie pull hg38/bwa_index`.
2. **It's scripted**. In case you need resources *not* on the server, such as for a custom genome, you can `build` your own: `refgenie build custom_genome/bowtie2_index`.
3. **It simplifies finding local asset locations**. When you need a path to an asset, you can `seek` it, making your pipelines portable across computing environments: `refgenie seek hg38/salmon_index`.
4. **It provides remote operation mode**, useful for cloud applications. Get a path to an asset file hosted on AWS S3: `refgenie seekr hg38/fasta --remote-class s3`.
5. **It includes a Python API**. For tool developers, you use `rgc = refgenconf.RefGenConf("genomes.yaml")` to get a Python object with paths to any genome asset, *e.g.*, `rgc.seek("hg38", "kallisto_index")`.
6. **It strictly determines genomes compatibility**. Users refer to genomes with arbitrary aliases, like "hg38", but refgenie uses sequence-derived identifiers to verify genome identity with asset servers.

## Quick example

### Install

Refgenie is a Python package package, install from [PyPi](https://pypi.org/project/refgenie/):

```
pip install --user refgenie
```

Or [conda](https://anaconda.org/bioconda/refgenie):

```
conda install refgenie
```

And that's it! If you wish to use refgenie in *remote mode* See [further reading on remote mode in refgenie](remote/).

If you're connected to the Internet, call a test command, e.g.:

```
refgenie seekr hg38/fasta
```

### Initialize to use refgenie locally

Refgenie keeps track of what's available using a configuration file initialized by `refgenie init`:

```
export REFGENIE='genome_config.yaml'
refgenie init -c $REFGENIE
```

### Download indexes and assets for a remote reference genome

Use `refgenie pull` to download pre-built assets from a remote server. View available remote assets with `listr`:

```
refgenie listr
```

Response:

```
                        Remote refgenie assets
                 Server URL: http://refgenomes.databio.org
┏━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ genome              ┃ assets                                       ┃
┡━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┩
│ mouse_chrM2x        │ fasta, bwa_index, bowtie2_index              │
│ hg38                │ fasta, bowtie2_index                         │
│ rCRSd               │ fasta, bowtie2_index                         │
│ human_repeats       │ fasta, hisat2_index, bwa_index               │
└─────────────────────┴──────────────────────────────────────────────┘
```

Next, pull one:

```
refgenie pull rCRSd/bowtie2_index
```

Response:

```
Downloading URL: http://rg.databio.org/v3/assets/archive/94e0d21feb576e6af61cd2a798ad30682ef2428bb7eabbb4/bowtie2_index
94e0d21feb576e6af61cd2a798ad30682ef2428bb7eabbb4/bowtie2_index:default ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 100.0% • 128.0/117.0 KB • 1.8 MB/s • 0:00:00
Download complete: /Users/mstolarczyk/Desktop/testing/refgenie/data/94e0d21feb576e6af61cd2a798ad30682ef2428bb7eabbb4/bowtie2_index/bowtie2_index__default.tgz
Extracting asset tarball: /Users/mstolarczyk/Desktop/testing/refgenie/data/94e0d21feb576e6af61cd2a798ad30682ef2428bb7eabbb4/bowtie2_index/bowtie2_index__default.tgz
Default tag for '94e0d21feb576e6af61cd2a798ad30682ef2428bb7eabbb4/bowtie2_index' set to: default
Created alias directories:
 - /Users/mstolarczyk/Desktop/testing/refgenie/alias/rCRSd/bowtie2_index/default
```

See [further reading on downloading assets](pull/).

### Build your own indexes and assets for a custom reference genome

Refgenie assets are scripted, so if what you need is not available remotely, you can use `build` it locally:

```
refgenie build mygenome/bwa_index
```

See [further reading on building assets](build/).

### Retrieve paths to *local* refgenie-managed assets

Once you've populated your refgenie with a few assets, use `seek` to retrieve their local file paths:

```
refgenie seek mm10/bowtie2_index
```

This will return the path to the particular asset of interest, regardless of your computing environment. This gives you an ultra-portable asset manager! See [further reading on retrieving asset paths](seek/).

### Retrieve paths to *remote* refgenie-managed assets

Use `seekr` (short for "seek remote") to retrieve remote `seek_key` targets:

```
refgenie seekr mm10/fasta.fai
```

This will return the path to the particular remote file of interest, here: FASTA index file, which is a part of `mm10/fasta` asset.

See [further reading on using refgenie in remote mode](remote/).

---

If you want to read more about the motivation behind refgenie and the software engineering that makes refgenie work, proceed next to the [overview](overview/).

* Previous
* [Next](demo_videos/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/README.md)

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