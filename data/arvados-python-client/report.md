# arvados-python-client CWL Generation Report

## arvados-python-client

### Tool Description
The provided text is a log of a failed container build process (Apptainer/Singularity) and does not contain help text, usage instructions, or argument definitions for the arvados-python-client tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/curoverse/arvados/tree/main/sdk/python
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Total Downloads**: 218.2K
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/curoverse/arvados
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
FATAL:   Unable to handle docker://quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0 uri: while building SIF from layers: while creating squashfs: /usr/libexec/apptainer/bin/mksquashfs command failed: exit status 1: Write failed because No space left on device
FATAL ERROR: Failed to write to output filesystem
```


## Metadata
- **Skill**: generated

## arvados-python-client_arv-put

### Tool Description
Copy data from the local filesystem to Keep.

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/curoverse/arvados/tree/main/sdk/python
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Validation**: PASS
### Original Help Text
```text
usage: arv-put [-h] [--version] [--normalize | --dry-run] [--as-stream |
               --stream | --as-manifest | --in-manifest | --manifest |
               --as-raw | --raw] [--update-collection UUID]
               [--use-filename FILENAME] [--filename FILENAME]
               [--portable-data-hash] [--replication N]
               [--storage-classes STORAGE_CLASSES] [--threads N]
               [--exclude PATTERN] [--follow-links | --no-follow-links]
               [--trash-at YYYY-MM-DDTHH:MM | --trash-after DAYS]
               [--project-uuid UUID] [--name NAME] [--progress |
               --no-progress | --batch-progress] [--silent] [--batch]
               [--resume | --no-resume] [--cache | --no-cache]
               [--retries RETRIES]
               [path ...]

Copy data from the local filesystem to Keep.

positional arguments:
  path                  Local file or directory. If path is a directory
                        reference with a trailing slash, then just upload the
                        directory's contents; otherwise upload the directory
                        itself. Default: read from standard input.

options:
  -h, --help            show this help message and exit
  --version             Print version and exit.
  --normalize           Normalize the manifest by re-ordering files and
                        streams after writing data.
  --dry-run             Don't actually upload files, but only check if any
                        file should be uploaded. Exit with code=2 when files
                        are pending for upload.
  --as-stream           Synonym for --stream.
  --stream              Store the file content and display the resulting
                        manifest on stdout. Do not save a Collection object in
                        Arvados.
  --as-manifest         Synonym for --manifest.
  --in-manifest         Synonym for --manifest.
  --manifest            Store the file data and resulting manifest in Keep,
                        save a Collection object in Arvados, and display the
                        manifest locator (Collection uuid) on stdout. This is
                        the default behavior.
  --as-raw              Synonym for --raw.
  --raw                 Store the file content and display the data block
                        locators on stdout, separated by commas, with a
                        trailing newline. Do not store a manifest.
  --update-collection UUID
                        Update an existing collection identified by the given
                        Arvados collection UUID. All new local files will be
                        uploaded.
  --use-filename FILENAME
                        Synonym for --filename.
  --filename FILENAME   Use the given filename in the manifest, instead of the
                        name of the local file. This is useful when "-" or
                        "/dev/stdin" is given as an input file. It can be used
                        only if there is exactly one path given and it is not
                        a directory. Implies --manifest.
  --portable-data-hash  Print the portable data hash instead of the Arvados
                        UUID for the collection created by the upload.
  --replication N       Set the replication level for the new collection: how
                        many different physical storage devices (e.g., disks)
                        should have a copy of each data block. Default is to
                        use the server-provided default (if any) or 2.
  --storage-classes STORAGE_CLASSES
                        Specify comma separated list of storage classes to be
                        used when saving data to Keep.
  --threads N           Set the number of upload threads to be used. Take into
                        account that using lots of threads will increase the
                        RAM requirements. Default is to use 2 threads. On high
                        latency installations, using a greater number will
                        improve overall throughput.
  --exclude PATTERN     Exclude files and directories whose names match the
                        given glob pattern. When using a path-like pattern
                        like 'subdir/*.txt', all text files inside 'subdir'
                        directory, relative to the provided input dirs will be
                        excluded. When using a filename pattern like '*.txt',
                        any text file will be excluded no matter where it is
                        placed. For the special case of needing to exclude
                        only files or dirs directly below the given input
                        directory, you can use a pattern like
                        './exclude_this.gif'. You can specify multiple
                        patterns by using this argument more than once.
  --follow-links        Follow file and directory symlinks (default).
  --no-follow-links     Ignore file and directory symlinks. Even paths given
                        explicitly on the command line will be skipped if they
                        are symlinks.
  --trash-at YYYY-MM-DDTHH:MM
                        Set the trash date of the resulting collection to an
                        absolute date in the future. The accepted format is
                        defined by the ISO 8601 standard. Examples: 20090103,
                        2009-01-03, 20090103T181505, 2009-01-03T18:15:05.
                        Timezone information can be added. If not, the
                        provided date/time is assumed as being in the local
                        system's timezone.
  --trash-after DAYS    Set the trash date of the resulting collection to an
                        amount of days from the date/time that the upload
                        process finishes.
  --project-uuid UUID   Store the collection in the specified project, instead
                        of your Home project.
  --name NAME           Save the collection with the specified name.
  --progress            Display human-readable progress on stderr (bytes and,
                        if possible, percentage of total data size). This is
                        the default behavior when stderr is a tty.
  --no-progress         Do not display human-readable progress on stderr, even
                        if stderr is a tty.
  --batch-progress      Display machine-readable progress on stderr (bytes
                        and, if known, total data size).
  --silent              Do not print any debug messages to console. (Any error
                        messages will still be displayed.)
  --batch               Retries with '--no-resume --no-cache' if cached state
                        contains invalid/expired block signatures.
  --resume              Continue interrupted uploads from cached state
                        (default).
  --no-resume           Do not continue interrupted uploads from cached state.
  --cache               Save upload state in a cache file for resuming
                        (default).
  --no-cache            Do not save upload state in a cache file for resuming.
  --retries RETRIES     Maximum number of times to retry server requests that
                        encounter temporary failures (e.g., server down).
                        Default 10.
