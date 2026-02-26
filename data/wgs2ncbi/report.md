# wgs2ncbi CWL Generation Report

## wgs2ncbi_prepare

### Tool Description
prepares whole genome sequencing projects for submission to NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
- **Homepage**: https://github.com/naturalis/wgs2ncbi
- **Package**: https://anaconda.org/channels/bioconda/packages/wgs2ncbi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wgs2ncbi/overview
- **Total Downloads**: 12.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/naturalis/wgs2ncbi
- **Stars**: N/A
### Original Help Text
```text
NAME
    wgs2ncbi - prepares whole genome sequencing projects for submission to
    NCBI

SYNOPSIS
     Usage: wgs2ncbi [action] -conf [config file]

    Typically, you will run the following sequence of commands:

     $ wgs2ncbi prepare -conf config.ini
     $ wgs2ncbi process -conf config.ini
     $ wgs2ncbi convert -conf config.ini
     $ wgs2ncbi prune -conf config.ini
     $ wgs2ncbi trim -conf config.ini
     $ wgs2ncbi compress -conf config.ini

    The "prepare" and "compress" steps will be one time operations, but
    "process", "convert", "trim" and "prune" may be iterative, depending on
    the feedback you will get from NCBI (e.g. about invalid product names,
    unmasked adaptor sequences, and other problematic regions).

DESCRIPTION
    "wgs2ncbi" is a script that helps users prepare submissions of
    annotated, whole genomes to NCBI. It does this by performing a number of
    actions that need to be taken in sequence. Each of these actions need to
    be invoked as a subcommand (i.e. "wgs2ncbi [action]"), which will run
    for a certain amount of time. The actions are documented more fully in
    the module of functions that this script is based on. Links to the
    respective, expanded documentation sections are given below. Here
    follows a brief description of the actions:

  "prepare"
    Prepares the rest of the procedure by expanding the single genome
    annotation file into separate files, one for each contig. See "prepare"
    in Bio::WGS2NCBI.

  "process"
    Processes the genome by writing out feature tables and masking contig
    segments as needed.

  "convert"
    Converts the masked contigs and feature tables into ASN.1 using tbl2asn.

  "prune"
    Based on a validation file from NCBI, makes pruned versions of feature
    tables that omit features within regions identified by NCBI.

  "trim"
    Trims leading and trailing NNNs from sequence files and feature tables.

  "compress"
    Packs the ASN.1 files into a .tar.gz archive for upload to NCBI.
```


## wgs2ncbi_process

### Tool Description
prepares whole genome sequencing projects for submission to NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
- **Homepage**: https://github.com/naturalis/wgs2ncbi
- **Package**: https://anaconda.org/channels/bioconda/packages/wgs2ncbi/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    wgs2ncbi - prepares whole genome sequencing projects for submission to
    NCBI

SYNOPSIS
     Usage: wgs2ncbi [action] -conf [config file]

    Typically, you will run the following sequence of commands:

     $ wgs2ncbi prepare -conf config.ini
     $ wgs2ncbi process -conf config.ini
     $ wgs2ncbi convert -conf config.ini
     $ wgs2ncbi prune -conf config.ini
     $ wgs2ncbi trim -conf config.ini
     $ wgs2ncbi compress -conf config.ini

    The "prepare" and "compress" steps will be one time operations, but
    "process", "convert", "trim" and "prune" may be iterative, depending on
    the feedback you will get from NCBI (e.g. about invalid product names,
    unmasked adaptor sequences, and other problematic regions).

DESCRIPTION
    "wgs2ncbi" is a script that helps users prepare submissions of
    annotated, whole genomes to NCBI. It does this by performing a number of
    actions that need to be taken in sequence. Each of these actions need to
    be invoked as a subcommand (i.e. "wgs2ncbi [action]"), which will run
    for a certain amount of time. The actions are documented more fully in
    the module of functions that this script is based on. Links to the
    respective, expanded documentation sections are given below. Here
    follows a brief description of the actions:

  "prepare"
    Prepares the rest of the procedure by expanding the single genome
    annotation file into separate files, one for each contig. See "prepare"
    in Bio::WGS2NCBI.

  "process"
    Processes the genome by writing out feature tables and masking contig
    segments as needed.

  "convert"
    Converts the masked contigs and feature tables into ASN.1 using tbl2asn.

  "prune"
    Based on a validation file from NCBI, makes pruned versions of feature
    tables that omit features within regions identified by NCBI.

  "trim"
    Trims leading and trailing NNNs from sequence files and feature tables.

  "compress"
    Packs the ASN.1 files into a .tar.gz archive for upload to NCBI.
