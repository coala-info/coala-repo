# bamaddrg CWL Generation Report

## bamaddrg

### Tool Description
Merges the alignments in the supplied BAM files, using the supplied sample names and read groups to specifically add read group (RG) tags to each alignment. The output is uncompressed, and is suitable for input into downstream alignment systems which require RG tag information.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamaddrg:9baba65f88228e55639689a3cea38dd150e6284f--h4dc6686_2
- **Homepage**: https://github.com/ekg/bamaddrg
- **Package**: https://anaconda.org/channels/bioconda/packages/bamaddrg/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamaddrg/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ekg/bamaddrg
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
usage: /usr/local/bin/bamaddrg [-b FILE [-s NAME [-r GROUP]]]

options:
    -h, --help         this dialog
    -b, --bam FILE     use this BAM as input
    -u, --uncompressed write uncompressed BAM output
    -s, --sample NAME  optionally apply this sample name to the preceeding BAM file
    -d, --delete NAME  removes this sample name and all associated RGs from the header
    -c, --clear        removes all RGs which were in the old file
    -r, --read-group GROUP  optionally apply this read group to the preceeding BAM file
    -R, --region REGION  limit alignments to those in this region (chr:start..end)

Merges the alignments in the supplied BAM files, using the supplied sample names
and read groups to specifically add read group (RG) tags to each alignment.  The
output is uncompressed, and is suitable for input into downstream alignment systems
which require RG tag information.

Sample names and read groups may be specified by supplying a sample name or read group
argument after each listed BAM file.

When no sample names are supplied, the names of the BAM files are used as the sample
names and read groups.  When no read groups are supplied, the sample names are used
as read groups.

author: Erik Garrison <erik.garrison@bc.edu>
```


## Metadata
- **Skill**: generated
