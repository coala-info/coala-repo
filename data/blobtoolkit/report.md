# blobtoolkit CWL Generation Report

## blobtoolkit_blobtools

### Tool Description
assembly exploration, QC and filtering.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtoolkit:4.5.1--pyhdfd78af_0
- **Homepage**: https://github.com/blobtoolkit/blobtoolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtoolkit/overview
- **Total Downloads**: 641
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/blobtoolkit/blobtoolkit
- **Stars**: N/A
### Original Help Text
```text
BlobTools2 - assembly exploration, QC and filtering.

usage: blobtools [<command>] [<args>...] [-h|--help] [--version]

commands:
    add             add data to a BlobDir
    create          create a new BlobDir
    filter          filter a BlobDir
    host            host interactive view of all BlobDirs in a directory
    replace         call blobtools add with --replace flag
    remove          remove one or more fields from a BlobDir
    validate        validate a BlobDir
    view            generate plots using BlobToolKit Viewer
    -h, --help      show this
    -v, --version   show version number
See 'blobtools <command> --help' for more information on a specific command.

examples:
    # 1. Create a new BlobDir from a FASTA file:
    blobtools create --fasta examples/assembly.fasta BlobDir

    # 2. Create a new BlobDir from a BlobDB:
    blobtools create --blobdb examples/blobDB.json BlobDir

    # 3. Add Coverage data from a BAM file:
    blobtools add --cov examples/assembly.reads.bam BlobDir

    # 4. Assign taxonomy from BLAST hits:
    blobtools add add --hits examples/blast.out --taxdump ../taxdump BlobDir

    # 5. Add BUSCO results:
    blobtools add --busco examples/busco.tsv BlobDir

    # 6. Host an interactive viewer:
    blobtools host BlobDir

    # 7. Filter a BlobDir:
    blobtools filter --param length--Min=5000 --output BlobDir_len_gt_5000 BlobDir
```