```

## arvados-python-client_arv-get

### Tool Description
Copy data from Keep to a local file or pipe.

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/curoverse/arvados/tree/main/sdk/python
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Validation**: PASS
### Original Help Text
```text
usage: arv-get [-h] [--retries RETRIES] [--version] [--progress |
               --no-progress | --batch-progress] [--hash HASH | --md5sum] [-n]
               [-r] [-f | -v | --skip-existing | --strip-manifest]
               [--threads N]
               locator [destination]

Copy data from Keep to a local file or pipe.

positional arguments:
  locator            Collection locator, optionally with a file path or
                     prefix.
  destination        Local file or directory where the data is to be written.
                     Default: stdout.

options:
  -h, --help         show this help message and exit
  --retries RETRIES  Maximum number of times to retry server requests that
                     encounter temporary failures (e.g., server down). Default
                     10.
  --version          Print version and exit.
  --progress         Display human-readable progress on stderr (bytes and, if
                     possible, percentage of total data size). This is the
                     default behavior when it is not expected to interfere
                     with the output: specifically, stderr is a tty _and_
                     either stdout is not a tty, or output is being written to
                     named files rather than stdout.
  --no-progress      Do not display human-readable progress on stderr.
  --batch-progress   Display machine-readable progress on stderr (bytes and,
                     if known, total data size).
  --hash HASH        Display the hash of each file as it is read from Keep,
                     using the given hash algorithm. Supported algorithms
                     include md5, sha1, sha224, sha256, sha384, and sha512.
  --md5sum           Display the MD5 hash of each file as it is read from
                     Keep.
  -n                 Do not write any data -- just read from Keep, and report
                     md5sums if requested.
  -r                 Retrieve all files in the specified collection/prefix.
                     This is the default behavior if the "locator" argument
                     ends with a forward slash.
  -f                 Overwrite existing files while writing. The default
                     behavior is to refuse to write *anything* if any of the
                     output files already exist. As a special case, -f is not
                     needed to write to stdout.
  -v                 Once for verbose mode, twice for debug mode.
  --skip-existing    Skip files that already exist. The default behavior is to
                     refuse to write *anything* if any files exist that would
                     have to be overwritten. This option causes even devices,
                     sockets, and fifos to be skipped.
  --strip-manifest   When getting a collection manifest, strip its access
                     tokens before writing it.
  --threads N        Set the number of download threads to be used. Take into
                     account that using lots of threads will increase the RAM
                     requirements. Default is to use 4 threads. On high
                     latency installations, using a greater number will
                     improve overall throughput.