```


## wgs2ncbi_convert

### Tool Description
prepares whole genome sequencing projects for submission to NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
- **Homepage**: https://github.com/naturalis/wgs2ncbi
- **Package**: https://anaconda.org/channels/bioconda/packages/wgs2ncbi/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    wgs2ncbi - prepares whole genome sequencing projects for submission to
    NCBI

SYNOPSIS
     Usage: wgs2ncbi [action] -conf [config file]

    Typically, you will run the following sequence of commands:

     $ wgs2ncbi prepare -conf config.ini
     $ wgs2ncbi process -conf config.ini
     $ wgs2ncbi convert -conf config.ini
     $ wgs2ncbi prune -conf config.ini
     $ wgs2ncbi trim -conf config.ini
     $ wgs2ncbi compress -conf config.ini

    The "prepare" and "compress" steps will be one time operations, but
    "process", "convert", "trim" and "prune" may be iterative, depending on
    the feedback you will get from NCBI (e.g. about invalid product names,
    unmasked adaptor sequences, and other problematic regions).

DESCRIPTION
    "wgs2ncbi" is a script that helps users prepare submissions of
    annotated, whole genomes to NCBI. It does this by performing a number of
    actions that need to be taken in sequence. Each of these actions need to
    be invoked as a subcommand (i.e. "wgs2ncbi [action]"), which will run
    for a certain amount of time. The actions are documented more fully in
    the module of functions that this script is based on. Links to the
    respective, expanded documentation sections are given below. Here
    follows a brief description of the actions:

  "prepare"
    Prepares the rest of the procedure by expanding the single genome
    annotation file into separate files, one for each contig. See "prepare"
    in Bio::WGS2NCBI.

  "process"
    Processes the genome by writing out feature tables and masking contig
    segments as needed.

  "convert"
    Converts the masked contigs and feature tables into ASN.1 using tbl2asn.

  "prune"
    Based on a validation file from NCBI, makes pruned versions of feature
    tables that omit features within regions identified by NCBI.

  "trim"
    Trims leading and trailing NNNs from sequence files and feature tables.

  "compress"
    Packs the ASN.1 files into a .tar.gz archive for upload to NCBI.
```


## wgs2ncbi_prune

### Tool Description
Based on a validation file from NCBI, makes pruned versions of feature tables that omit features within regions identified by NCBI.

### Metadata
- **Docker Image**: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
- **Homepage**: https://github.com/naturalis/wgs2ncbi
- **Package**: https://anaconda.org/channels/bioconda/packages/wgs2ncbi/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    wgs2ncbi - prepares whole genome sequencing projects for submission to
    NCBI

SYNOPSIS
     Usage: wgs2ncbi [action] -conf [config file]

    Typically, you will run the following sequence of commands:

     $ wgs2ncbi prepare -conf config.ini
     $ wgs2ncbi process -conf config.ini
     $ wgs2ncbi convert -conf config.ini
     $ wgs2ncbi prune -conf config.ini
     $ wgs2ncbi trim -conf config.ini
     $ wgs2ncbi compress -conf config.ini

    The "prepare" and "compress" steps will be one time operations, but
    "process", "convert", "trim" and "prune" may be iterative, depending on
    the feedback you will get from NCBI (e.g. about invalid product names,
    unmasked adaptor sequences, and other problematic regions).

DESCRIPTION
    "wgs2ncbi" is a script that helps users prepare submissions of
    annotated, whole genomes to NCBI. It does this by performing a number of
    actions that need to be taken in sequence. Each of these actions need to
    be invoked as a subcommand (i.e. "wgs2ncbi [action]"), which will run
    for a certain amount of time. The actions are documented more fully in
    the module of functions that this script is based on. Links to the
    respective, expanded documentation sections are given below. Here
    follows a brief description of the actions:

  "prepare"
    Prepares the rest of the procedure by expanding the single genome
    annotation file into separate files, one for each contig. See "prepare"
    in Bio::WGS2NCBI.

  "process"
    Processes the genome by writing out feature tables and masking contig
    segments as needed.

  "convert"
    Converts the masked contigs and feature tables into ASN.1 using tbl2asn.

  "prune"
    Based on a validation file from NCBI, makes pruned versions of feature
    tables that omit features within regions identified by NCBI.

  "trim"
    Trims leading and trailing NNNs from sequence files and feature tables.

  "compress"
    Packs the ASN.1 files into a .tar.gz archive for upload to NCBI.
