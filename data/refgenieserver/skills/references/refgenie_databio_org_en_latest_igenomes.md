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

+ [Use refgenie with iGenomes](./)

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

# Using refgenie with iGenomes

If you're already using iGenomes, it's easy to configure `refgenie` to use your existing folder structure. [iGenomes](https://support.illumina.com/sequencing/sequencing_software/igenome.html) is project that provides sequences and annotation files for commonly analyzed organisms. Each iGenome is available as a compressed file that contains sequences and annotation files for a single genomic build of an organism.

Initialize a refgenie config file if you don't have one you want to use for your iGenomes assets:

```
export REFGENIE='igenome_config.yaml'
refgenie init -c $REFGENIE
```

And then you have two options:

## Option 1: `import_igenome` (recommended)

This command line tool is distributed with `refgenie` and is ready to use after installing `refgenie`. It adds all the assets enclosed in the genome archive downloaded from the iGenomes website to the `refgenie` local asset inventory. The required inputs are:

* `-g`: name of the genome that should be assigned to the assets,
* `-p`: a path to the downloaded archive or a directory (unarchived iGenomes folder).

usage:

```
$ import_igenome -h

usage: import_igenome [-h] -p PATH -g GENOME [-c CONFIG]

Integrates every asset from the downloaded iGenomes tarball/directory with
Refgenie asset management system

optional arguments:
  -h, --help            show this help message and exit
  -p PATH, --path PATH  path to the desired genome tarball or directory to
                        integrate
  -g GENOME, --genome GENOME
                        name to be assigned to the selected genome
  -c CONFIG, --config CONFIG
                        path to local genome configuration file. Optional if
                        'REFGENIE' environment variable is set.
```

Example:

```
$ import_igenome -g staph -p Staphylococcus_aureus_NCTC_8325_NCBI_2006-02-13.tar.gz

Extracting 'Staphylococcus_aureus_NCTC_8325_NCBI_2006-02-13.tar.gz'
Moved 'Staphylococcus_aureus_NCTC_8325_NCBI_2006-02-13.tar.gz' to '/Users/mstolarczyk/Desktop/testing/test_genomes/staph'
Added assets:
- staph/Chromosomes
- staph/BWAIndex
- staph/BowtieIndex
- staph/AbundantSequences
- staph/Bowtie2Index
- staph/WholeGenomeFasta
```

## Option 2: `refgenie add`

You can also add individual assets you want `refgenie` to track with `refgenie add`. This way of iGenomes integration with `refgenie` is useful if you do not plan to add all of the assets for the downloaded iGenome. It is also useful beyond iGenomes, since you can technically add whatever assets you want, from whatever sources, into your refgenie.

```
refgenie add genome/asset -p RELATIVE_PATH
```

So, after downloading an archive from iGenomes website:

```
tar -xf Staphylococcus_aureus_NCTC_8325_NCBI_2006-02-13.tar.gz
refgenie add staph/bowtie2_index \
  -p Staphylococcus_aureus_NCTC_8325/NCBI/2006-02-13/Sequence/Bowtie2Index
```

Now we can `seek` any added assets:

```
refgenie seek staph/BWAIndex
```

Or `remove` unwanted/faulty ones:

```
refgenie remove staph/BWAIndex
```

This way you can configure `refgenie` to use your iGenomes assets, so you can wean yourself off of the iGenomes hard structure and transition to the refgenie-managed path system.

* [Previous](../remote/)
* [Next](../config_upgrade_03_to_04/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/igenomes.md)

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