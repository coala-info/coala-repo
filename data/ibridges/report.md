# ibridges CWL Generation Report

## ibridges_ls

### Tool Description
List a collection on iRODS.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-11-17
- **GitHub**: https://github.com/iBridges-for-iRODS/iBridges
- **Stars**: N/A
### Original Help Text
```text
usage: ibridges ls [-h] [-m] [-i] [-l] [--nocolor] [remote_coll]

List a collection on iRODS.

positional arguments:
  remote_coll      Path to remote iRODS location starting with 'irods:'.

options:
  -h, --help       show this help message and exit
  -m, --metadata   Show metadata for each iRODS location, only in combination with -i/--icommands.
  -i, --icommands  Display available data objects/collections in iCommands form.
  -l, --long       Display available data objects/collections in long form.
  --nocolor        Disable printing with color.

Examples:

> ibridges ls 
> ibridges ls irods:some_collection
```


## ibridges_pwd

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: ibridges pwd [-h]

Show current working collection.

options:
  -h, --help  show this help message and exit

Examples:

> ibridges pwd
```


## ibridges_tree

### Tool Description
Show collection/directory tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges tree [-h] [--show-max SHOW_MAX] [--ascii] [--depth DEPTH]
                     [remote_coll]

Show collection/directory tree.

positional arguments:
  remote_coll          Path to collection to make a tree of.

options:
  -h, --help           show this help message and exit
  --show-max SHOW_MAX  Show only up to this number of dataobject in the same collection, default 10.
  --ascii              Print the tree in pure ascii.
  --depth DEPTH        Maximum depth of the tree to be shown, default no limit.

Examples:

> ibridges tree 
> ibridges tree irods:some_collection
```


## ibridges_meta-list

### Tool Description
List the metadata of a data object or collection on iRODS.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges meta-list [-h] [remote_path]

List the metadata of a data object or collection on iRODS.

positional arguments:
  remote_path  iRODS path for metadata listing, starting with 'irods:'.

options:
  -h, --help   show this help message and exit

Examples:

> ibridges meta-list 
> ibridges meta-list irods:remote_collection
```


## ibridges_meta-add

### Tool Description
Add a metadata item to a collection or data object.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges meta-add [-h] remote_path key value [units]

Add a metadata item to a collection or data object.

positional arguments:
  remote_path  Path to add a new metadata item to.
  key          Key for the new metadata item.
  value        Value for the new metadata item.
  units        Units for the new metadata item.

options:
  -h, --help   show this help message and exit

Examples:

> ibridges meta-add irods:some_dataobj_or_collection new_key new_value new_units
```


## ibridges_meta-del

### Tool Description
Delete metadata for one collection or data object.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges meta-del [-h] [--key KEY] [--value VALUE] [--units UNITS]
                         [--ignore-blacklist]
                         remote_path

Delete metadata for one collection or data object.

positional arguments:
  remote_path         Path to delete metadata entries from.

options:
  -h, --help          show this help message and exit
  --key KEY           Key for which to delete the entries.
  --value VALUE       Value for which to delete the entries.
  --units UNITS       Units for which to delete the entries.
  --ignore-blacklist  Ignore the metadata blacklist.

Examples:

> ibridges meta-del irods:remote_dataobj_or_coll
> ibridges meta-del irods:remote_dataobj_or_coll --key some_key
> ibridges meta-del irods:some_obj --key some_key --value some_val --units some_units
```


## ibridges_mkcoll

### Tool Description
Create a new collecion with all its parent collections.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges mkcoll [-h] remote_coll

Create a new collecion with all its parent collections.

positional arguments:
  remote_coll  Path to a new collection, should start with 'irods:'.

options:
  -h, --help   show this help message and exit

Examples:

> ibridges mkcoll irods:~/test
```


## ibridges_download

