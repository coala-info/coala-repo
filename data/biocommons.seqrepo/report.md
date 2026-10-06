# biocommons.seqrepo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| biocommons.seqrepo_seqrepo_add_assembly_names | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_export | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_export_aliases | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_fetch_load | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; it also has no /usr/bin/bgzip (htslib) to store sequences, and the database setup calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_init | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_list_local_instances | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_list_remote_instances | Failed | image problem: the image has no rsync, and this subcommand both checks /usr/bin/rsync --version at start and uses rsync to query the remote server dl.biocommons.org. |
| biocommons.seqrepo_seqrepo_load | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; it also has no /usr/bin/bgzip (htslib) to store sequences, and the database setup calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_pull | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; it also needs the remote rsync server dl.biocommons.org (pull downloads a multi-GB repository). |
| biocommons.seqrepo_seqrepo_show_status | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_snapshot | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_update_digests | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_update_latest | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |
| biocommons.seqrepo_seqrepo_upgrade | Failed | image problem: the image has no rsync, and every seqrepo subcommand runs /usr/bin/rsync --version at start and crashes; the database setup also calls getpwuid, which fails for the cwltool user unless --no-match-user is set. |

## biocommons.seqrepo_seqrepo_list_local_instances

### Tool Description
list local seqrepo instances

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo list-local-instances [-h]

options:
  -h, --help  show this help message and exit

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_export_aliases

### Tool Description
export aliases

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo export-aliases [-h] [--instance-name INSTANCE_NAME]
                              [--namespace NAMESPACE]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name
  --namespace NAMESPACE, -n NAMESPACE
                        namespace name (e.g., refseq, NCBI, Ensembl, LRG)

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_update_digests

### Tool Description
update computed digests in place

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo update-digests [-h] [--instance-name INSTANCE_NAME]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name; must be writeable

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_list_remote_instances

### Tool Description
list remote seqrepo instances

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo list-remote-instances [-h]

options:
  -h, --help  show this help message and exit

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_fetch_load

### Tool Description
fetch remote sequences by accession and load them (low-throughput!)

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo fetch-load [-h] [--instance-name INSTANCE_NAME] --namespace
                          NAMESPACE
                          accessions [accessions ...]

positional arguments:
  accessions            accessions (NCBI or Ensembl)

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name; must be writeable (i.e., not a
                        snapshot)
  --namespace NAMESPACE, -n NAMESPACE
                        namespace name (e.g., NCBI, Ensembl, LRG)

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_update_latest

### Tool Description
create symlink `latest` to newest seqrepo instance

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo update-latest [-h]

options:
  -h, --help  show this help message and exit

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_init

### Tool Description
initialize seqrepo directory

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo init [-h] [--instance-name INSTANCE_NAME]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name; must be writeable (i.e., not a
                        snapshot)

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_pull

### Tool Description
pull incremental update from seqrepo mirror

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo pull [-h] [--instance-name INSTANCE_NAME] [--update-latest]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name
  --update-latest, -l   set latest symlink to point to this instance

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_add_assembly_names

### Tool Description
add assembly aliases (from bioutils.assemblies) to existing sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo add-assembly-names [-h] [--instance-name INSTANCE_NAME]
                                  [--partial-load] [--reload-all]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name; must be writeable (i.e., not a
                        snapshot)
  --partial-load, -p    assign assembly aliases even if some sequences are
                        missing
  --reload-all, -r      reload all assemblies, not just missing ones

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_upgrade

### Tool Description
upgrade seqrepo database and directory

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo upgrade [-h] [--instance-name INSTANCE_NAME]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name; must be writeable

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_load

### Tool Description
load a single fasta file

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo load [-h] [--instance-name INSTANCE_NAME] --namespace NAMESPACE
                    fasta_files [fasta_files ...]

positional arguments:
  fasta_files           fasta files to load (compressed okay)

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name; must be writeable (i.e., not a
                        snapshot)
  --namespace NAMESPACE, -n NAMESPACE
                        namespace name (e.g., NCBI, Ensembl, LRG)

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_snapshot

### Tool Description
create a new read-only seqrepo snapshot

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo snapshot [-h] [--instance-name INSTANCE_NAME]
                        [--destination-name DESTINATION_NAME]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name; must be writeable
  --destination-name DESTINATION_NAME, -d DESTINATION_NAME
                        destination directory name (must not already exist)

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_export

### Tool Description
export sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo export [-h] [--instance-name INSTANCE_NAME]
                      [--namespace NAMESPACE]
                      [ALIASES ...]

positional arguments:
  ALIASES               specific aliases to export

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name
  --namespace NAMESPACE, -n NAMESPACE
                        namespace name (e.g., refseq, NCBI, Ensembl, LRG)

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## biocommons.seqrepo_seqrepo_show_status

### Tool Description
show seqrepo status

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Original Help Text
```text
usage: seqrepo show-status [-h] [--instance-name INSTANCE_NAME]

options:
  -h, --help            show this help message and exit
  --instance-name INSTANCE_NAME, -i INSTANCE_NAME
                        instance name

global options (given before the subcommand: seqrepo [global options] <subcommand> ...):
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
```

## Metadata
- **Skill**: generated

