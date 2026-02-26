# recalladapters CWL Generation Report

## recalladapters

### Tool Description
recalladapters operates on BAM files in one convention (subreads+scraps or hqregions+scraps), allows reprocessing adapter calls then outputs the resulting BAM files as subreads plus scraps.

"Scraps" BAM files are always required to reconstitute the ZMW reads internally. Conversely, "scraps" BAM files will be output.

ZMW reads are not allowed as input, due to the missing HQ-region annotations!

Input read convention is determined from the READTYPE annotation in the @RG::DS tags of the input BAM files.A subreadset *must* be used as input instead of the individual BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/recalladapters:9.0.0--h9ee0642_1
- **Homepage**: https://github.com/PacificBiosciences/pbbioconda
- **Package**: https://anaconda.org/channels/bioconda/packages/recalladapters/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/recalladapters/overview
- **Total Downloads**: 8.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pbbioconda
- **Stars**: N/A
### Original Help Text
```text
Usage: -s subreadset.xml -o outputPrefix [options]

Version:9.0.0.da2e8977c

recalladapters operates on BAM files in one convention (subreads+scraps or
hqregions+scraps), allows reprocessing adapter calls then outputs the resulting
BAM files as subreads plus scraps.

"Scraps" BAM files are always required to reconstitute the ZMW reads internally.
Conversely, "scraps" BAM files will be output.

ZMW reads are not allowed as input, due to the missing HQ-region annotations!

Input read convention is determined from the READTYPE annotation in the @RG::DS
tags of the input BAM files.A subreadset *must* be used as input instead of the
individual BAM files.

Options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

  Mandatory parameters:
    -o STRING           Prefix of output filenames
    -s STRING, --subreadset=STRING
                        Input subreadset.xml

  Optional parameters:
    -j INT, --nProcs=INT
                        Number of threads for parallel ZMW processing
    -b INT              Number of threads for parallel BAM compression, can only
                        be set when not generating pbindex inline with --inlinePbi
    --inlinePbi         Generate pbindex inline with BAM writing
    --silent            No progress output.

  Adapter finding parameters:
    --disableAdapterFinding
    --adapters=adapterSequences.fasta
    --globalAlnFlanking
    --flankLength=INT   
    --minSoftAccuracy=FLOAT
    --minHardAccuracy=FLOAT
    --minFlankingScore=FLOAT
    --disableAdapterCorrection
    --adpqc             

  Fine tuning:
    --minAdapterScore=int
                        Minimal score for an adapter
    --minSubLength=INT  Minimal subread length. Default: 50
    --minSnr=FLOAT      Minimal SNR across channels. Default: 3.75

  White list:
    --whitelistZmwNum=RANGES
                        Only process given ZMW NUMBERs

Example: recalladapters -s in.subreadset.xml -o out --adapters adapters.fasta
```


## Metadata
- **Skill**: generated
