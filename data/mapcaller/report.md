# mapcaller CWL Generation Report

## mapcaller_MapCaller

### Tool Description
MapCaller v0.9.9.41

### Metadata
- **Docker Image**: quay.io/biocontainers/mapcaller:0.9.9.41--h13024bc_6
- **Homepage**: https://github.com/hsinnan75/MapCaller
- **Package**: https://anaconda.org/channels/bioconda/packages/mapcaller/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mapcaller/overview
- **Total Downloads**: 110.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hsinnan75/MapCaller
- **Stars**: N/A
### Original Help Text
```text
Warning! Unknow parameter: -help
MapCaller v0.9.9.41

Usage: MapCaller -i Index_Prefix -f <ReadFile_A1 ReadFile_B1 ...> [-f2 <ReadFile_A2 ReadFile_B2 ...>]

Options: -i STR        BWT_Index_Prefix
         -r STR        Reference filename (format:fa)
         -f            files with #1 mates reads (format:fa, fq, fq.gz)
         -f2           files with #2 mates reads (format:fa, fq, fq.gz)
         -t INT        number of threads [16]
         -size         sequencing fragment size [500]
         -indel INT	maximal indel size [30]
         -ad INT       minimal ALT allele count [5]
         -dup INT      maximal PCR duplicates [5]
         -maxmm FLOAT  maximal mismatch rate in read alignment [0.05]
         -maxclip INT  maximal clip size at either ends [5]
         -sam          SAM output filename [NULL]
         -bam          BAM output filename [NULL]
         -alg STR      gapped alignment algorithm (option: nw|ksw2)
         -vcf          VCF output filename [output.vcf]
         -gvcf         GVCF mode [false]
         -log STR      log filename [job.log]
         -monomorphic  report all loci which do not have any potential alternates.
         -min_cnv INT  the minimal cnv size to be reported [50].
         -min_gap INT  the minimal gap(unmapped) size to be reported [50].
         -ploidy INT   number of sets of chromosomes in a cell (1:monoploid, 2:diploid) [2]
         -m            output multiple alignments
         -somatic      detect somatic mutations [false]
         -no_vcf       No VCF output [false]
         -p            paired-end reads are interlaced in the same file
         -filter       apply variant filters (under test) [false]
         -id STR       assign sample id
         -v            version
```