### Tool Description
Download a data object or collection from an iRODS server.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges download [-h] [--overwrite] [--resource RESOURCE] [--dry-run]
                         [--metadata [METADATA]] [--on-error ON_ERROR]
                         remote_path [local_path]

Download a data object or collection from an iRODS server.

positional arguments:
  remote_path           Path to remote iRODS location starting with 'irods:'.
  local_path            Local path to download the data object/collection to.

options:
  -h, --help            show this help message and exit
  --overwrite           Overwrite the local file(s) if it exists.
  --resource RESOURCE   Name of the resource from which the data is to be downloaded.
  --dry-run             Do not perform the download, but list the files to be updated.
  --metadata [METADATA]
                        Path to the metadata file which will be created.
  --on-error ON_ERROR   When a transfer of a file fails, by default the whole transfer will stop and print the error message(fail). By setting 'on-error' to 'warn', those errors will be turned into warnings and the transfer continues with the next file. Setting 'on-error' to 'skip' will omit any message and simply proceed.

Examples:

> ibridges download irods:~/test.txt
> ibridges download irods:~/some_collection
```


## ibridges_upload

### Tool Description
Upload a data object or collection to an iRODS server.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges upload [-h] [--overwrite] [--resource RESOURCE] [--dry-run]
                       [--metadata [METADATA]] [--on-error ON_ERROR]
                       local_path [remote_path]

Upload a data object or collection to an iRODS server.

positional arguments:
  local_path            Local path to upload the data object/collection from.
  remote_path           Path to remote iRODS location starting with 'irods:'.

options:
  -h, --help            show this help message and exit
  --overwrite           Overwrite the remote file(s) if it exists.
  --resource RESOURCE   Name of the resource to which the data is to be uploaded.
  --dry-run             Do not perform the upload, but list the files to be updated.
  --metadata [METADATA]
                        Path to the metadata json.
  --on-error ON_ERROR   When a transfer of a file fails, by default the whole transfer will stop and print the error message(fail). By setting 'on-error' to 'warn', those errors will be turned into warnings and the transfer continues with the next file. Setting 'on-error' to 'skip' will omit any message and simply proceed.

Examples:

> ibridges upload local_file.txt
> ibridges upload local_file.txt irods:remote_collection
> ibridges upload local_dir irods:remote_collection
```


## ibridges_search

### Tool Description
Search for dataobjects and collections.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges search [-h] [--path-pattern PATH_PATTERN]
                       [--checksum CHECKSUM]
                       [--metadata METADATA [METADATA ...]]
                       [--item_type ITEM_TYPE]
                       [remote_path]

Search for dataobjects and collections.

positional arguments:
  remote_path           Remote path to search inn. The path itself will not be matched.

options:
  -h, --help            show this help message and exit
  --path-pattern PATH_PATTERN
                        Pattern of the path constraint. For example, use '%.txt' to find all data objects and collections that end with .txt. You can also use the name of the item here to find all items with that name.
  --checksum CHECKSUM   Checksum of the data objects to be found.
  --metadata METADATA [METADATA ...]
                        Constrain the results using metadata, see examples. Can be used multiple times.
  --item_type ITEM_TYPE
                        Use data_object or collection to show only items of that type. By default all items are returned.

Examples:

> ibridges search --path-pattern "%.txt"
> ibridges search --checksum "sha2:5dfasd%"
> ibridges search --metadata "key" "value" "units"
> ibridges search --metadata "key" --metadata "key2" "value2"
> ibridges search irods:some_collection --item_type data_object
> ibridges search irods:some_collection --item_type collection
```


## ibridges_cd

### Tool Description
Change current working collection for the iRODS server.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges cd [-h] [remote_coll]

Change current working collection for the iRODS server.

positional arguments:
  remote_coll  Path to remote iRODS location.

options:
  -h, --help   show this help message and exit

Examples:

> ibridges cd 
> ibridges cd irods:some_collection
```


## ibridges_rm

### Tool Description
Remove collection or data object.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges rm [-h] [-r] remote_path

