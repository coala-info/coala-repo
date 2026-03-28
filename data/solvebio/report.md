# solvebio CWL Generation Report

## solvebio_login

### Tool Description
Log in to SolveBio

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Total Downloads**: 87.9K
- **Last updated**: 2025-12-17
- **GitHub**: https://github.com/solvebio/solvebio-python
- **Stars**: N/A
### Original Help Text
```text
usage: solvebio login [-h] [--version] [--api-host API_HOST]
                      [--api-key API_KEY] [--access-token ACCESS_TOKEN]
                      [--debug]

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
  --debug               Shows the source of the user credentials
```


## solvebio_logout

### Tool Description
Logs out of the SolveBio CLI.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio logout [-h] [--version] [--api-host API_HOST]
                       [--api-key API_KEY] [--access-token ACCESS_TOKEN]

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
```


## solvebio_whoami

### Tool Description
Show the current user and their permissions.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio whoami [-h] [--version] [--api-host API_HOST]
                       [--api-key API_KEY] [--access-token ACCESS_TOKEN]

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
```


## solvebio_tutorial

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/solvebio", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.14/site-packages/solvebio/cli/main.py", line 541, in main
    return args.func(args)
           ~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.14/site-packages/solvebio/cli/tutorial.py", line 8, in print_tutorial
    pager(open(TUTORIAL, 'rb').read())
    ~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/pydoc.py", line 1673, in pager
    pager(text, title)
    ~~~~~^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/_pyrepl/pager.py", line 124, in plain_pager
    sys.stdout.write(plain(escape_stdout(text)))
                           ~~~~~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.14/_pyrepl/pager.py", line 59, in escape_stdout
    return text.encode(encoding, 'backslashreplace').decode(encoding)
           ^^^^^^^^^^^
AttributeError: 'bytes' object has no attribute 'encode'. Did you mean: 'decode'?
```


## solvebio_shell

### Tool Description
Interactive SolveBio shell

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio shell [-h] [--version] [--api-host API_HOST]
                      [--api-key API_KEY] [--access-token ACCESS_TOKEN]

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
```


## solvebio_import

### Tool Description
Import files into SolveBio datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio import [-h] [--version] [--api-host API_HOST]
                       [--api-key API_KEY] [--access-token ACCESS_TOKEN]
                       [--create-vault] [--create-dataset]
                       [--capacity CAPACITY] [--tag TAG]
                       [--metadata KEY=VALUE]
                       [--metadata-json-file METADATA_JSON_FILE]
                       [--template-id TEMPLATE_ID]
                       [--template-file TEMPLATE_FILE] [--follow]
                       [--commit-mode COMMIT_MODE] [--remote-source]
                       [--dry-run]
                       full_path file [file ...]

positional arguments:
  full_path             The full path to the dataset in the format:
                        "domain:vault:/path/dataset".
  file                  One or more files to import. Can be local files,
                        folders, globs or remote URLs. Pass --remote-source in
                        order to list remote full_paths or path globs on the
                        SolveBio file system.

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
  --create-vault        Create the vault if it doesn't exist
  --create-dataset      Create the dataset if it doesn't exist
  --capacity CAPACITY   Specifies the capacity of the created dataset: small
                        (default, <100M records), medium (<500M), large
                        (>=500M)
  --tag TAG             A tag to be added. Tags are case insensitive strings.
                        Example tags: --tag GRCh38 --tag Tissue --tag
                        "Foundation Medicine"
  --metadata KEY=VALUE  Dataset metadata in the format KEY=VALUE
  --metadata-json-file METADATA_JSON_FILE
                        Metadata key value pairs in JSON format
  --template-id TEMPLATE_ID
                        The template ID used when creating a new dataset (via
                        --create-dataset)
  --template-file TEMPLATE_FILE
                        A local template file to be used when creating a new
                        dataset (via --create-dataset)
  --follow              Follow the import's progress until it completes
  --commit-mode COMMIT_MODE
                        Commit mode to use when importing data. Options are
                        "append" (default), "overwrite","upsert", or "delete"
  --remote-source       File paths are remote globs or full paths on the
                        SolveBio file system.
  --dry-run             Dry run mode will not create any datasets or import
                        any files.
