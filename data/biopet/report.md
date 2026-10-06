# biopet CWL Generation Report

## Metadata
- **Skill**: generated

## biopet

### Tool Description
A bioinformatics pipeline and tool suite for processing genomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
- **Homepage**: https://github.com/biopet/biopet
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
ERROR: module '--help' does not exist

Usage   : java -jar <path/to/biopet.jar> {pipeline,tool,template} <name> [args]
Version : 0.9.0 (be7838f2)

Available pipeline(s):
  - Bam2Wig
  - BamMetrics
  - Basty
  - Carp
  - DownloadGenomes
  - Flexiprep
  - Gears
  - GearsSingle
  - GenerateIndexes
  - Gentrap
  - GwasTest
  - Impute2Vcf
  - Kopisu
  - Mapping
  - MultisampleMapping
  - Sage
  - Shiva
  - ShivaSvCalling
  - ShivaVariantcalling
  - TinyCap
  - Toucan

Available tool(s):
  - AnnotateVcfWithBed
  - BamStats
  - BaseCounter
  - BastyGenerateFasta
  - BedtoolsCoverageToCounts
  - BiopetFlagstat
  - CheckAllelesVcfInBam
  - DownloadNcbiAssembly
  - ExtractAlignedFastq
  - FastqFilter
  - FastqSplitter
  - FastqSync
  - FindOverlapMatch
  - FindRepeatsPacBio
  - GvcfToBed
  - MergeAlleles
  - MergeTables
  - MpileupToVcf
  - PipelineStatus
  - PrefixFastq
  - SageCountFastq
  - SamplesTsvToConfig
  - SeqStat
  - SquishBed
  - SummaryToTsv
  - ValidateFastq
  - ValidateVcf
  - VcfFilter
  - VcfStats
  - VcfToTsv
  - VcfWithVcf
  - VepNormalizer
  - WipeReads

Available template(s):
  - Gentrap
  - MultiSampleMapping
  - Shiva

Subcommands:
  - version
  - license

Questions or comments? Email sasc@lumc.nl or check out the project page at https://git.lumc.nl/biopet/biopet.git
```