```


## wgs2ncbi_trim

### Tool Description
prepares whole genome sequencing projects for submission to NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
- **Homepage**: https://github.com/naturalis/wgs2ncbi
- **Package**: https://anaconda.org/channels/bioconda/packages/wgs2ncbi/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    wgs2ncbi - prepares whole genome sequencing projects for submission to
    NCBI

SYNOPSIS
     Usage: wgs2ncbi [action] -conf [config file]

    Typically, you will run the following sequence of commands:

     $ wgs2ncbi prepare -conf config.ini
     $ wgs2ncbi process -conf config.ini
     $ wgs2ncbi convert -conf config.ini
     $ wgs2ncbi prune -conf config.ini
     $ wgs2ncbi trim -conf config.ini
     $ wgs2ncbi compress -conf config.ini

    The "prepare" and "compress" steps will be one time operations, but
    "process", "convert", "trim" and "prune" may be iterative, depending on
    the feedback you will get from NCBI (e.g. about invalid product names,
    unmasked adaptor sequences, and other problematic regions).

DESCRIPTION
    "wgs2ncbi" is a script that helps users prepare submissions of
    annotated, whole genomes to NCBI. It does this by performing a number of
    actions that need to be taken in sequence. Each of these actions need to
    be invoked as a subcommand (i.e. "wgs2ncbi [action]"), which will run
    for a certain amount of time. The actions are documented more fully in
    the module of functions that this script is based on. Links to the
    respective, expanded documentation sections are given below. Here
    follows a brief description of the actions:

  "prepare"
    Prepares the rest of the procedure by expanding the single genome
    annotation file into separate files, one for each contig. See "prepare"
    in Bio::WGS2NCBI.

  "process"
    Processes the genome by writing out feature tables and masking contig
    segments as needed.

  "convert"
    Converts the masked contigs and feature tables into ASN.1 using tbl2asn.

  "prune"
    Based on a validation file from NCBI, makes pruned versions of feature
    tables that omit features within regions identified by NCBI.

  "trim"
    Trims leading and trailing NNNs from sequence files and feature tables.

  "compress"
    Packs the ASN.1 files into a .tar.gz archive for upload to NCBI.
```


## wgs2ncbi_compress

### Tool Description
prepares whole genome sequencing projects for submission to NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/wgs2ncbi:1.1.2--pl526_0
- **Homepage**: https://github.com/naturalis/wgs2ncbi
- **Package**: https://anaconda.org/channels/bioconda/packages/wgs2ncbi/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    wgs2ncbi - prepares whole genome sequencing projects for submission to
    NCBI

SYNOPSIS
     Usage: wgs2ncbi [action] -conf [config file]

    Typically, you will run the following sequence of commands:

     $ wgs2ncbi prepare -conf config.ini
     $ wgs2ncbi process -conf config.ini
     $ wgs2ncbi convert -conf config.ini
     $ wgs2ncbi prune -conf config.ini
     $ wgs2ncbi trim -conf config.ini
     $ wgs2ncbi compress -conf config.ini

    The "prepare" and "compress" steps will be one time operations, but
    "process", "convert", "trim" and "prune" may be iterative, depending on
    the feedback you will get from NCBI (e.g. about invalid product names,
    unmasked adaptor sequences, and other problematic regions).

DESCRIPTION
    "wgs2ncbi" is a script that helps users prepare submissions of
    annotated, whole genomes to NCBI. It does this by performing a number of
    actions that need to be taken in sequence. Each of these actions need to
    be invoked as a subcommand (i.e. "wgs2ncbi [action]"), which will run
    for a certain amount of time. The actions are documented more fully in
    the module of functions that this script is based on. Links to the
    respective, expanded documentation sections are given below. Here
    follows a brief description of the actions:

  "prepare"
    Prepares the rest of the procedure by expanding the single genome
    annotation file into separate files, one for each contig. See "prepare"
    in Bio::WGS2NCBI.

  "process"
    Processes the genome by writing out feature tables and masking contig
    segments as needed.

  "convert"
    Converts the masked contigs and feature tables into ASN.1 using tbl2asn.

  "prune"
    Based on a validation file from NCBI, makes pruned versions of feature
    tables that omit features within regions identified by NCBI.

  "trim"
    Trims leading and trailing NNNs from sequence files and feature tables.

  "compress"
    Packs the ASN.1 files into a .tar.gz archive for upload to NCBI.
```