```


## solvebio_create-dataset

### Tool Description
Create a new dataset

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio create-dataset [-h] [--version] [--api-host API_HOST]
                               [--api-key API_KEY]
                               [--access-token ACCESS_TOKEN] [--create-vault]
                               [--template-id TEMPLATE_ID]
                               [--template-file TEMPLATE_FILE]
                               [--capacity CAPACITY] [--tag TAG]
                               [--metadata KEY=VALUE]
                               [--metadata-json-file METADATA_JSON_FILE]
                               [--dry-run]
                               full_path

positional arguments:
  full_path             The full path to the dataset in the format:
                        "domain:vault:/path/dataset". Defaults to your
                        personal vault if no vault is provided. Defaults to
                        the vault root if no path is provided.

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
  --create-vault        Create the vault if it doesn't exist
  --template-id TEMPLATE_ID
                        The template ID used when creating a new dataset (via
                        --create-dataset)
  --template-file TEMPLATE_FILE
                        A local template file to be used when creating a new
                        dataset (via --create-dataset)
  --capacity CAPACITY   Specifies the capacity of the dataset: small (default,
                        <100M records), medium (<500M), large (>=500M)
  --tag TAG             A tag to be added. Tags are case insensitive strings.
                        Example tags: --tag GRCh38 --tag Tissue --tag
                        "Foundation Medicine"
  --metadata KEY=VALUE  Dataset metadata in the format KEY=VALUE
  --metadata-json-file METADATA_JSON_FILE
                        Metadata key value pairs in JSON format
  --dry-run             Dry run mode will not create the dataset
```


## solvebio_upload

### Tool Description
Upload local files or directories to SolveBio.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio upload [-h] [--version] [--api-host API_HOST]
                       [--api-key API_KEY] [--access-token ACCESS_TOKEN]
                       [--full-path FULL_PATH] [--num-processes NUM_PROCESSES]
                       [--create-full-path] [--exclude EXCLUDE] [--dry-run]
                       [--archive-folder ARCHIVE_FOLDER] [--follow-shortcuts]
                       [--max-retries MAX_RETRIES]
                       local_path [local_path ...]

positional arguments:
  local_path            The path to the local file or directory to upload

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
  --full-path FULL_PATH
                        The full path where the files and folders should be
                        created, defaults to the root of your personal vault
  --num-processes NUM_PROCESSES
                        Number of uploads to process in parallel. Defaults to
                        1, but can be set much higher than CPU count since the
                        upload process is IO bound, not CPU bound.
  --create-full-path    Creates --full-path location if it does not exist.
                        NOTE: This will not create new vaults.
  --exclude EXCLUDE     Paths to files or folder to be excluded from upload.
                        Unix shell-style wildcards are supported.
  --dry-run             Dry run mode will not upload any files or create any
                        folders.
  --archive-folder ARCHIVE_FOLDER
                        Path to archive files that already exist. If a folder
                        is supplied, instead of overwriting or creating an
                        incremented filename, the original remote file will be
                        moved to this archive folder with a timestamp.
  --follow-shortcuts    Resolves shortcuts when Uploading.
  --max-retries MAX_RETRIES
                        Maximum number of retries per upload part for
                        multipart uploads. Defaults to 3.
```


## solvebio_ls

### Tool Description
List files and folders in the SolveBio vault

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio ls [-h] [--version] [--api-host API_HOST] [--api-key API_KEY]
                   [--access-token ACCESS_TOKEN] [--recursive]
                   [--follow-shortcuts]
                   full_path

positional arguments:
  full_path             The full path where the files and folders should be
                        listed from, defaults to the root of your personal
                        vault

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
  --recursive           Recursively list the contents of subdirectories.
  --follow-shortcuts    Resolves shortcuts when listing.
```


## solvebio_download

### Tool Description
Downloads files from SolveBio.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio download [-h] [--version] [--api-host API_HOST]
                         [--api-key API_KEY] [--access-token ACCESS_TOKEN]
                         [--dry-run] [--recursive] [--exclude EXCLUDE]
                         [--include INCLUDE] [--delete] [--follow-shortcuts]
                         [--num-processes NUM_PROCESSES]
                         full_path local_path