Remove collection or data object.

positional arguments:
  remote_path      Collection or data object to remove.

options:
  -h, --help       show this help message and exit
  -r, --recursive  Remove collections and their content recursively.

Examples:

> ibridges rm irods:~/test.txt
> ibridges rm -r irods:~/test_collection
```


## ibridges_sync

### Tool Description
Synchronize files/directories between local and remote.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges sync [-h] [--dry-run] [--metadata [METADATA]]
                     [--on-error ON_ERROR]
                     source destination

Synchronize files/directories between local and remote.

positional arguments:
  source                Source path to synchronize from (collection on irods server or local directory).
  destination           Destination path to synchronize to (collection on irods server or local directory).

options:
  -h, --help            show this help message and exit
  --dry-run             Do not perform the synchronization, but list the files to be updated.
  --metadata [METADATA]
                        Path to the metadata json file.
  --on-error ON_ERROR   When a transfer of a file fails, by default the whole transfer will stop and print the error message(fail). By setting 'on-error' to 'warn', those errors will be turned into warnings and the transfer continues with the next file. Setting 'on-error' to 'skip' will omit any message and simply proceed.

Examples:

> ibridges sync local_dir irods:remote_collection
> ibridges sync irods:remote_collection local_dir
```


## ibridges_gui

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: ibridges gui [-h]

Start the iBridges GUI.

options:
  -h, --help  show this help message and exit

Examples:

> ibridges gui
```


## ibridges_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: ibridges version [-h]

Print the version of iBridges.

options:
  -h, --help  show this help message and exit

Examples:

> ibridges version
```


## ibridges_shell

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/lib/python3.14/site-packages/ibridges/cli/other.py", line 37, in run_command
    IBridgesShell().cmdloop()
    ~~~~~~~~~~~~~^^
  File "/usr/local/lib/python3.14/site-packages/ibridges/cli/shell.py", line 58, in __init__
    self.session = cli_authenticate(None)
                   ~~~~~~~~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.14/site-packages/ibridges/cli/util.py", line 20, in cli_authenticate
    parser.error(f"Error: Irods environment file or alias '{ienv_path}' does not exist.")
    ^^^^^^^^^^^^
AttributeError: 'NoneType' object has no attribute 'error'
```


## ibridges_alias

### Tool Description
Print existing aliases or create new ones.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges alias [-h] [--delete] [alias] [env_path]

Print existing aliases or create new ones.

positional arguments:
  alias         The new alias to be created.
  env_path      iRODS environment path.

options:
  -h, --help    show this help message and exit
  --delete, -d  Delete the alias.

Examples:

> ibridges alias some_alias ~/.irods/irods_environment.json
> ibridges alias other_alias --delete
```


## ibridges_init

### Tool Description
Create a cached password for future use.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges init [-h] [irods_env_path_or_alias]

Create a cached password for future use.

positional arguments:
  irods_env_path_or_alias
                        The path to your iRODS environment JSON file or an alias for an environment.

options:
  -h, --help            show this help message and exit

Examples:

> ibridges init 
> ibridges init ~/.irods/another_env_path.json
> ibridges init some_alias
```


## ibridges_setup

### Tool Description
Use templates to create an iRODS environment json.

### Metadata
- **Docker Image**: quay.io/biocontainers/ibridges:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/iBridges-for-iRODS/iBridges
- **Package**: https://anaconda.org/channels/bioconda/packages/ibridges/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ibridges setup [-h] [--list] [-o OUTPUT] [--overwrite] [server_name]

Use templates to create an iRODS environment json.

positional arguments:
  server_name          Server name to create your irods_environment.json for.

options:
  -h, --help           show this help message and exit
  --list               List all available server names.
  -o, --output OUTPUT  Store the environment to a file.
  --overwrite          Overwrite the irods environment file.

Examples:

> ibridges setup some-servername -o ~/.irods/some_server.json
```

