# mosaicatcher CWL Generation Report

## mosaicatcher_count

### Tool Description
Count reads from Strand-seq BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
- **Homepage**: https://github.com/friendsofstrandseq/mosaicatcher/
- **Package**: https://anaconda.org/channels/bioconda/packages/mosaicatcher/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mosaicatcher/overview
- **Total Downloads**: 7.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/friendsofstrandseq/mosaicatcher
- **Stars**: N/A
### Original Help Text
```text
Mosaicatcher 0.3.1
> Count reads from Strand-seq BAM files.

Usage:   count [OPTIONS] <cell1.bam> <cell2.bam> ...


Generic options:
  -? [ --help ]                     show help message
  -v [ --verbose ]                  Be more verbose in the output
  -q [ --mapq ] arg (=10)           min mapping quality
  -w [ --window ] arg (=500000)     window size of fixed windows
  -o [ --out ] arg (="out.txt.gz")  output file for counts + strand state (gz)
  -b [ --bins ] arg                 BED file with manual bins (disables -w). 
                                    See also 'makebins'
  -x [ --exclude ] arg              Exclude chromosomes and regions
  -i [ --info ] arg                 Write info about samples
  --do-not-filter-by-WC             When black-listing bins, only consider 
                                    coverage and not WC/WW/CC states
  --do-not-blacklist-hmm            Do not output a blacklist (None bins). Bins
                                    will be blacklisted for parameter 
                                    estimation, but not during HMM

Notes:
  * writes a table of bin counts and state classifcation as a gzip file (default: out.txt.gz)
  * Reads are counted by start position
  * One cell per BAM file, including SM tag in header
  * For paired-end data, only read 1 is counted
```


## mosaicatcher_segment

### Tool Description
Find a segmentation across multiple cells.

### Metadata
- **Docker Image**: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
- **Homepage**: https://github.com/friendsofstrandseq/mosaicatcher/
- **Package**: https://anaconda.org/channels/bioconda/packages/mosaicatcher/overview
- **Validation**: PASS

### Original Help Text
```text
Mosaicatcher 0.3.1
> Find a segmentation across multiple cells.

Usage:   segment [OPTIONS] counts.txt.gz


Generic options:
  -? [ --help ]                         show help message
  -o [ --out ] arg (="segments.txt")    output file for counts

Segmentation options:
  -m [ --max_bp_per_Mb ] arg (=0.25)    max. number of change points per Mb
  -i [ --max_bp_intercept ] arg (=15)   max. number of cp, add this constant
  -M [ --max_segment ] arg (=100000000) maximum segment length
  --penalize-none [=arg(=100)]          Penalize segments through removed bins 
                                        (which are marked by 'None' in the 
                                        counts table).
  --forbid-small-segments arg (=1)      Penalize segments shorter that this 
                                        number of bins
  --remove-none                         Remove segments through removed bins 
                                        before segmentation. Mutually exclusive
                                        with --penalize-none.
  --do-not-normalize-cells              Instead of using cell-normalized counts
                                        for each strand, use the raw numbers.
  --do-not-remove-bad-cells             Keep all cells (by default, cells which
                                        are marked 'None' in all bins get 
                                        removed
```


## mosaicatcher_simulate

### Tool Description
Simulate binned Strand-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
- **Homepage**: https://github.com/friendsofstrandseq/mosaicatcher/
- **Package**: https://anaconda.org/channels/bioconda/packages/mosaicatcher/overview
- **Validation**: PASS

### Original Help Text
```text
Mosaicatcher 0.3.1
> Simulate binned Strand-seq data.

Usage:   simulate [OPTIONS] SV-conf-file


Generic options:
  -? [ --help ]                         show help message
  -v [ --verbose ]                      tell me more
  --seed arg                            Random generator seed
  -w [ --window ] arg (=100000)         window size of fixed windows
  -n [ --numcells ] arg (=10)           number of cells to simulate
  -g [ --genome ] arg                   Chrom names & length file. Default: 
                                        GRch38

Output options:
  -o [ --out ] arg (="out.txt.gz")      output count file
  -P [ --phases ] arg                   output phased reads into a file
  -S [ --sceFile ] arg                  output the positions of SCEs
  -V [ --variantFile ] arg              output SVs and which cells they were 
                                        simulated in
  -U [ --segmentFile ] arg              output optimal segmentation according 
                                        to SVs and SCEs.
  -i [ --info ] arg                     Write info about samples
  --sample-name arg (=simulated)        Use this sample name in the output

Radnomization parameters:
  -p [ --nbinom_p ] arg (=0.8)          p parameter of the NB distirbution
  -c [ --minCoverage ] arg (=10)        min. read coverage per bin
  -C [ --maxCoverage ] arg (=60)        max. read coverage per bin
  -a [ --alpha ] arg (=0.1)             noise added to all bins: mostly 0, but 
                                        for a fraction alpha drawn from 
                                        geometrix distribution
  -s [ --scesPerCell ] arg (=4)         Average number of SCEs per cell
  -z [ --phasedFraction ] arg (=0.10000000000000001)
                                        Average number of SCEs per cell

Simulate binned Strand-seq cells including structural variants (SVs)
and sister chromatid exchange events (SCEs). Type, size, position and
frequency of SVs are specified by a config file. To not include SVs
specify an empty file. The SV config file is a tab-separated file with
5 columns (chrom, start, end, SV type, avg. freuqency).
The allowed SV types are
  - het_del, hom_del
  - het_dup, hom_dup
  - het_inv, hom_inv
  - inv_dup
  - false_del (to simulate lower mappability region)
SV breakpoints do not need to align with bin boundaries.

Note: The frequency (5-th colum) is interpreted as an expected
      fraction of cells carrying the SV - the exact number of cells
      can eventually differ form that expectation.
```