positional arguments:
  full_path             The full path to the files on SolveBio. Supports Unix
                        style globs in order to download multiple files. Note:
                        Downloads are not recursive unless --recursive flag is
                        used.
  local_path            The path to the local directory where to download
                        files.

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
  --dry-run             Dry run mode will not download any files or create any
                        folders. Use this mode before using the --delete flag.
  --recursive           Downloads files recursively. Note that empty folders
                        will be ignored.
  --exclude EXCLUDE     Pattern to match against local full paths of files to
                        be excluded from downloading. This pattern is only
                        used when --recursive is used. Unix shell-style
                        wildcards are supported. Exclude patterns will always
                        be superseded by include patterns.
  --include INCLUDE     Pattern to match against full paths of files to be
                        included for downloading. This pattern is only used
                        when --recursive is used. Unix shell-style wildcards
                        are supported. Include patterns will always supersede
                        exclude patterns.
  --delete              Deletes local files not found in remote full path.
                        Warning, this is dangerous and will delete any files
                        found in local path. Do not use a top-level local path
                        such as "/" and always use the --dry-run mode to
                        evaluate any changes. Empty folders will be deleted.
  --follow-shortcuts    Resolves shortcuts when downloading. If a shortcut to
                        a file is found the target file will be downloaded
                        under the shortcut name.
  --num-processes NUM_PROCESSES
                        Number of downloads to process in parallel. If not
                        specified downloads won't be executed in parallel.If a
                        number less than 1 is set defaults to the number of
                        system CPUs.
```


## solvebio_tag

### Tool Description
Apply tag updates to files, folders, or datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: solvebio tag [-h] [--version] [--api-host API_HOST] [--api-key API_KEY]
                    [--access-token ACCESS_TOKEN] --tag TAG [--remove]
                    [--exclude EXCLUDE] [--tag-folders-only]
                    [--tag-files-only] [--tag-datasets-only] [--dry-run]
                    [--no-input]
                    full_path [full_path ...]

positional arguments:
  full_path             The full path of the files, folders or datasets to
                        apply the tag updates. Unix shell-style wildcards are
                        supported.

SolveBio Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --api-host API_HOST   Override the default SolveBio API host
  --api-key API_KEY     Manually provide a SolveBio API key
  --access-token ACCESS_TOKEN
                        Manually provide a SolveBio OAuth2 access token
  --tag TAG             A tag to be added/removed. Files, folders and datasets
                        can be tagged. Tags are case insensitive strings.
                        Example tags: --tag GRCh38 --tag Tissue --tag
                        "Foundation Medicine"
  --remove              Will remove tags instead of adding them.
  --exclude EXCLUDE     Paths to files or folder to be excluded from tagging.
                        Unix shell-style wildcards are supported.
  --tag-folders-only    Will only apply tags to folders (tags all objects by
                        default).
  --tag-files-only      Will only apply tags to files (tags all objects by
                        default).
  --tag-datasets-only   Will only apply tags to datasets (tags all objects by
                        default).
  --dry-run             Dry run mode will not save tags.
  --no-input            Automatically accept changes (overrides user prompt)
```


## solvebio_queue

### Tool Description
Show the status of tasks in the queue.

### Metadata
- **Docker Image**: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
- **Homepage**: https://github.com/solvebio/solvebio-python
- **Package**: https://anaconda.org/channels/bioconda/packages/solvebio/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/solvebio", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.14/site-packages/solvebio/cli/main.py", line 541, in main
    return args.func(args)
           ~~~~~~~~~^^^^^^
  File "/usr/local/lib/python3.14/site-packages/solvebio/cli/data.py", line 1114, in show_queue
    queue()
    ~~~~~^^
  File "/usr/local/lib/python3.14/site-packages/solvebio/cli/data.py", line 1125, in queue
    tasks = Task.all(status=",".join(statuses))
  File "/usr/local/lib/python3.14/site-packages/solvebio/resource/apiresource.py", line 254, in all
    response = _client.get(url, params)
  File "/usr/local/lib/python3.14/site-packages/solvebio/client.py", line 185, in get
    return self.request('GET', url, **kwargs)
           ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.14/site-packages/solvebio/client.py", line 245, in request
    raise SolveError("HTTP request: client is not logged in!")
solvebio.errors.SolveError: HTTP request: client is not logged in!
```


## Metadata
- **Skill**: generated
