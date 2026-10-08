# necat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| necat_assemble | PASS | Galaxy test reads give one 12.3 kb contig (N50 12327) for the 13 kb genome. |
| necat_bridge | PASS | Bridged contig bctg00000000 000000F of 12.3 kb, matching the Galaxy expected line and size. |
| necat_config | PASS | Writes the default config file with all 23 keys. |
| necat_correct | PASS | Galaxy test reads (test1.fa): 52 corrected reads, 75 kB, matching the Galaxy expected size (75000 +/- 2000). |

## necat_correct

### Tool Description
correct rawreads

### Metadata
- **Docker Image**: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
- **Homepage**: https://github.com/xiaochuanle/NECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/necat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/necat/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xiaochuanle/NECAT
- **Stars**: N/A
### Original Help Text
```text
Usage: necat.pl correct|assemble|bridge|config cfg_fname
    correct:     correct rawreads
    assemble:    generate contigs
    bridge:      bridge contigs
    config:      generate default config file
```


## necat_assemble

### Tool Description
generate contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
- **Homepage**: https://github.com/xiaochuanle/NECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/necat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: necat.pl correct|assemble|bridge|config cfg_fname
    correct:     correct rawreads
    assemble:    generate contigs
    bridge:      bridge contigs
    config:      generate default config file
```


## necat_bridge

### Tool Description
bridge contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
- **Homepage**: https://github.com/xiaochuanle/NECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/necat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: necat.pl correct|assemble|bridge|config cfg_fname
    correct:     correct rawreads
    assemble:    generate contigs
    bridge:      bridge contigs
    config:      generate default config file
```


## necat_config

### Tool Description
generate default config file

### Metadata
- **Docker Image**: quay.io/biocontainers/necat:0.0.1_update20200803--h5ca1c30_6
- **Homepage**: https://github.com/xiaochuanle/NECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/necat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: necat.pl correct|assemble|bridge|config cfg_fname
    correct:     correct rawreads
    assemble:    generate contigs
    bridge:      bridge contigs
    config:      generate default config file
```


## Metadata
- **Skill**: generated