```

## arvados-python-client_arv-keepdocker

### Tool Description
Upload or list Docker images in Arvados

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/curoverse/arvados/tree/main/sdk/python
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Validation**: PASS
### Original Help Text
```text
usage: arv-keepdocker [-h] [--version] [-f] [--force-image-format] [--pull |
                      --no-pull] [--project-uuid UUID] [--name NAME]
                      [--progress | --no-progress | --batch-progress]
                      [--silent] [--batch] [--resume | --no-resume] [--cache |
                      --no-cache] [--retries RETRIES]
                      [image] [tag]

Upload or list Docker images in Arvados

positional arguments:
  image                 Docker image to upload: repo, repo:tag, or hash
  tag                   Tag of the Docker image to upload (default 'latest'),
                        if image is given as an untagged repo name

options:
  -h, --help            show this help message and exit
  --version             Print version and exit.
  -f, --force           Re-upload the image even if it already exists on the
                        server
  --force-image-format  Proceed even if the image format is not supported by
                        the server
  --pull                Try to pull the latest image from Docker registry
  --no-pull             Use locally installed image only, don't pull image
                        from Docker registry (default)
  --project-uuid UUID   Store the collection in the specified project, instead
                        of your Home project.
  --name NAME           Save the collection with the specified name.
  --progress            Display human-readable progress on stderr (bytes and,
                        if possible, percentage of total data size). This is
                        the default behavior when stderr is a tty.
  --no-progress         Do not display human-readable progress on stderr, even
                        if stderr is a tty.
  --batch-progress      Display machine-readable progress on stderr (bytes
                        and, if known, total data size).
  --silent              Do not print any debug messages to console. (Any error
                        messages will still be displayed.)
  --batch               Retries with '--no-resume --no-cache' if cached state
                        contains invalid/expired block signatures.
  --resume              Continue interrupted uploads from cached state
                        (default).
  --no-resume           Do not continue interrupted uploads from cached state.
  --cache               Save upload state in a cache file for resuming
                        (default).
  --no-cache            Do not save upload state in a cache file for resuming.
  --retries RETRIES     Maximum number of times to retry server requests that
                        encounter temporary failures (e.g., server down).
                        Default 10.
```

## arvados-python-client_arv-put

### Tool Description
Copy data from the local filesystem to Keep.

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/curoverse/arvados/tree/main/sdk/python
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Validation**: PASS
### Original Help Text
```text
usage: arv-put [-h] [--version] [--normalize | --dry-run] [--as-stream |
               --stream | --as-manifest | --in-manifest | --manifest |
               --as-raw | --raw] [--update-collection UUID]
               [--use-filename FILENAME] [--filename FILENAME]
               [--portable-data-hash] [--replication N]
               [--storage-classes STORAGE_CLASSES] [--threads N]
               [--exclude PATTERN] [--follow-links | --no-follow-links]
               [--trash-at YYYY-MM-DDTHH:MM | --trash-after DAYS]
               [--project-uuid UUID] [--name NAME] [--progress |
               --no-progress | --batch-progress] [--silent] [--batch]
               [--resume | --no-resume] [--cache | --no-cache]
               [--retries RETRIES]
               [path ...]

Copy data from the local filesystem to Keep.

positional arguments:
  path                  Local file or directory. If path is a directory
                        reference with a trailing slash, then just upload the
                        directory's contents; otherwise upload the directory
                        itself. Default: read from standard input.

