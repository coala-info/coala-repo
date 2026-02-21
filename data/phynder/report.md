# phynder CWL Generation Report

## phynder

### Tool Description
Phylogenetic placement of variants into a tree

### Metadata
- **Docker Image**: quay.io/biocontainers/phynder:1.0--h566b1c6_5
- **Homepage**: https://github.com/richarddurbin/phynder
- **Package**: https://anaconda.org/channels/bioconda/packages/phynder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phynder/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-09-19
- **GitHub**: https://github.com/richarddurbin/phynder
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
usage: phynder [options] <newick tree> <vcf for tree>
  -o <output filename>     ONEfile name; default is stdout [-]
  -b                       write binary (can read with ONEview)
  -q <query vcf>           output query assignments
  -p <posterior threshold> print out suboptimal branches and clade [0]
  -B                       output branch positions of tree variants
  -T <thresh>              site likelihood threshold, zero means no threshold [-10.0]
  -ts <transition rate>    [1.3300]
  -tv <transversion rate>  [0.3300]
  -C <calc_mode>           [0] calculation mode
                           calc_mode 0: LL both ends of edge match
                           calc_mode 1: -LL both ends of edge mismatch
  -U                       make tree ultrametric - all leaves equidistant from root
  -v                       verbose - print extra info
  -h                       print this message
```


## Metadata
- **Skill**: generated
