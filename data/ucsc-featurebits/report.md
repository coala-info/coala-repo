# ucsc-featurebits CWL Generation Report

## ucsc-featurebits_featureBits

### Tool Description
Correlate tables via bitmap projections.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-featurebits:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-featurebits/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-featurebits/overview
- **Total Downloads**: 29.0K
- **Last updated**: 2025-06-30
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
featureBits - Correlate tables via bitmap projections. 
usage:
   featureBits database table(s)
This will return the number of bits in all the tables bitwise ANDed together
Pipe warning:  output goes to stderr.
Options:
   -bed=output.bed   Put intersection into bed format. Can use stdout.
   -fa=output.fa     Put sequence in intersection into .fa file
   -faMerge          For fa output merge overlapping features.
   -minSize=N        Minimum size to output (default 1)
   -chrom=chrN       Restrict to one chromosome
   -chromSize=sizefile       Read chrom sizes from file instead of database. 
                             (chromInfo three column format)
   -or               Bitwise OR tables together instead of ANDing them.
   -not              Output negation of resulting bit set.
   -countGaps        Count gaps in denominator
   -countBlocks      Count blocks in bed12 files rather than entire extent.
   -noRandom         Don't include _random (or Un) chromosomes
   -noHap            Don't include _hap|_alt chromosomes
   -primaryChroms    Primary assembly (chroms without '_' in name)
   -dots=N           Output dot every N chroms (scaffolds) processed
   -minFeatureSize=n Don't include bits of the track that are smaller than
                     minFeatureSize, useful for differentiating between
                     alignment gaps and introns.
   -bin=output.bin   Put bin counts in output file
   -binSize=N        Bin size for generating counts in bin file (default 500000)
   -binOverlap=N     Bin overlap for generating counts in bin file (default 250000)
   -bedRegionIn=input.bed    Read in a bed file for bin counts in specific regions 
                     and write to bedRegionsOut
   -bedRegionOut=output.bed  Write a bed file of bin counts in specific regions 
                     from bedRegionIn
   -enrichment       Calculates coverage and enrichment assuming first table
                     is reference gene track and second track something else
                     Enrichment is the amount of table1 that covers table2 vs. the
                     amount of table1 that covers the genome. It's how much denser
                     table1 is in table2 than it is genome-wide.
   '-where=some sql pattern'  Restrict to features matching some sql pattern
You can include a '!' before a table name to negate it.
   To prevent your shell from interpreting the '!' you will need
   to use the backslash \!, for example the gap table: \!gap
Some table names can be followed by modifiers such as:
    :exon:N          Break into exons and add N to each end of each exon
    :cds             Break into coding exons
    :intron:N        Break into introns, remove N from each end
    :utr5, :utr3     Break into 5' or 3' UTRs
    :upstream:N      Consider the region of N bases before region
    :end:N           Consider the region of N bases after region
    :score:N         Consider records with score >= N 
    :upstreamAll:N   Like upstream, but doesn't filter out genes that 
                     have txStart==cdsStart or txEnd==cdsEnd
    :endAll:N        Like end, but doesn't filter out genes that 
                     have txStart==cdsStart or txEnd==cdsEnd
The tables can be bed, psl, or chain files, or a directory full of
such files as well as actual database tables.  To count the bits
used in dir/chrN_something*.bed you'd do:
   featureBits database dir/_something.bed
File types supported are BED, bigBed, PSL, and chain.  The suffix of the file 
is used to determine the type and MUST be .bed, .bb, .psl, or .chain respectively.
NB: by default, featureBits omits gap regions from its calculation of the total
number of bases.  This requires connecting to a database server using credentials
from a .hg.conf file (or similar).  If such a connection is not available, you will
need to specify -countGaps (which skips the database connection) in addition to
providing all tables as files or directories.
```

