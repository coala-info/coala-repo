# ucsc-liftup CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-liftup | PASS |  |

## ucsc-liftup

### Tool Description
Change coordinates of .psl, .agp, .gap, .gl, .out, .align, .gff, .gtf, .bscore, .tab, .gdup, .axt, .chain, .net, .gp, .genepred, .wab, .bed, .bed3, or .bed8 files to the parent coordinate system.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-liftup:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-liftup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-liftup/overview
- **Total Downloads**: 24.8K
- **Last updated**: 2025-06-29
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
liftUp - change coordinates of .psl, .agp, .gap, .gl, .out, .align, .gff, .gtf
.bscore .tab .gdup .axt .chain .net, .gp, .genepred, .wab, .bed, .bed3, or .bed8 files to
parent coordinate system.

usage:
   liftUp [-type=.xxx] destFile liftSpec how sourceFile(s)
The optional -type parameter tells what type of files to lift
If omitted the type is inferred from the suffix of destFile
Type is one of the suffixes described above.
DestFile will contain the merged and lifted source files,
with the coordinates translated as per liftSpec.  LiftSpec
is tab-delimited with each line of the form:
   offset oldName oldSize newName newSize
LiftSpec may optionally have a sixth column specifying + or - strand,
but strand is not supported for all input types.
The 'how' parameter controls what the program will do with
items which are not in the liftSpec.  It must be one of:
   carry - Items not in liftSpec are carried to dest without translation
   drop  - Items not in liftSpec are silently dropped from dest
   warn  - Items not in liftSpec are dropped.  A warning is issued
   error - Items not in liftSpec generate an error
If the destination is a .agp file then a 'large inserts' file
also needs to be included in the command line:
   liftUp dest.agp liftSpec how inserts sourceFile(s)
This file describes where large inserts due to heterochromitin
should be added. Use /dev/null and set -gapsize if there's not inserts file.

options:
   -nohead  No header written for .psl files
   -dots=N Output a dot every N lines processed
   -pslQ  Lift query (rather than target) side of psl
   -axtQ  Lift query (rather than target) side of axt
   -chainQ  Lift query (rather than target) side of chain
   -netQ  Lift query (rather than target) side of net
   -wabaQ  Lift query (rather than target) side of waba alignment
   	(waba lifts only work with query side at this time)
   -nosort Don't sort bed, gff, or gdup files, to save memory
   -gapsize change contig gapsize from default
   -ignoreVersions - Ignore NCBI-style version number in sequence ids of input files
   -extGenePred lift extended genePred
```