options:
  -h, --help            show this help message and exit
  --version             Print version and exit.
  --normalize           Normalize the manifest by re-ordering files and
                        streams after writing data.
  --dry-run             Don't actually upload files, but only check if any
                        file should be uploaded. Exit with code=2 when files
                        are pending for upload.
  --as-stream           Synonym for --stream.
  --stream              Store the file content and display the resulting
                        manifest on stdout. Do not save a Collection object in
                        Arvados.
  --as-manifest         Synonym for --manifest.
  --in-manifest         Synonym for --manifest.
  --manifest            Store the file data and resulting manifest in Keep,
                        save a Collection object in Arvados, and display the
                        manifest locator (Collection uuid) on stdout. This is
                        the default behavior.
  --as-raw              Synonym for --raw.
  --raw                 Store the file content and display the data block
                        locators on stdout, separated by commas, with a
                        trailing newline. Do not store a manifest.
  --update-collection UUID
                        Update an existing collection identified by the given
                        Arvados collection UUID. All new local files will be
                        uploaded.
  --use-filename FILENAME
                        Synonym for --filename.
  --filename FILENAME   Use the given filename in the manifest, instead of the
                        name of the local file. This is useful when "-" or
                        "/dev/stdin" is given as an input file. It can be used
                        only if there is exactly one path given and it is not
                        a directory. Implies --manifest.
  --portable-data-hash  Print the portable data hash instead of the Arvados
                        UUID for the collection created by the upload.
  --replication N       Set the replication level for the new collection: how
                        many different physical storage devices (e.g., disks)
                        should have a copy of each data block. Default is to
                        use the server-provided default (if any) or 2.
  --storage-classes STORAGE_CLASSES
                        Specify comma separated list of storage classes to be
                        used when saving data to Keep.
  --threads N           Set the number of upload threads to be used. Take into
                        account that using lots of threads will increase the
                        RAM requirements. Default is to use 2 threads. On high
                        latency installations, using a greater number will
                        improve overall throughput.
  --exclude PATTERN     Exclude files and directories whose names match the
                        given glob pattern. When using a path-like pattern
                        like 'subdir/*.txt', all text files inside 'subdir'
                        directory, relative to the provided input dirs will be
                        excluded. When using a filename pattern like '*.txt',
                        any text file will be excluded no matter where it is
                        placed. For the special case of needing to exclude
                        only files or dirs directly below the given input
                        directory, you can use a pattern like
                        './exclude_this.gif'. You can specify multiple
                        patterns by using this argument more than once.
  --follow-links        Follow file and directory symlinks (default).
  --no-follow-links     Ignore file and directory symlinks. Even paths given
                        explicitly on the command line will be skipped if they
                        are symlinks.
  --trash-at YYYY-MM-DDTHH:MM
                        Set the trash date of the resulting collection to an
                        absolute date in the future. The accepted format is
                        defined by the ISO 8601 standard. Examples: 20090103,
                        2009-01-03, 20090103T181505, 2009-01-03T18:15:05.
                        Timezone information can be added. If not, the
                        provided date/time is assumed as being in the local
                        system's timezone.
  --trash-after DAYS    Set the trash date of the resulting collection to an
                        amount of days from the date/time that the upload
                        process finishes.
  --project-uuid UUID   Store the collection in the specified project, instead
                        of your Home project.
  --name NAME           Save the collection with the specified name.
  --progress            Display human-readable progress on stderr (bytes and,
                        if possible, percentage of total data size). This is
                        the default behavior when stderr is a tty.
  --no-progress         Do not display human-readable progress on stderr, even
                        if stderr is a tty.
  --batch-progress      Display machine-readable progress on stderr (bytes
                        and, if known, total data size).
  --silent              Do not print any debug messages to console. (Any error
                        messages will still be displayed.)
  --batch               Retries with '--no-resume --no-cache' if cached state
                        contains invalid/expired block signatures.
  --resume              Continue interrupted uploads from cached state
                        (default).
  --no-resume           Do not continue interrupted uploads from cached state.
  --cache               Save upload state in a cache file for resuming
                        (default).
  --no-cache            Do not save upload state in a cache file for resuming.
  --retries RETRIES     Maximum number of times to retry server requests that
                        encounter temporary failures (e.g., server down).
                        Default 10.
```

## arvados-python-client_arv-get

### Tool Description
Copy data from Keep to a local file or pipe.

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/curoverse/arvados/tree/main/sdk/python
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Validation**: PASS
### Original Help Text
```text
usage: arv-get [-h] [--retries RETRIES] [--version] [--progress |
               --no-progress | --batch-progress] [--hash HASH | --md5sum] [-n]
               [-r] [-f | -v | --skip-existing | --strip-manifest]
               [--threads N]
               locator [destination]

Copy data from Keep to a local file or pipe.

