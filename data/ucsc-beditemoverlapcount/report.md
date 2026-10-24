# ucsc-beditemoverlapcount CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-beditemoverlapcount | PASS |  |

## ucsc-beditemoverlapcount

### Tool Description
Count how many items in a BED file overlap each other. Note: The provided help text was a system error message; parameters are based on standard tool documentation.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-beditemoverlapcount:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-beditemoverlapcount/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-beditemoverlapcount/overview
- **Total Downloads**: 29.8K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
bedItemOverlapCount - count number of times a base is overlapped by the
	items in a bed file.  Output is bedGraph 4 to stdout.
usage:
 sort bedFile.bed | bedItemOverlapCount [options] <database> stdin
To create a bigWig file from this data to use in a custom track:
 sort -k1,1 bedFile.bed | bedItemOverlapCount [options] <database> stdin \
         > bedFile.bedGraph
 bedGraphToBigWig bedFile.bedGraph chrom.sizes bedFile.bw
   where the chrom.sizes is obtained with the script: fetchChromSizes
   See also:
 http://genome-test.gi.ucsc.edu/~kent/src/unzipped/utils/userApps/fetchChromSizes
options:
   -zero      add blocks with zero count, normally these are ommitted
   -bed12     expect bed12 and count based on blocks
              Without this option, only the first three fields are used.
   -max       if counts per base overflows set to max (4294967295) instead of exiting
   -outBounds output min/max to stderr
   -chromSize=sizefile	Read chrom sizes from file instead of database
             sizefile contains two white space separated fields per line:
		chrom name and size
   -host=hostname	mysql host used to get chrom sizes
   -user=username	mysql user
   -password=password	mysql password

Notes:
 * You may want to separate your + and - strand
   items before sending into this program as it only looks at
   the chrom, start and end columns of the bed file.
 * Program requires a <database> connection to lookup chrom sizes for a sanity
   check of the incoming data.  Even when the -chromSize argument is used
   the <database> must be present, but it will not be used.

 * The bed file *must* be sorted by chrom
 * Maximum count per base is 4294967295. Recompile with new unitSize to increase this
```


## Metadata
- **Skill**: not generated
