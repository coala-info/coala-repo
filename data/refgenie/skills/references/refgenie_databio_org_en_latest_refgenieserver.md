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

+ [Run my own asset server](./)

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

# Set up your own refgenie server

## Why

We don't anticipate many people wanting to run their own servers. Typically, you'll only need to run refgenie either from the command-line or via the Python API. These clients can interact with existing refgenie servers to pull down genome assets. But what if you want to build your own server? There are a few use cases where this can make sense.

First, perhaps you want a private, local server running on your internal network. This could speed up access to private refgenie assets across an organization. Or, you may want to make some particular assets available to the community. Building on the refgenie infrastructure will simplify distribution and make it so that your users can download your resource through a familiar interface.

## How

It's pretty simple: the software that runs refgenie server is [available on GitHub](https://github.com/databio/refgenieserver). There, you will find detailed instructions on how to run it yourself. In a nutshell, you'll just run a docker command like this:

```
docker run --rm -d -p 80:80 \
    -v /path/to/genomes_archive:/genomes \
    --name refgenieservercon \
    refgenieserverim refgenieserver serve -c /genomes/genome_config.yaml
```

Mount your archived genomes folder to `/genomes` in the container, and you're essentially good to go.

### References

We have scripted the process of building and archiving the assets to serve with `refgenieserver`. The process usually includes the following steps:

1. Download raw input files for assets (FASTA files, GTF files etc.)
2. Build assets with refgenie build in a local refgenie instance
3. Archive assets with refgenieserver archive
4. Deploy the server (run `refgenieserver serve` on a cluster or locally)

Check out these GitHub repositories for more details and all the required metadata:

* [`refgenie/refgenomes.databio.org`](https://github.com/refgenie/refgenomes.databio.org) (primary refgenie assets server instance)
* [`refgenie/rg.databio.org`](https://github.com/refgenie/rg.databio.org) (development refgenie assets server instace)

* [Previous](../compare/)
* [Next](../refgenconf/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/refgenieserver.md)

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