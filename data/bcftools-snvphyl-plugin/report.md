# bcftools-snvphyl-plugin CWL Generation Report

## bcftools-snvphyl-plugin_bcftools

### Tool Description
Tools for variant calling and manipulating VCFs and BCFs

### Metadata
- **Docker Image**: quay.io/biocontainers/bcftools-snvphyl-plugin:1.9--h4da6232_0
- **Homepage**: https://github.com/phac-nml/snvphyl-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/bcftools-snvphyl-plugin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcftools-snvphyl-plugin/overview
- **Total Downloads**: 24.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/snvphyl-tools
- **Stars**: N/A
### Original Help Text
```text
Program: bcftools (Tools for variant calling and manipulating VCFs and BCFs)
Version: 1.9 (using htslib 1.9)

Usage:   bcftools [--version|--version-only] [--help] <command> <argument>

Commands:

 -- Indexing
    index        index VCF/BCF files

 -- VCF/BCF manipulation
    annotate     annotate and edit VCF/BCF files
    concat       concatenate VCF/BCF files from the same set of samples
    convert      convert VCF/BCF files to different formats and back
    isec         intersections of VCF/BCF files
    merge        merge VCF/BCF files files from non-overlapping sample sets
    norm         left-align and normalize indels
    plugin       user-defined plugins
    query        transform VCF/BCF into user-defined formats
    reheader     modify VCF/BCF header, change sample names
    sort         sort VCF/BCF file
    view         VCF/BCF conversion, view, subset and filter VCF/BCF files

 -- VCF/BCF analysis
    call         SNP/indel calling
    consensus    create consensus sequence by applying VCF variants
    cnv          HMM CNV calling
    csq          call variation consequences
    filter       filter VCF/BCF files using fixed thresholds
    gtcheck      check sample concordance, detect sample swaps and contamination
    mpileup      multi-way pileup producing genotype likelihoods
    roh          identify runs of autozygosity (HMM)
    stats        produce VCF/BCF stats

 Most commands accept VCF, bgzipped VCF, and BCF with the file type detected
 automatically even when streaming from a pipe. Indexed VCF and BCF will work
 in all situations. Un-indexed VCF and BCF and streams will work in most but
 not all situations.
```

