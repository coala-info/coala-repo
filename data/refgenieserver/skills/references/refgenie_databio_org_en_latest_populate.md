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

+ [Populate refgenie paths](./)

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

# Make configuration files portable with refgenie populate

Use `refgenie populate` to replace registry paths (*e.g.* `refgenie://hg38/fasta`) in text files with asset file paths (*e.g.* `/home/johndoe/genomes/hg38/fasta/default/hg38.fa`). For use in an ephemeral compute environment, the remote version, `refgenie populatr`, will replace your registry path with a URI, like `s3://path/to/asset.xyz` or `http://path/to/asset.xyz`. This powerful feature allows you to write configuration files and scripts with maximum portability for anything you might need to configure with reference genome paths.

# Motivation

Sometimes it is desirable to run a refgenie-unaware workflow and benefit from the refgenie framework. In such cases, we need a pre-processing step to populate some kind of input configuration file for a workflow run. This way, all refgenie awareness is kept outside the workflow, but you can still benefit from managing your reference resources using refgenie. For instance, this is the way [Common Workflow Language](https://www.commonwl.org/) (CWL) works; CWL workflows in best practices require knowledge of all input files before the workflow run begins. So, rather than passing a registry path, which is then resolved by refgenie inside the workflow, it makes more sense to use refgenie to pre-populate the CWL input file with the correct paths.

# Usage examples

Both `populate` and `populater` can populate refgenie registry paths either in a **file** or a **string**.

## String intput

Use a pipe (`|`) to populate an in-line command argument with a local path managed by refgenie:

```
echo 'bowtie2 -x refgenie://hg38/bowtie2_index -U r1.fq -S eg1.sam' | refgenie populate | sh
```

## File input

Example input in `test/config_template.yaml`:

```
config:
  param1: value1
  fasta: "refgenie://hg38/fasta"
  bowtie2_index: "refgenie://hg38/bowtie2_index"
```

To populate a bowtie2 index and FASTA file paths in a YAML configuration file of an arbitrary pipeline call:

```
refgenie populate --file test/config_template.yaml > test/config.yaml
```

Example output in `test/config.yaml`:

```
config:
  param1: value1
  fasta: /home/johndoe/genomes/hg38/fasta/default/hg38.fa
  bowtie2_index: /home/johndoe/genomes/hg38/bowtie2_index/default/hg38
```

# Using the refgenie\_looper\_populate plugin

If you're interested in using refgenie in conjunction with [looper](https://looper.databio.org/), we have a convenient looper plugin to provide refgenie populate capability. Enable the plugin by adding this to your looper pipeline interface file:

```
var_templates:
  refgenie_config: "$REFGENIE"
pre_submit:
  python_functions:
  - refgenconf.looper_refgenie_populate
```

Now, just add sample attributes in your sample take with refgenie registry paths, like `refgenie://hg38/fasta`. You can add these either as sample attributes directly in the sample table, or using a [derived attribute](http://pep.databio.org/en/latest/specification/#sample-modifier-derive). Looper will automatically use refgenie to pre-populate the registry paths into correct local paths before submitting the jobs.

* [Previous](../aliases/)
* [Next](../compare/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/populate.md)

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