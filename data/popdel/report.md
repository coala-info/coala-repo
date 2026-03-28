# popdel CWL Generation Report

## popdel_profile

### Tool Description
Profile creation from BAM/CRAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
- **Homepage**: https://github.com/kehrlab/PopDel
- **Package**: https://anaconda.org/channels/bioconda/packages/popdel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/popdel/overview
- **Total Downloads**: 88.5K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/kehrlab/PopDel
- **Stars**: N/A
### Original Help Text
```text
PopDel - Profile creation from BAM/CRAM file
============================================

SYNOPSIS
    PopDel [OPTIONS] BAM/CRAM-FILE
    PopDel [OPTIONS] BAM/CRAM-FILE CHROM:BEGIN-END [CHROM:BEGIN-END ...]

DESCRIPTION
    Iterates over (user definied regions of) a BAM or CRAM file in tiling
    windows of 256 bp. For each window, PopDel promotes all read pairs whose
    ends pass the quality checks. PopDel saves their insert size deviation
    form the mean together with their position in '*BAM/CRAM-FILE*.profile',
    together with the insert sizes distribution of each read group. Only
    insert sizes up to a maximum length (option --max-deletion-size) are
    considered.

    -h, --help
          Display the help message.
    --version
          Display version information.
    -H, --fullHelp
          Displays full list of options.

  PopDel profile options:
    -r, --reference REF
          Reference genome version used for the mapping. Not used when using
          custom sampling intervals (option '-i'). One of 'GRCh37', 'GRCh38',
          'hg19', 'hg38' (case-insensitive). Default: GRCh38.
    -d, --max-deletion-size NUM
          Maximum size of deletions. Default: 10000.
    -i, --intervals FILE
          File with genomic intervals for parameter estimation instead of
          default intervals (see README). One closed interval per line,
          formatted as 'CHROM:START-END', 1-based coordinates.
    -mrg, --merge-read-groups
          Merge all read groups of the sample. Only advised if they share the
          same properties!
    -n, --min-read-num NUM
          Minimum number of read pairs for parameter estimation (per read
          group) Default: 50000.
    -o, --out FILE
          Output file name. Default: *BAM/CRAM-FILE*.profile.

VERSION
    Last update: on 2021-03-25
    PopDel version: 1.5.0
    SeqAn version: 2.1.0
```


## popdel_call

### Tool Description
Performs joint-calling of deletions using a list of profile-files previously created using the 'popdel profile' command. The input profiles are either specified directly as arguments or listed in PROFILE-LIST-FILE (one filename per line).

### Metadata
- **Docker Image**: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
- **Homepage**: https://github.com/kehrlab/PopDel
- **Package**: https://anaconda.org/channels/bioconda/packages/popdel/overview
- **Validation**: PASS

### Original Help Text
```text
PopDel - Population-wide deletion calling
=========================================

SYNOPSIS
    PopDel [OPTIONS] ROFILE-LIST-FILE
    PopDel [OPTIONS] PROFILE-FILE1 PROFILE-FILE2 [PROFILE-FILE3 ...]

DESCRIPTION
    Performs joint-calling of deletions using a list of profile-files
    previously created using the 'popdel profile' command. The input profiles
    are either specified directly as arguments or listed in PROFILE-LIST-FILE
    (one filename per line).

    -h, --help
          Display the help message.
    --version
          Display version information.
    -H, --fullHelp
          Displays full list of options.

  PopDel call options:
    -A, --active-coverage-file FILE
          File with lines consisting of "ReadGroup maxCov". If this value is
          reached no more new reads are loaded for this read group until the
          coverage drops again. Further, the sample will be excluded from
          calling in high-coverage windows. A value of 0 disables the filter
          for the read group.
    -a, --active-coverage NUM
          Maximum number of active read pairs (~coverage). This value is taken
          for all read groups that are not listed in 'active-coverage-file'.
          Setting it to 0 disables the filter for all read groups that are not
          specified in 'active-coverage-file'. In range [0..inf]. Default:
          100.
    -d, --max-deletion-size NUM
          Maximum size of deletions. Default: 10000.
    -e, --per-sample-rgid
          Internally modify each read group ID by adding the filename. This
          can be used if read groups across different samples have conflicting
          IDs.
    -l, --min-init-length NUM
          Minimal deletion length at initialization of iteration. Default: 4 *
          standard deviation.
    -m, --min-length NUM
          Minimal deletion length during iteration. Default: 95th percentile
          of min-init-lengths.
    -o, --out FILE
          Output file name. Default: popdel.vcf.
    -r, --region-of-interest REGION
          Genomic region 'chr:start-end' (closed interval, 1-based index).
          Calling is limited to this region. Multiple regions can be defined
          by using the parameter -r multiple times.
    -R, --ROI-file FILE
          File listing one or more regions of interest, one region per line.
          See parameter -r.
    -s, --min-sample-fraction NUM
          Minimum fraction of samples which is required to have enough data in
          the window. In range [0.0..1.0]. Default: 0.1.

VERSION
    Last update: on 2021-03-25
    PopDel version: 1.5.0
    SeqAn version: 2.1.0
```


## popdel_view

### Tool Description
Displays a profile file in human readable format or unzips it.

### Metadata
- **Docker Image**: quay.io/biocontainers/popdel:1.5.0--h6b13edd_1
- **Homepage**: https://github.com/kehrlab/PopDel
- **Package**: https://anaconda.org/channels/bioconda/packages/popdel/overview
- **Validation**: PASS

### Original Help Text
```text
PopDel - viewing and converting of a popdel profile file
========================================================

SYNOPSIS
    PopDel PROFILE-FILE

DESCRIPTION
    Displays a profile file in human readable format or unzips it.

    -h, --help
          Display the help message.
    --version
          Display version information.
    -H, --fullHelp
          Displays full list of options.
    -e, --header
          Write the header.
    -E, --onlyHeader
          Only write the header.
    -i, --histograms
          Write insert size histograms.
    -o, --out FILE
          Output file name for the unzipped profile.
    -r, --region CHR:BEGIN-END
          Limit view to this genomic region.

VERSION
    Last update: on 2021-03-25
    PopDel version: 1.5.0
    SeqAn version: 2.1.0
```


## Metadata
- **Skill**: generated
