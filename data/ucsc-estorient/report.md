# ucsc-estorient CWL Generation Report

## ucsc-estorient_estOrient

### Tool Description
convert ESTs so that orientation matches directory of transcription

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-estorient:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-estorient/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-estorient/overview
- **Total Downloads**: 27.0K
- **Last updated**: 2025-06-30
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
estOrient - convert ESTs so that orientation matches directory of transcription

usage: estOrient [options] db estTable outPsl

Read ESTs from a database and determine orientation based on
estOrientInfo table or direction in gbCdnaInfo table.  Update
PSLs so that the strand reflects the direction of transcription.
By default, PSLs where the direction can't be determined are dropped.

Options:
   -chrom=chr - process this chromosome, maybe repeated
   -keepDisoriented - don't drop ESTs where orientation can't
    be determined.
   -disoriented=psl - output ESTs that where orientation can't
    be determined to this file.
   -inclVer - add NCBI version number to accession if not already
    present.
   -fileInput - estTable is a psl file
   -estOrientInfo=file - instead of getting the orientation information
    from the estOrientInfo table, load it from this file.  This data is the
    output of polyInfo command.  If this option is specified, the direction
    will not be looked up in the gbCdnaInfo table and db can be `no'.
   -info=infoFile - write information about each EST to this tab
    separated file 
       qName tName tStart tEnd origStrand newStrand orient
    where orient is < 0 if PSL was reverse, > 0 if it was left unchanged
    and 0 if the orientation couldn't be determined (and was left
    unchanged).
```

