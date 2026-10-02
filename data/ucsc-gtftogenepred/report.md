# ucsc-gtftogenepred CWL Generation Report

## ucsc-gtftogenepred

### Tool Description
convert a GTF file to a genePred

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-gtftogenepred:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-gtftogenepred/overview
- **Validation**: PASS

### Original Help Text
```text
gtfToGenePred - convert a GTF file to a genePred
usage:
   gtfToGenePred gtf genePred

options:
     -genePredExt - create a extended genePred, including frame
      information and gene name
     -allErrors - skip groups with errors rather than aborting.
      Useful for getting infomation about as many errors as possible.
     -ignoreGroupsWithoutExons - skip groups contain no exons rather than
      generate an error.
     -infoOut=file - write a file with information on each transcript
     -sourcePrefix=pre - only process entries where the source name has the
      specified prefix.  May be repeated.
     -impliedStopAfterCds - implied stop codon in after CDS
     -simple    - just check column validity, not hierarchy, resulting genePred may be damaged
     -geneNameAsName2 - if specified, use gene_name for the name2 field
      instead of gene_id.
     -includeVersion - it gene_version and/or transcript_version attributes exist, include the version
      in the corresponding identifiers.
```
## Metadata
- **Skill**: generated