positional arguments:
  locator            Collection locator, optionally with a file path or
                     prefix.
  destination        Local file or directory where the data is to be written.
                     Default: stdout.

options:
  -h, --help         show this help message and exit
  --retries RETRIES  Maximum number of times to retry server requests that
                     encounter temporary failures (e.g., server down). Default
                     10.
  --version          Print version and exit.
  --progress         Display human-readable progress on stderr (bytes and, if
                     possible, percentage of total data size). This is the
                     default behavior when it is not expected to interfere
                     with the output: specifically, stderr is a tty _and_
                     either stdout is not a tty, or output is being written to
                     named files rather than stdout.
  --no-progress      Do not display human-readable progress on stderr.
  --batch-progress   Display machine-readable progress on stderr (bytes and,
                     if known, total data size).
  --hash HASH        Display the hash of each file as it is read from Keep,
                     using the given hash algorithm. Supported algorithms
                     include md5, sha1, sha224, sha256, sha384, and sha512.
  --md5sum           Display the MD5 hash of each file as it is read from
                     Keep.
  -n                 Do not write any data -- just read from Keep, and report
                     md5sums if requested.
  -r                 Retrieve all files in the specified collection/prefix.
                     This is the default behavior if the "locator" argument
                     ends with a forward slash.
  -f                 Overwrite existing files while writing. The default
                     behavior is to refuse to write *anything* if any of the
                     output files already exist. As a special case, -f is not
                     needed to write to stdout.
  -v                 Once for verbose mode, twice for debug mode.
  --skip-existing    Skip files that already exist. The default behavior is to
                     refuse to write *anything* if any files exist that would
                     have to be overwritten. This option causes even devices,
                     sockets, and fifos to be skipped.
  --strip-manifest   When getting a collection manifest, strip its access
                     tokens before writing it.
  --threads N        Set the number of download threads to be used. Take into
                     account that using lots of threads will increase the RAM
                     requirements. Default is to use 4 threads. On high
                     latency installations, using a greater number will
                     improve overall throughput.
```

## arvados-python-client_arv-keepdocker

### Tool Description
Upload or list Docker images in Arvados

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
- **Homepage**: https://github.com/curoverse/arvados/tree/main/sdk/python
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-python-client/overview
- **Validation**: PASS
### Original Help Text
```text
usage: arv-keepdocker [-h] [--version] [-f] [--force-image-format] [--pull |
                      --no-pull] [--project-uuid UUID] [--name NAME]
                      [--progress | --no-progress | --batch-progress]
                      [--silent] [--batch] [--resume | --no-resume] [--cache |
                      --no-cache] [--retries RETRIES]
                      [image] [tag]

Upload or list Docker images in Arvados

positional arguments:
  image                 Docker image to upload: repo, repo:tag, or hash
  tag                   Tag of the Docker image to upload (default 'latest'),
                        if image is given as an untagged repo name

options:
  -h, --help            show this help message and exit
  --version             Print version and exit.
  -f, --force           Re-upload the image even if it already exists on the
                        server
  --force-image-format  Proceed even if the image format is not supported by
                        the server
  --pull                Try to pull the latest image from Docker registry
  --no-pull             Use locally installed image only, don't pull image
                        from Docker registry (default)
  --project-uuid UUID   Store the collection in the specified project, instead
                        of your Home project.
  --name NAME           Save the collection with the specified name.
  --progress            Display human-readable progress on stderr (bytes and,
                        if possible, percentage of total data size). This is
                        the default behavior when stderr is a tty.
  --no-progress         Do not display human-readable progress on stderr, even
                        if stderr is a tty.
  --batch-progress      Display machine-readable progress on stderr (bytes
                        and, if known, total data size).
  --silent              Do not print any debug messages to console. (Any error
                        messages will still be displayed.)
  --batch               Retries with '--no-resume --no-cache' if cached state
                        contains invalid/expired block signatures.
  --resume              Continue interrupted uploads from cached state
                        (default).
  --no-resume           Do not continue interrupted uploads from cached state.
  --cache               Save upload state in a cache file for resuming
                        (default).
  --no-cache            Do not save upload state in a cache file for resuming.
  --retries RETRIES     Maximum number of times to retry server requests that
                        encounter temporary failures (e.g., server down).
                        Default 10.
```

