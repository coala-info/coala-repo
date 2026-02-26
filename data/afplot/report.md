# afplot CWL Generation Report

## afplot_regions

### Tool Description
Create plots for regions of interest for one VCF. Plots will be colored on call type (het/hom_alt/hom_ref). Your VCF file MUST contain an AD column in the FORMAT field, have contig names and lengths in the header, and be indexed with tabix.

### Metadata
- **Docker Image**: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
- **Homepage**: https://github.com/sndrtj/afplot
- **Package**: https://anaconda.org/channels/bioconda/packages/afplot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/afplot/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sndrtj/afplot
- **Stars**: N/A
### Original Help Text
```text
Usage: afplot regions [OPTIONS] COMMAND [ARGS]...

  Create plots for regions of interest for one VCF.

  Plots will be colored on call type (het/hom_alt/hom_ref).

  Your VCF file *MUST* contain an AD column in the FORMAT field. Your VCF
  file *MUST* have contig names and lengths placed in the header. Your VCF
  file *MUST* be indexed with tabix.

Options:
  --help  Show this message and exit.

Commands:
  distance   Region distance plot
  histogram  Region histogram
  scatter    Region scatter plot
```


## afplot_whole-genome

### Tool Description
Create whole-genome plots for one or multiple VCFs. If only one VCF is supplied, plots will be colored on call type (het/hom_ref/hom_alt). If multiple VCF files are supplied, plots will be colored per file/label. Only one sample per VCF file can be plotted.

### Metadata
- **Docker Image**: quay.io/biocontainers/afplot:0.2.1--py36h24bf2e0_1
- **Homepage**: https://github.com/sndrtj/afplot
- **Package**: https://anaconda.org/channels/bioconda/packages/afplot/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: afplot whole-genome [OPTIONS] COMMAND [ARGS]...

  Create whole-genome plots for one or multiple VCFs.

  If only one VCF is supplied, plots will be colored on call type
  (het/hom_ref/hom_alt). If multiple VCF files are supplied, plots will be
  colored per file/label. Only *one* sample per VCF file can be plotted.

  Your VCF file *MUST* contain an AD column in the FORMAT field. Your VCF
  file *MUST* have contig names and lengths placed in the header. Your VCF
  file *MUST* be indexed with tabix.

  VCF files preferably have the same contigs, i.e. they are produced with
  the same reference. If this is not the case, this script will select the
  vcf file with the largest number of contigs.

  You may exclude contigs by supplying a regex pattern to the -e parameter.
  This parameter may be repeated.

Options:
  --help  Show this message and exit.

Commands:
  distance   Whole-genome distance plot
  histogram  Whole-genome histogram
  scatter    Whole-genome scatter plot
```

