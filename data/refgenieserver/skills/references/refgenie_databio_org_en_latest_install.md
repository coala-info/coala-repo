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

+ [Install and configure](./)

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

# Installing refgenie

Install refgenie from [GitHub releases](https://github.com/databio/refgenie/releases) or from PyPI with `pip`:

* `pip install --user refgenie`: install into user space.
* `pip install --user --upgrade refgenie`: update in user space.
* `pip install refgenie`: install into an active virtual environment.
* `pip install --upgrade refgenie`: update in virtual environment.

See if your install worked by calling `refgenie -h` on the command line. If the `refgenie` executable in not in your `$PATH`, append this to your `.bashrc` or `.profile` (or `.bash_profile` on macOS):

```
export PATH=~/.local/bin:$PATH
```

# Initial configuration

If you're using refgenie for the first time you'll need to initialize your ***genome folder*** and configuration file. Just select a folder where you want your genome assets to live, and then try:

```
refgenie init -c genome_folder/genome_config.yaml
```

The `refgenie` commands all require knowing where this genome config file is. You can pass it on the command line all the time (using the `-c` parameter), but this gets old. An alternative is to set up the `$REFGENIE` environment variable like so:

```
export REFGENIE=/path/to/genome_config.yaml
```

Refgenie will automatically use the config file in this environmental variable if it exists. Add this to your `.bashrc` or `.profile` if you want it to persist for future command-line sessions. You can always specify `-c` if you want to override the value in the `$REFGENIE` variable on an ad-hoc basis.

# Listing assets

Now you can use the `refgenie list` command to show local assets (which will be empty at first) or the `listr` command to show available remote assets:

```
refgenie list
refgenie listr
```

# Populate some assets

Next you need to populate your genome folder with a few assets. You can either `pull` existing assets or `build` your own. Refgenie will manage them the same way. As an example, let's pull a bowtie2 index for a small genome, the human mitochondrial genome (it's called `rCRSd`, the "Revised Cambridge Reference Sequence" on our server).

```
refgenie pull rCRSd/bowtie2_index
```

You can also read more about [building refgenie assets](../build/).

# Seeking assets

Use the `refgenie seek` command to get paths to local assets you have already built or pulled. For example, the one we just pulled:

```
refgenie seek rCRSd/bowtie2_index
```

Or, more generally:

```
refgenie seek GENOME/ASSET
```

That's it! Explore the HOW-TO guides in the navigation bar for further details about what you can do with these functions.

# Managing server subscriptions

Refgenie populates the server list with <http://refgenomes.databio.org> by default. In case you want to `pull` assets from other servers, which may serve a different set of assets, refgenie provides a command line access to the `genome_servers` entry in the config file. Current list of server subscriptions is displayed by `refgenie list` command.

## Add new server

Use the `refgenie subscribe` command to add an additional `refgenieserver` instance to the config file:

```
refgenie subscribe -s http://another.refgenomes.server.org
```

This will append the provided argument to the current list of subscriptions. To start a new one, use `-r`/`--reset` flag:

```
refgenie subscribe -s http://new.refgenomes.server.org -r
```

## Remove server

Use the `refgenie unsubscribe` command to remove `refgenieserver` instance from the config file:

```
refgenie unsubscribe -s http://refgenomes.databio.org
```

* [Previous](../overview/)
* [Next](../tutorial/)

---

 [Edit this page on GitHub](https://github.com/databio/refgenie/edit/master/docs/install.md)

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