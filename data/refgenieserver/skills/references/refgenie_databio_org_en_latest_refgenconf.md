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

+ [Use refgenie from Python](./)

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

# Refgenie from within Python

Third-party python tools can rely on our Python object for access to refgenie assets. For this we have a Python package called `refgenconf` which provides a class with methods to access local and remote genome assets.

## Installing

You should already have `refgenconf` if you've installed `refgenie`, but if needed you can also install it separately with some variant of `pip install refgenconf`.

## Quick start

Create a `RefGenConf` object, which is the package's main data type. You just need to give it a refgenie genome configuration file (in YAML format). You can create a template using `refgenie init`.

As a general rule, the CLI functions are available from within Python under the same names, e.g. `refgenie list ...` is available as `RefGenConf.list()` method.

```
import refgenconf
rgc = refgenconf.RefGenConf("genome_config.yaml")
```

Now, you can interact with it:

```
print(rgc)
```

Use this to show all available remote assets:

```
rgc.listr()
```

In a tool, you're probably most interested in using refgenie to locate reference genome assets, for which you want to use the `get_asset` function. For example:

```
# identify genome (perhaps provided by user)
genome = "hg38"

# get the local path to bowtie2 indexes:
bt2idx = rgc.seek(genome, "bowtie2_index")

# run bowtie2...
```

This enables you to write python software that will work on any computing environment without having to worry about passing around brittle environment-specific file paths. See [this tutorial](/refgenconf_usage) for more comprehensive example of how to work with `refgenconf` as a tool developer.

See the complete [refgenconf python API](/autodoc_build/refgenconf) for more details.

* [Previous](../refgenieserver/)
* [Next](../code_snippets/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/refgenconf.md)

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