## mosaicatcher_makebins

### Tool Description
Specify whole genome sequencing data (or a set of Strand-seq cells
merged into a single file) which were sequenced under equal conditions.
This tool will create bins of variable width but which contian the same
number of reads. This way we hope to overcome mappability issues.

### Metadata
- **Docker Image**: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
- **Homepage**: https://github.com/friendsofstrandseq/mosaicatcher/
- **Package**: https://anaconda.org/channels/bioconda/packages/mosaicatcher/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: makebins [OPTIONS] <wgs.bam>

Generic options:
  -? [ --help ]                   show help message
  -q [ --mapq ] arg (=10)         min mapping quality
  -w [ --window ] arg (=100000)   window size to approximate
  -n [ --numreads ] arg (=20)     sample 1/n of reads (reduce memory)
  -o [ --out ] arg (="bins.bed")  output file for bins
  -x [ --exclude ] arg            Exclude chromosomes (no regions!)

Specify whole genome sequencing data (or a set of Strand-seq cells
merged into a single file) which were sequenced under equal conditions.
This tool will create bins of variable width but which contian the same
number of reads. This way we hope to overcome mappability issues.
```


## mosaicatcher_states

### Tool Description
Call Sister chromatid exchange events (SCEs).

### Metadata
- **Docker Image**: quay.io/biocontainers/mosaicatcher:0.3.1--h66ab1b6_2
- **Homepage**: https://github.com/friendsofstrandseq/mosaicatcher/
- **Package**: https://anaconda.org/channels/bioconda/packages/mosaicatcher/overview
- **Validation**: PASS

### Original Help Text
```text
Mosaicatcher 0.3.1
> Call Sister chromatid exchange events (SCEs).

Usage:   states [-u] [-v] [OPTIONS] counts.txt.gz


Generic options:
  -? [ --help ]                         show help message
  -o [ --out ] arg (="segments.txt")    output file for counts
  -u [ --ignore-small-regions ] arg (=5000000)
                                        Ignore segments of this size or smaller
  -v [ --ignore-low-support-regions ] arg (=33)
                                        Ignore segments with less reads than 
                                        this
  -w [ --recurrent-window-size ] arg (=2000000)
                                        Sliding window to determine recurrent 
                                        state changes
  -f [ --recurrent-fraction ] arg (=0.100000001)
                                        Fraction of cells with state change to 
                                        be called recurrent

Sister Chromatid Exchange events (SCEs) are visible in Strand-seq      
data as a change in the inherited strand states (e.g. from WW to WC)   
which occurs at a random position in the chromosome. Here I implemented
a very heuristic approach to SCE detecion (described below). It is     
recommended to provide a count table in a low resolution (e.g. 500kb)  
to reduce the number of state flips.                                   
                                                                       
Algorithm:                                                             
 1. Combine consecutive intervals of the same state (taken from the    
    class column in the count table) into larger intervals.            
 2. Drop 'None' regions, which had been marked as bad regions across   
    all cells. Special care is taken at the ends of the chromosomes:   
    if a chromosome ends in a 'None' region, the adjacent region is    
    extended to the end.                                               
 3. Remove small (-u) or low-supported (-v) regions which are not      
    concordant with the majority type of the chromosome. This should   
    again reduce the number of state flips.                            
    NOTE: Only a single strand state is assumed per chromosome - there 
          are chromosomes with more than one SCE, which this algorithm 
          will not capture correctly.                                  
 4. Recurrence:                                                        
    Check for clusters of change points across all cells, but only     
    internal to the chromosomes, not the telomeres.               .    
    When there are enough breakpoints (-f) inside a sliding window (-w)
    all non-majority segments with a boundary in this region will be   
    removed.
```

