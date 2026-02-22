# biocommons.seqrepo CWL Generation Report

## biocommons.seqrepo

### Tool Description
FAIL to generate CWL: biocommons.seqrepo not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/biocommons/biocommons.seqrepo
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: biocommons.seqrepo not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: biocommons.seqrepo not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## biocommons.seqrepo_seqrepo

### Tool Description
command line interface to a local SeqRepo repository

### Metadata
- **Docker Image**: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
- **Homepage**: https://github.com/biocommons/biocommons.seqrepo
- **Package**: https://anaconda.org/channels/bioconda/packages/biocommons.seqrepo/overview
- **Validation**: PASS
### Original Help Text
```text
usage: seqrepo [-h] [--dry-run] [--remote-host REMOTE_HOST]
               [--root-directory ROOT_DIRECTORY] [--rsync-exe RSYNC_EXE]
               [--verbose] [--version]
               {add-assembly-names,export,export-aliases,fetch-load,init,list-local-instances,list-remote-instances,load,pull,show-status,snapshot,start-shell,upgrade,update-digests,update-latest}
               ...

command line interface to a local SeqRepo repository

options:
  -h, --help            show this help message and exit
  --dry-run, -n
  --remote-host REMOTE_HOST
                        rsync server host (default: dl.biocommons.org)
  --root-directory ROOT_DIRECTORY, -r ROOT_DIRECTORY
                        seqrepo root directory (SEQREPO_ROOT_DIR) (default:
                        /usr/local/share/seqrepo)
  --rsync-exe RSYNC_EXE
                        path to rsync executable (default: /usr/bin/rsync)
  --verbose, -v         be verbose; multiple accepted (default: 0)
  --version             show program's version number and exit

subcommands:
  {add-assembly-names,export,export-aliases,fetch-load,init,list-local-instances,list-remote-instances,load,pull,show-status,snapshot,start-shell,upgrade,update-digests,update-latest}
    add-assembly-names  add assembly aliases (from bioutils.assemblies) to
                        existing sequences
    export              export sequences
    export-aliases      export aliases
    fetch-load          fetch remote sequences by accession and load them
                        (low-throughput!)
    init                initialize seqrepo directory
    list-local-instances
                        list local seqrepo instances
    list-remote-instances
                        list remote seqrepo instances
    load                load a single fasta file
    pull                pull incremental update from seqrepo mirror
    show-status         show seqrepo status
    snapshot            create a new read-only seqrepo snapshot
    start-shell         start interactive shell with initialized seqrepo
    upgrade             upgrade seqrepo database and directory
    update-digests      update computed digests in place
    update-latest       create symlink `latest` to newest seqrepo instance

seqrepo 0.6.11See https://github.com/biocommons/biocommons.seqrepo for more
information
```

