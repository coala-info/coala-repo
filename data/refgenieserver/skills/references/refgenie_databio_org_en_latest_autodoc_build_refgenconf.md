[![](../../img/refgenie_logo_light.svg)](../..)

* [Refgenomes server](../../servers)

* Search
* [Manuscripts](../../manuscripts)
* [GitHub](https://github.com/databio/refgenie/)
* [PyPI](https://pypi.org/project/refgenie)
* [Databio.org](http://databio.org)

* #### Getting Started

+ [Introduction](../..)

+ [Demo videos](../../demo_videos/)

+ [Overview](../../overview/)

+ [Install and configure](../../install/)

+ [Basic tutorial](../../tutorial/)

+ [Citing refgenie](../../manuscripts/)

* #### How-to guides

+ [Refer to assets](../../asset_registry_paths/)

+ [Download pre-built assets](../../pull/)

+ [Build assets](../../build/)

+ [Add custom assets](../../custom_assets/)

+ [Retrieve paths to assets](../../seek/)

+ [Use asset tags](../../tag/)

+ [Use aliases](../../aliases/)

+ [Populate refgenie paths](../../populate/)

+ [Compare genomes](../../compare/)

+ [Run my own asset server](../../refgenieserver/)

+ [Use refgenie from Python](../../refgenconf/)

+ [Use refgenie in your pipeline](../../code_snippets/)

+ [Use refgenie on the cloud](../../remote/)

+ [Use refgenie with iGenomes](../../igenomes/)

+ [Upgrade from config 0.3 to 0.4](../../config_upgrade_03_to_04/)

* #### Reference

+ [Studies using refgenie](../../uses_refgenie/)

+ [Genome configuration file](../../genome_config/)

+ [Glossary](../../glossary/)

+ [Buildable assets](../../available_assets/)

+ [Usage](../../usage/)

+ [Python API](./)

+ [FAQ](../../faq/)

+ [Support](https://github.com/databio/refgenie/issues)

+ [Contributing](../../contributing/)

+ [Changelog](../../changelog/)

# Package `refgenconf` Documentation

## Class `RefGenConf`

A sort of oracle of available reference genome assembly assets

```
def __init__(self, filepath=None, entries=None, writable=False, wait_max=60, skip_read_lock=False, genome_exact=False, schema_source=None)
```

Create the config instance by with a filepath or key-value pairs.

#### Parameters:

* `filepath` (`str`): a path to the YAML file to read
* `entries` (`Iterable[(str, object)] | Mapping[str, object]`): config filepath or collection of key-value pairs
* `writable` (`bool`): whether to create the object with write capabilities
* `wait_max` (`int`): how long to wait for creating an object when thefile that data will be read from is locked
* `skip_read_lock` (`bool`): whether the file should not be locked forreading when object is created in read only mode

#### Raises:

* `refgenconf.MissingConfigDataError`: if a required configurationitem is missing
* `ValueError`: if entries is given as a string and is not a file

```
def add(self, path, genome, asset, tag=None, seek_keys=None, force=False)
```

Add an external asset to the config

#### Parameters:

* `path` (`str`): a path to the asset to add; must exist and be relativeto the genome\_folder
* `genome` (`str`): genome name
* `asset` (`str`): asset name
* `tag` (`str`): tag name
* `seek_keys` (`dict`): seek keys to add
* `force` (`bool`): whether to force existing asset overwrite

```
def alias_dir(self)
```

Path to the genome alias directory

#### Returns:

* `str`: path to the directory where the assets are stored

```
def assets_str(self, offset_text='  ', asset_sep=', ', genome_assets_delim='/ ', genome=None, order=None)
```

Create a block of text representing genome-to-asset mapping.

#### Parameters:

* `offset_text` (`str`): text that begins each line of the textrepresentation that's produced
* `asset_sep` (`str`): the delimiter between names of types of assets,within each genome line
* `genome_assets_delim` (`str`): the delimiter to place betweenreference genome assembly name and its list of asset names
* `genome` (`list[str] | str`): genomes that the assets should be found for
* `order` (`function(str) -> object`): how to key genome IDs and assetnames for sort

#### Returns:

* `str`: text representing genome-to-asset mapping

```
def cfg_remove_assets(self, genome, asset, tag=None, relationships=True)
```

Remove data associated with a specified genome:asset:tag combination. If no tags are specified, the entire asset is removed from the genome.

If no more tags are defined for the selected genome:asset after tag removal,
the parent asset will be removed as well
If no more assets are defined for the selected genome after asset removal,
the parent genome will be removed as well

#### Parameters:

* `genome` (`str`): genome to be removed
* `asset` (`str`): asset package to be removed
* `tag` (`str`): tag to be removed
* `relationships` (`bool`): whether the asset being removed shouldbe removed from its relatives as well

#### Returns:

* `RefGenConf`: updated object

#### Raises:

* `TypeError`: if genome argument type is not a list or str

```
def cfg_tag_asset(self, genome, asset, tag, new_tag, force=False)
```

Retags the asset selected by the tag with the new\_tag. Prompts if default already exists and overrides upon confirmation.

This method does not override the original asset entry in the
RefGenConf object. It creates its copy and tags it with the new\_tag.
Additionally, if the retagged asset has any children their parent will
be retagged as new\_tag that was introduced upon this method execution.

#### Parameters:

* `genome` (`str`): name of a reference genome assembly of interest
* `asset` (`str`): name of particular asset of interest
* `tag` (`str`): name of the tag that identifies the asset of interest
* `new_tag` (`str`): name of particular the new tag
* `force` (`bool`): force any actions that require approval

#### Returns:

* `bool`: a logical indicating whether the tagging was successful

#### Raises:

* `ValueError`: when the original tag is not specified

```
def chk_digest_update_child(self, genome, remote_asset_name, child_name, server_url)
```

Check local asset digest against the remote one and populate children of the asset with the provided asset:tag.

In case the local asset does not exist, the config is populated with the remote
asset digest and children data

#### Parameters:

* `genome` (`str`): name of the genome to check the asset digests for
* `remote_asset_name` (`str`): tag
* `child_name` (`str`): name to be appended to the children of the parent
* `server_url` (`str`): address of the server to query for the digests

#### Raises:

* `RefgenconfError`: if the local digest does not match its remote counterpart

```
def compare(self, genome1, genome2, explain=False)
```

Check genomes compatibility level. Compares Annotated Sequence Digests (ASDs) -- digested sequences and metadata

#### Parameters:

* `genome1` (`str`): name of the first genome to compare
* `genome2` (`str`): name of the first genome to compare
* `explain` (`bool`): whether the returned code explanation shouldbe displayed

#### Returns:

* `int`: compatibility code

```
def data_dir(self)
```

Path to the genome data directory

#### Returns:

* `str`: path to the directory where the assets are stored

```
def file_path(self)
```

Path to the genome configuration file

#### Returns:

* `str`: path to the genome configuration file

```
def filepath(self, genome, asset, tag, ext='.tgz', dir=False)
```

Determine path to a particular asset for a particular genome.

#### Parameters:

* `genome` (`str`): reference genome ID
* `asset` (`str`): asset name
* `tag` (`str`): tag name
* `ext` (`str`): file extension
* `dir` (`bool`): whether to return the enclosing directory instead of the file

#### Returns:

* `str`: path to asset for given genome and asset kind/name

```
def genome_aliases(self)
```

Mapping of human-readable genome identifiers to genome identifiers

#### Returns:

* `dict`: mapping of human-readable genome identifiers to genomeidentifiers

```
def genome_aliases_table(self)
```

Mapping of human-readable genome identifiers to genome identifiers

#### Returns:

* `dict`: mapping of human-readable genome identifiers to genomeidentifiers

```
def genomes_list(self, order=None)
```

Get a list of this configuration's reference genome assembly IDs.

#### Returns:

* `Iterable[str]`: list of this configuration's reference genomeassembly IDs

```
def genomes_str(self, order=None)
```

Get as single string this configuration's reference genome assembly IDs.

#### Parameters:

* `order` (`function(str) -> object`): how to key genome IDs for sort

#### Returns:

* `str`: single string that lists this configuration's knownreference genome assembly IDs

```
def get_asds_path(self, genome)
```

Get path to the Annotated Sequence Digests JSON file for a given genome. Note that the path and/or genome may not exist.

#### Parameters:

* `genome` (`str`): genome name

#### Returns:

* `str`: ASDs path

```
def get_asset_table(self, genomes=None, server_url=None, get_json_url=<function RefGenConf.<lambda> at 0x7f9b4d87ff80>)
```

Get a rich.Table object representing assets available locally

#### Parameters:

* `genomes` (`list[str]`): genomes to restrict the results with
* `server_url` (`str`): server URL to query for the remote genome data
* `get_json_url` (`function(str, str) -> str`): how to build URL fromgenome server URL base, genome, and asset

#### Returns:

* `rich.table.Table`: table of assets available locally

```
def get_default_tag(self, genome, asset, use_existing=True)
```

Determine the asset tag to use as default. The one indicated by the 'default\_tag' key in the asset section is returned. If no 'default\_tag' key is found, by default the first listed tag is returned with a RuntimeWarning. This behavior can be turned off with use\_existing=False

#### Parameters:

* `genome` (`str`): name of a reference genome assembly of interest
* `asset` (`str`): name of the particular asset of interest
* `use_existing` (`bool`): whether the first tag in the config should bereturned in case there is no default tag defined for an asset

#### Returns:

* `str`: name of the tag to use as the default one

```
def get_genome_alias(self, digest, fallback=False, all_aliases=False)
```

Get the human readable alias for a genome digest

#### Parameters:

* `digest` (`str`): digest to find human-readable alias for
* `fallback` (`bool`): whether to return the query digest in caseof failure
* `all_aliases` (`bool`): whether to return all aliases instead of justthe first one

#### Returns:

* `str | list[str]`: human-readable aliases

#### Raises:

* `GenomeConfigFormatError`: if "genome\_digests" section doesnot exist in the config
* `UndefinedAliasError`: if a no alias has been defined for therequested digest

```
def get_genome_alias_digest(self, alias, fallback=False)
```

Get the human readable alias for a genome digest

#### Parameters:

* `alias` (`str`): alias to find digest for
* `fallback` (`bool`): whether to return the query alias in caseof failure and in case it is one of the digests

#### Returns:

* `str`: genome digest

#### Raises:

* `UndefinedAliasError`: if the specified alias has been assigned toany digests

```
def get_genome_attributes(self, genome)
```

Get the dictionary attributes, like checksum, contents, description. Does not return the assets.

#### Parameters:

* `genome` (`str`): genome to get the attributes dict for

#### Returns:

* `Mapping[str, str]`: available genome attributes

```
def get_local_data_str(self, genome=None, order=None)
```

List locally available reference genome IDs and assets by ID.

#### Parameters:

* `genome` (`list[str] | str`): genomes that the assets should be found for
* `order` (`function(str) -> object`): how to key genome IDs and assetnames for sort

#### Returns:

* `str, str`: text reps of locally available genomes and assets

```
def get_remote_data_str(self, genome=None, order=None, get_url=<function RefGenConf.<lambda> at 0x7f9b4d42a680>)
```

List genomes and assets available remotely.

#### Parameters:

* `get_url` (`function(serverUrl, operationId) -> str`): how to determineURL request, given server URL and endpoint operationID
* `genome` (`list[str] | str`): genomes that the assets should be found for
* `order` (`function(str) -> object`): how to key genome IDs and assetnames for sort

#### Returns:

* `str, str`: text reps of remotely available genomes and assets

```
def get_symlink_paths(self, genome, asset=None, tag=None, all_aliases=False)
```

Get path to the alias directory for the selected genome-asset-tag

#### Parameters:

* `genome` (`str`): reference genome ID
* `asset` (`str`): asset name
* `tag` (`str`): tag name
* `all_aliases` (`bool`): whether to return a collection of symboliclinks or just the first one from the alias list

#### Returns:

* `dict`:

```
def getseq(self, genome, locus, as_str=False)
```

Return the sequence found in a selected range and chromosome. Something like the refget protocol.

#### Parameters:

* `genome` (`str`): name of the sequence identifier
* `locus` (`str`): 1-10'
* `as_str` (`bool`): whether to convert the resurned object to stringand return just the sequence

#### Returns:

* `str | pyfaidx.FastaRecord | pyfaidx.Sequence`: selected sequence

```
def id(self, genome, asset, tag=None)
```

Returns the digest for the specified asset. The defined default tag will be used if not provided as an argument

#### Parameters:

* `genome` (`str`): genome identifier
* `asset` (`str`): asset identifier
* `tag` (`str`): tag identifier

#### Returns:

* `str`: asset digest for the tag

```
def initialize_config_file(self, filepath=None)
```

Initialize genome configuration file on disk

#### Parameters:

* `filepath` (`str`): a valid path where the configuration file should be initialized

#### Returns:

* `str`: the filepath the file was initialized at

#### Raises:

* `OSError`: in case the file could not be initialized due to insufficient permissions or pre-existence
* `TypeError`: if no valid filepath cat be determined

```
def initialize_genome(self, fasta_path, alias, fasta_unzipped=False, skip_alias_write=False)
```

Initialize a genome

Create a JSON file with Annotated Sequence Digests (ASDs)
for the FASTA file in the genome directory.

#### Parameters:

* `fasta_path` (`str`): path to a FASTA file to initialize genome with
* `alias` (`str`): alias to set for the genome
* `skip_alias_write` (`bool`): whether to skip writing the alias to the file

#### Returns:

* `str, list[dict[]]`: human-readable name for the genome

```
def is_asset_complete(self, genome, asset, tag)
```

Check whether all required tag attributes are defined in the RefGenConf object. This is the way we determine tag completeness.

#### Parameters:

* `genome` (`str`): genome to be checked
* `asset` (`str`): asset package to be checked
* `tag` (`str`): tag to be checked

#### Returns:

* `bool`: the decision

```
def list(self, genome=None, order=None, include_tags=False)
```

List local assets; map each namespace to a list of available asset names

#### Parameters:

* `order` (`callable(str) -> object`): how to key genome IDs for sort
* `genome` (`list[str] | str`): genomes that the assets should be found for
* `include_tags` (`bool`): whether asset ta