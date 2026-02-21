# bamutil CWL Generation Report

## bamutil

### Tool Description
FAIL to generate CWL: bamutil not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Total Downloads**: 52.9K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: bamutil not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: bamutil not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## bamutil_bam

### Tool Description
Set of tools for operating on SAM/BAM files, including rewriting, modifying, and informational utilities.

### Metadata
- **Docker Image**: quay.io/biocontainers/bamutil:1.0.15--h5b5514e_2
- **Homepage**: http://genome.sph.umich.edu/wiki/BamUtil
- **Package**: https://anaconda.org/channels/bioconda/packages/bamutil/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Error: Invalid command.

Set of tools for operating on SAM/BAM files.
Version: 1.0.15; Built: Wed Feb 23 00:18:05 UTC 2022 by conda

Usage: 
bam <tool> [<tool arguments>]
bam (usage|help) - Will print usage and exit.
bam (usage|help) <tool> - Will print usage for specific tool and exit.

Tools to Rewrite SAM/BAM Files: 
 convert - Convert SAM/BAM to SAM/BAM
 writeRegion - Write a file with reads in the specified region and/or have the specified read name
 splitChromosome - Split BAM by Chromosome
 splitBam - Split a BAM file into multiple BAM files based on ReadGroup
 findCigars - Output just the reads that contain any of the specified CIGAR operations.

Tools to Modify & write SAM/BAM Files: 
 clipOverlap - Clip overlapping read pairs in a SAM/BAM File already sorted by Coordinate or ReadName
 filter - Filter reads by clipping ends with too high of a mismatch percentage and by marking reads unmapped if the quality of mismatches is too high
 revert - Revert SAM/BAM replacing the specified fields with their previous values (if known) and removes specified tags
 squeeze -  reduces files size by dropping OQ fields, duplicates, & specified tags, using '=' when a base matches the reference, binning quality scores, and replacing readNames with unique integers
 trimBam - Trim the ends of reads in a SAM/BAM file changing read ends to 'N' and quality to '!' or softclipping the ends (resulting file will not be sorted)
 mergeBam - merge multiple BAMs and headers appending ReadGroupIDs if necessary
 polishBam - adds/updates header lines & adds the RG tag to each record
 dedup - Mark Duplicates
 dedup_LowMem - Mark Duplicates using only a little memory
 recab - Recalibrate

Informational Tools
 validate - Validate a SAM/BAM File
 diff - Diff 2 coordinate sorted SAM/BAM files.
 stats - Stats a SAM/BAM File
 gapInfo - Print information on the gap between read pairs in a SAM/BAM File.

Tools to Print Information In Readable Format
 dumpHeader - Print SAM/BAM Header
 dumpRefInfo - Print SAM/BAM Reference Name Information
 dumpIndex - Print BAM Index File in English
 readReference - Print the reference string for the specified region
 explainFlags - Describe flags

Additional Tools
 bam2FastQ - Convert the specified BAM file to fastQs.

Dummy/Example Tools
 readIndexedBam - Read Indexed BAM By Reference and write it from reference id -1 to maxRefId
```

