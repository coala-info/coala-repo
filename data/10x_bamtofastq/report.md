# 10x_bamtofastq CWL Generation Report

## 10x_bamtofastq

### Tool Description
10x Genomics BAM to FASTQ converter. Tool for converting 10x BAMs produced by Cell Ranger or Long Ranger back to FASTQ files that can be used as inputs to re-run analysis. The FASTQs will be emitted into a directory structure that is compatible with the directories created by the 'mkfastq' tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/10x_bamtofastq:1.4.1--h3ab6199_4
- **Homepage**: https://github.com/10XGenomics/bamtofastq
- **Package**: https://anaconda.org/channels/bioconda/packages/10x_bamtofastq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/10x_bamtofastq/overview
- **Total Downloads**: 6.3K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/10XGenomics/bamtofastq
- **Stars**: N/A
### Original Help Text
```text
bamtofastq v1.4.1
10x Genomics BAM to FASTQ converter.

    Tool for converting 10x BAMs produced by Cell Ranger or Long Ranger back to
    FASTQ files that can be used as inputs to re-run analysis. The FASTQ files
    emitted by the tool should contain the same set of sequences that were
    input to the original pipeline run, although the order will not be 
    preserved.  The FASTQs will be emitted into a directory structure that is
    compatible with the directories created by the 'mkfastq' tool.

    10x BAMs produced by Long Ranger v2.1+ and Cell Ranger v1.2+ contain header
    fields that permit automatic conversion to the correct FASTQ sequences.

    Older 10x pipelines require one of the arguments listed below to indicate 
    which pipeline created the BAM.

    NOTE: BAMs created by non-10x pipelines are unlikely to work correctly,
    unless all the relevant tags have been recreated.

    NOTE: BAM produced by the BASIC and ALIGNER pipeline from Long Ranger 2.1.2 and earlier
    are not compatible with bamtofastq

    NOTE: BAM files created by CR < 1.3 do not have @RG headers, so bamtofastq will use the GEM well
    annotations attached to the CB (cell barcode) tag to split data from multiple input libraries.
    Reads without a valid barcode do not carry the CB tag and will be dropped. These reads would 
    not be included in any valid cell.

Usage:
  bamtofastq [options] <bam> <output-path>
  bamtofastq (-h | --help)

Options:

  --nthreads=<n>        Threads to use for reading BAM file [default: 4]
  --locus=<locus>       Optional. Only include read pairs mapping to locus. Use chrom:start-end format.
  --reads-per-fastq=N   Number of reads per FASTQ chunk [default: 50000000]
  --relaxed             Skip unpaired or duplicated reads instead of throwing an error.
  --gemcode             Convert a BAM produced from GemCode data (Longranger 1.0 - 1.3)
  --lr20                Convert a BAM produced by Longranger 2.0
  --cr11                Convert a BAM produced by Cell Ranger 1.0-1.1
  --bx-list=L           Only include BX values listed in text file L. Requires BX-sorted and index BAM file (see Long Ranger support for details).
  --traceback           Print full traceback if an error occurs.
  -h --help             Show this screen.
```


## Metadata
- **Skill**: generated
