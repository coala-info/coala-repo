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

+ [Genome configuration file](./)

+ [Glossary](../glossary/)

+ [Buildable assets](../available_assets/)

+ [Usage](../usage/)

+ [Python API](../autodoc_build/refgenconf/)

+ [FAQ](../faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](../contributing/)

+ [Changelog](../changelog/)

# Refgenie genome configuration file

Refgenie will read and write a genome configuration file in yaml format. In general, you shouldn't need to mess with the config file. You create one with `refgenie init -c genome_config.yaml`, then you add assets using either `refgenie pull` or `refgenie build`. You can also add your own custom assets with `refgenie add`, which is explained in [using custom assets](../custom_assets/). Refgenie will use the config file to remember what assets are available and where they are.

## Upgrading the configuration file

Refgenie is under active development and new features are added regularly. This sometimes necessitates changes in the refgenie configuration file format or asset directory structure. Starting with `refgenie v0.10.0` we introduced the `refgenie upgrade` command, which will automatically detect the current configuration file version and will: 1) reformat the configuration file to the new version; and 2) make any necessary changes to the asset directory structure. To reformat the config, run from the command line:

```
refgenie upgrade --target-version 0.4 -c /path/to/old/cfg.yml
```

Or from within Python:

```
from refgenconf import upgrade_config
upgrade_config(target_version="0.4", filepath="/path/to/old/cfg.yml")
```

Below is a CHANGELOG describing all changes introduced in configuration file versions.

## Genome configuration file example

Here's how the config file works, in case you do need to edit some things by hand. Here's an example file which manages fasta and bowtie2\_index assets for hg38 genome. Keep in mind that some of the keys in this config are optional:

```
config_version: 0.4
genome_folder: /path/to/genomes
genome_archive_folder: /path/to/genome_archives
genome_archive_config: /path/to/genome_archive/config.yaml
remote_url_base: http://awspds.refgenie.databio.org/
genome_servers: ['http://refgenomes.databio.org']
genomes:
    511fb1178275e7d529560d53b949dba40815f195623bce8e:
        aliases:
          - hg38
          - human
        assets:
          fasta:
            tags:
              default:
                seek_keys:
                  fasta: 511fb1178275e7d529560d53b949dba40815f195623bce8e.fa
                  fai: 511fb1178275e7d529560d53b949dba40815f195623bce8e.fa.fai
                  chrom_sizes: 511fb1178275e7d529560d53b949dba40815f195623bce8e.chrom.sizes
                asset_parents: []
                asset_path: fasta
                asset_digest: a3c46f201a3ce7831d85cf4a125aa334
                asset_children: ['511fb1178275e7d529560d53b949dba40815f195623bce8e/bowtie2_index:default']
            default_tag: default
          bowtie2_index:
            asset_description: Genome index for bowtie, produced with bowtie-build
            tags:
              default:
                asset_path: bowtie2_index
                seek_keys:
                  bowtie2_index: .
                asset_digest: 0f9217d44264ae2188fcf8e469d2bb38
                asset_parents: ['511fb1178275e7d529560d53b949dba40815f195623bce8e/fasta:default']
            default_tag: default
```

## Details of config attributes

### Required

* **genome\_folder**: Path to parent folder refgenie-managed assets.
* **genome\_servers**: URLs to a refgenieserver instances.
* **genomes**: A list of genomes, each genome has a list of assets. Any relative paths in the asset `path` attributes are considered relative to the genome folder in the config file (or the file itself if not folder path is specified), with the genome name as an intervening path component, e.g. `folder/mm10/indexed_bowtie2`.
* **aliases**: A list of arbitrary strings that can be used to refer to the namespace
* **tags**: A collection of tags defined for the asset
* **default\_tag**: A pointer to the tag that is currently defined as the default one
* **asset\_parents**: A list of assets that were used to build the asset in question
* **asset\_children**: A list of assets that required the asset in question for building
* **seek\_keys**: A mapping of names and paths of the specific files within an asset
* **asset\_path**: A path to the asset folder, relative to the genome config file
* **asset\_digest**: A digest of the asset directory (more precisely, of the file contents within one) used to address the asset provenance issues when the assets are pulled or built.

### Optional (used by refgenieserver)

* **genome\_archive\_folder**: Path to folder where asset archives will be stored.
* **genome\_archive\_folder**: Path to folder file asset archives config will be stored.
* **remote\_url\_base**: Path/URL to prepend to served asset archives, if non-local ones are to be served

For genomes that are managed by `refgenie` (that is, they were built or pulled with `refgenie`), these asset attributes will be automatically populated. You can edit them and refgenie will respect your edits (unless you re-build or re-pull the asset, which will overwrite those fields). You can also add your own assets and `refgenie` won't touch them. For more info, see [using custom assets](../custom_assets/).

# Config file changelog

## [0.4] - Unreleased; refgenie v0.10.0

### Config format changes

* use sequence-derived unique genome identifiers instead of genome names everywhere
* add `aliases` key under each genome section to store the aliases that can be used to refer to the genomes easily

### File tree structure changes

* use sequence-derived unique genome identifiers instead of genome names in every file name and directory name
* move all the contents from the refgenie directory to a new `data` directory
* add an `alias` directory with contents corresponding to the aliases defined in the configuration file. The contents of the child directories are symbolic links to the asset files in the `data` directory

## [0.3] - 2019-10-21; refgenie v0.7.0

### Config format changes

* Added seek keys, tags, asset digests, default tag pointer, asset description.

## [0.2] - 2019-07-11; refgenie v0.5.0

### Config format changes

* Added `config_version` entry
* Added the `assets` level in the config hierarchy.
* We moved the assets down a layer to accommodate other genome-level attributes we intend to use in the future (like a description, checksums, other provenance information). Earlier refgenie config files will need to be updated.

## [0.1] - 2019-05-10; refgenie v0.3.0

* Initial version of the config file with the initial refgenie release.

* [Previous](../uses_refgenie/)
* [Next](../glossary/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/genome_config.md)

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