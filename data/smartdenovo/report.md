# smartdenovo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| smartdenovo_pairaln | PASS |  |
| smartdenovo_smartdenovo.pl | PASS |  |
| smartdenovo_wtclp | PASS |  |
| smartdenovo_wtcns | PASS |  |
| smartdenovo_wtcyc | PASS |  |
| smartdenovo_wtext | PASS |  |
| smartdenovo_wtgbo | PASS |  |
| smartdenovo_wtlay | PASS |  |
| smartdenovo_wtmer | PASS |  |
| smartdenovo_wtmsa | PASS |  |
| smartdenovo_wtobt | PASS |  |
| smartdenovo_wtpre | PASS |  |
| smartdenovo_wtzmo | PASS |  |

## smartdenovo_smartdenovo.pl

### Tool Description
Smartdenovo is a de novo assembler for long reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ruanjue/smartdenovo
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/smartdenovo.pl version [unknown] calling Getopt::Std::getopts (version 1.12 [paranoid]),
running under Perl version 5.32.1.

Usage: smartdenovo.pl [-OPTIONS [-MORE_OPTIONS]] [--] [PROGRAM_ARG1 ...]

The following single-character options are accepted:
	With arguments: -t -p -e -k -m -s -J -c

Options may be merged together.  -- stops processing of options.
Space is not required between options and their arguments.
  [Now continuing due to backward compatibility and excessive paranoia.
   See 'perldoc Getopt::Std' about $Getopt::Std::STANDARD_HELP_VERSION.]
Usage: smartdenovo.pl [options] <reads.fa>
Options:
  -p STR     output prefix [wtasm]
  -e STR     engine of overlaper, compressed kmer overlapper(zmo), dot matrix overlapper(dmo), [dmo]
  -t INT     number of threads [8]
  -k INT     k-mer length for overlapping [16]
             for large genome as human, please use 17
  -J INT     min read length [5000]
  -c INT     generate consensus, [0]
```


## smartdenovo_wtzmo

### Tool Description
Overlaper of long reads using homopolymer compressed k-mer seeding

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
WTZMO: Overlaper of long reads using homopolymer compressed k-mer seeding
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtzmo [options]
Options:
 -t <int>    Number of threads, [1]
 -P <int>    Total parallel jobs, [1]
 -p <int>    Index of current job (0-based), [0]
             Suppose to run wtzmo parallelly in 60 nodes. For node1, -P 60 -p 0; node2, -P 60 -p 1, ...
 -i <string> Long reads sequences file, + *
 -I <string> Long reads sequence file, DON'T build index on them, +
             If specified, program will only align them against all sequences from <-i>
             Useful in -I mapping contigs(not too large) against -i pacbio reads
 -b <string> Long reads retained region, often from wtobt/wtcyc, +
             Format: read_name\toffset\tlength\toriginal_len
 -J <int>    Jack knife of original read length, [0]
 -L <string> Load pairs of read name from file, will avoid to calculate overlap them again, + [NULL]
 -o <string> Output file of alignments, *
 -9 <string> Record pairs of sequences have beed aligned regardless of successful, including pairs from '-L'
             Format: read1\tread2
 -f          Force overwrite
 -H <int>    Option of homopolymer compression, [3]
             1: trun on compression on kmer
             2: trun on compression on small-kmer(zmer)
 -k <int>    Kmer size, 5 <= <-k> <= 32, [16]
 -K <int>    Filter high frequency kmers, maybe repetitive, [0]
             0: set K to 5 * <average_kmer_depth>, but no less than 100
 -d <int>    Minimum size of total seeding region for kmer windows, [300]
 -S <int>    Subsampling kmers, 1/<-S> kmers are indexed, [4]
 -G <int>    Build kmer index in multiple iterations to save memory, 1: once, [1]
             Given 10M reads having 100G bases, about 100/(4)=25G used in seq storage, about 100*(6)G=600G
             used in kmer-index. If -G = 10, kmer-index is divided into 10 pieces, thus taking 60G. But we need additional
             10M / <tot_jobs: -P> * 8 * <num_of_cand: -A> memory to store candidates to be aligned.
 -z <int>    Smaller kmer size (z-mer), 5 <= <-z> <= 16, [10]
 -Z <int>    Filter high frequency z-mers, maybe repetitive, [64]
 -U <float>  Ultra-fast dot matrix alignment, pattern search in zmer image
             Usage: wtzmo <other_options> -s 200 -m 0.1 -U 128 -U 64 -U 160 -U 1.0 -U 0.05
                                                        (1)    (2)   (3)    (4)    (5)
             Intra-block (1): max_gap, (2): max_deviation, (3): min_size
             Inter-block (4): deviation penalty, (5): gap size penalty
             use -U -1 instead of type six default parameters
             Will trun off -y -R -r -l -q -B -C -M -X -O -W -T -w -W -e -n -y <int>    Zmer window, [800]
 -R <int>    Minimum size of seeding region within zmer window, [200]
 -r <int>    Minimum size of total seeding region for zmer windows, [300]
 -l <int>    Maximum variant of uncompressed sizes between two matched hz-kmer, [2]
 -q <int>    THreshold of seed-window coverage along query, will be used to decrease weight of repetitive region, [100]
 -A <int>    Limit number of best candidates per read, [500]
 -B <int>    Limit number of best overlaps per read, [100]
             So call 'best' is estimated by seed-windows, and increase as rd_len / avg_rd_len
 -C          Don't skip calculation of its overlaps even when the read was contained by others
 -F <string> Reads from this file(s) are to be exclued, one line for one read name, + [NULL]
 -M <int>    Alignment penalty: match, [2]
 -X <int>    Alignment penalty: mismatch, [-5]
 -O <int>    Alignment penalty: insertion or deletion, [-3]
 -E <int>    Alignment penalty: gap extension, [-1]
 -T <int>    Alignment penalty: read end clipping, 0: distable HSP extension, otherwise set to -50 or other [-50]
 -w <int>    Minimum bandwidth, iteratively doubled to maximum [50]
 -W <int>    Maximum bandwidth, [3200]
 -e <int>    Maximum bandwidth at ending extension, [800]
 -s <int>    Minimum alignment score, [200]
 -m <float>  Minimum alignment identity, [0.5]
 -n          Refine the alignment
 -v          Verbose, BE careful, HUGEEEEEEEE output on STDOUT

Example1: for pacbio reads
$> wtzmo -t 32 -i wt.fa -o wt.zmo.ovl -m 0.6
Example2: for high accurate reads
$> wtzmo -t 32 -i wt.corrected.fa -o wt.zmo.ovl -n -m 0.99 -k 31 -z 16 -H 0 -y 800 -R 500 -r 800 -T -10 -W 200 -e 200
```


## smartdenovo_wtgbo

### Tool Description
Overlapper based on overlap graph

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
WTGBO: Overlapper based on overlap graph
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtgbo [options]
Options:
 -t <int>    Number of threads, [1]
 -i <string> Long reads sequences file(s), + *
 -b <string> Long reads retained region, often from wtobt, +
             Format: read_name\toffset\tlength\toriginal_len
 -j <string> Overlap file(s), + *
             Format: reads1\t+/-\tlen1\tbeg1\tend1\treads2\t+/-\tlen2\tbeg2\tend2\tscore
 -L <string> Load pairs of read name from file, will avoid to calculate overlap them again, + [NULL]
 -s <int>    Minimum alignment score, [200]
 -m <float>  Minimum alignment identity, [0.6]
 -u <int>    Maximum margin of alignment, [100]
 -o <string> Output file of new overlaps, *
 -9 <string> Record pairs of sequences have beed aligned regardless of successful, including pairs from '-L'
             Format: read1\tread2
 -f          Force overwrite output file
 -c <int>    Minimum estimated coverage of edge to be trusted, [1]
             edge coverage is calculated by counting overlaps that can replace this edge
 -Q          Use number of matches as alignment score
 -q <float>  Best score cutoff, say best overlap MUST have alignment score >= <-r> * read's best score [0.95]
 -H          Turn off homopolymer compression
 -z <int>    Smaller kmer size (z-mer), 5 <= <-z> <= 16, [10]
 -Z <int>    Filter high frequency z-mers, maybe repetitive, [100]
 -y <int>    Zmer window, [800]
 -R <int>    Minimum size of seeding region within zmer window, [200]
 -r <int>    Minimum size of total seeding region for zmer windows, [300]
 -l <int>    Maximum variant of uncompressed sizes between two matched hz-kmer, [2]
 -M <int>    Alignment penalty: match, [2]
 -X <int>    Alignment penalty: mismatch, [-5]
 -O <int>    Alignment penalty: insertion or deletion, [-3]
 -E <int>    Alignment penalty: gap extension, [-1]
 -T <int>    Alignment penalty: read end clipping, 0: distable HSP extension, otherwise set to -50 or other [-50]
 -w <int>    Minimum bandwidth, iteratively doubled to maximum [50]
 -W <int>    Maximum bandwidth, [3200]
 -n          Refine the alignment
 -N <int>    Max turns of iteration, [5]
```


## smartdenovo_wtclp

### Tool Description
Maximizing legal overlap by clipping long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
WTCLP: Maximizing legal overlap by clipping long reads
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtclp [options]
 -i <string> Overlap file from wtzmo, +, *
             Format: reads1\t+/-\tlen1\tbeg1\tend1\treads2\t+/-\tlen2\tbeg2\tend2\tscore\tidentity<float>\tmat\tmis\tins\tdel\tcigar
 -b <string> Long reads retained region, often from wtobt/wtcyc, +
             Format: read_name\toffset\tlength\toriginal_len
 -o          Ouput of reads' regions after clipping, -:stdout, *
             Format: read_name\toffset\tlength
 -f          Force overwrite output file
 -F          Keep full length or clip all
 -s <int>    Minimum length of alignment, [1000]
 -m <float>  Minimum identity of alignment, [0.6]
 -C          Trun off specical reservation for reads contained by others
             Default: one read (A) will not be trimmed when it is contained by another read (B).
 -k <int>    Bin size, [50]
 -w <int>    Window size used in chimera detection, [1000]
 -d <int>    Min number of solid overlaps in a suspecting region to reject chimeric, [3]
 -n <int>    Max turns of iterations, [5]
 -T          Treat read as a path of many blocks broken by possible chimeric sites, and test whether the path is valid
             will disable iteration, connection checking
 -x <int>    For debug. 1: chimera checking; 2: conntection checking; 4: clip high error ending [7]
 -v          Verbose
 -8 <string> Print message for special read
```


## smartdenovo_wtcns

### Tool Description
Consensus caller

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
WTCNS: Consensus caller
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtcns [options]
Options:
 -t <int>    Number of threads, [16]
 -P <int>    Total parallel jobs, [1]
 -p <int>    Index of current job (0-based), [0]
             Suppose to run wtcns for the same layout file parallelly in 60 cpu. For cpu1, -P 60 -p 0; cpu2, -P 60 -p 1, ...
 -i <string> Input file, layout from wtlay, +
 -o <string> Output file, consensus sequences, [STDOUT]
 -f          Force overwrite
 -H          Trun on homopolymer compression
 -z <int>    Zmer size, 5 <= <-z> <= 16, [10]
 -y <int>    Zmer window, [800]
 -R <int>    Minimum size of seeding region within zmer window, [200]
 -l <int>    Maximum variant of uncompressed sizes between two matched zmer, [2]
 -M <int>    Alignment penalty: match, [2]
 -X <int>    Alignment penalty: mismatch, [-5]
 -O <int>    Alignment penalty: insertion or deletion, used in first round [-3]
 -I <int>    Alignment penalty: insertion, used in rounds after first, [-2]
 -D <int>    Alignment penalty: deletion, used in rounds after first, [-3]
 -E <int>    Alignment penalty: gap extension, [-1]
 -T <int>    Alignment penalty: read end clipping [-10]
 -F          Disable PhreadQV in refine-alignment
 -w <int>    Minimum bandwidth, iteratively doubled to maximum [50]
 -W <int>    Maximum bandwidth, [3200]
 -e <int>    Maximum bandwidth at ending extension, [800]
 -r <int>    Basic bandwidth in refine-alignment, [8]
 -m <float>  Minimum alignment identity, [0.5]
 -Y <float>  Penalty of backbone edge in calling consensus, [0.5]
 -N <float>  Penalty of alternative edge in calling consensus, [0.2]
             The above two options control whether the consensus look like backbone or alternative
             Default 0.5 and 0.2, will let the consensus don't look like backbone
 -n <int>    Number of iterations for consensus calling, the larger, the accurater, the slower [6]
 -a <string> Align reads against final consensus, and output to <-a>
 -A          Disable fast zmer align in final aligning (see -a), use standard smith-waterman
             More than once -A, will disable fast zmer align in all process
 -V <float> Ouput call variants and print to <-a>, -V 2.05 mean: min_allele_count>=2,min_allele_freq>=0.05
 -v          Verbose, BE careful, HUGEEEEEEEE output on STDOUT

Example: 
$> wtcns wt.lay > wt.lay.cns.fa 2>log.cns
```


## smartdenovo_wtmsa

### Tool Description
Consensus caller using POA

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
WTMSA: Consensus caller using POA
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtmsa [options]
Options:
 -P <int>    Total parallel jobs, [1]
 -p <int>    Index of current job (0-based), [0]
             Suppose to run wtmsa for the same layout file parallelly in 60 cpu. For cpu1, -P 60 -p 0; cpu2, -P 60 -p 1, ...
 -i <string> Input file, layout from wtlay, +, *
 -o <string> Output file, consensus sequences, *
 -B <string> Print backbone sequences on file for debug [NULL]
 -G <stirng> Print dot graph on file, H U G E, be careful, [NULL]
 -f          Force overwrite
 -H          Trun off homopolymer compression
 -z <int>    Zmer size, 5 <= <-z> <= 16, [10]
 -y <int>    Zmer window, [800]
 -R <int>    Minimum size of seeding region within zmer window, [200]
 -l <int>    Maximum variant of uncompressed sizes between two matched zmer, [2]
 -M <int>    Alignment penalty: match, [2]
 -X <int>    Alignment penalty: mismatch, [-5]
 -I <int>    Alignment penalty: insertion, [-2]
 -D <int>    Alignment penalty: deletion, [-3]
 -V <int>    turn on homopolymer merge penalty
 -E <int>    Alignment penalty: gap extension, [-1]
 -T <int>    Alignment penalty: read end clipping [-10]
 -F          Disable PhreadQV in refine-alignment
 -w <int>    Minimum bandwidth of pairwise alignment, iteratively doubled to maximum [50]
 -W <int>    Maximum bandwidth of pairwise alignment, [3200]
 -e <int>    Maximum bandwidth at graph alignment and ending extension, [800]
 -g <int>    Basic bandwidth in graph alignment, [100]
 -m <float>  Minimum alignment identity, [0.5]
 -n <int>    Number of iterations for consensus calling, the more, the accurater, the slower [2]
 -v          Verbose, +

Example: 
$> wtmsa -i wt.lay -o wt.lay.cns.fa 2>log.msa
```


## smartdenovo_wtpre

### Tool Description
WTPRE: Prepare raw reads for assembly

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
WTPRE: Prepare raw reads for assembly
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtpre [options] <raw_reads_file:fq/fa>
Options:
 -o <string> Output of processed reads, [-]
 -f          Force overwrite output file
 -L          Keep all subreads in a well, default: the longest one
 -J <int>    Jack knife of read length, [0]
 -c <int>    Clip <-c> bases at both ends, [0]
 -p <string> Change the read name into {"%s%012d", <-p>}, [pb]

Example: 
$> wtpre -J 5000 -p pb my_raw_reads_1.fq my_raw_reads_2.fq >wt.fa
```

## smartdenovo_wtobt

### Tool Description
WTOBT: Overlap based trimming

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
WTOBT: Overlap based trimming
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtobt [options]
 -i <string> Long reads sequences file, + *
 -b <string> Long reads retained region, often from wtobt/wtcyc, +
             Format: read_name\toffset\tlength\toriginal_len
 -j <string> Overlap file(s), + *
             Format: reads1\t+/-\tlen1\tbeg1\tend1\treads2\t+/-\tlen2\tbeg2\tend2\tscore\tidentity<float>\tmat\tmis\tins\tdel\tcigar
 -o          Ouput of reads' regions after trimming, -:stdout, *
             Format: read_name\toffset\tlength
 -f          Force overwrite output file
 -C          Trun off specical trim for reads contained by others
             One read (A) will not be trimmed when it is contained by another read (B).
             When trun on special trim (by default), if the B read is trimmed, program will accordingly trim A read
 -s <int>    Minimum score of alignment, [200]
 -m <float>  Minimum identity of alignment , [0.5]
 -w <int>    Maximum margin of alignment, [200]
 -c <int>    Minimum depth of overlap between anchored reads along reference read, to detect chimeric reads, [1]

Example:
$> wtobt -i wt.fa -j wt.zmo.ovl -o wt.zmo.obt -m 0.6 -c 2
```

## smartdenovo_wtlay

### Tool Description
WTLay: Layout of long reads using Best Overlap Graph

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
WTLay: Layout of long reads using Best Overlap Graph
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtlay [options]
Options:
 -i <string> Long reads sequences file(s), + *
 -b <string> Long reads retained region, often from wtobt, +
             Format: read_name\toffset\tlength\toriginal_len
 -j <string> Overlap file(s), + *
             Format: reads1\t+/-\tlen1\tbeg1\tend1\treads2\t+/-\tlen2\tbeg2\tend2\tscore
 -s <int>    Minimum alignment matched bases, [500]
 -m <float>  Minimum alignment identity, [0.6]
 -w <int>    Maximum margin of alignment, [100]
 -o <string> Output file of layouts, *
 -f          Force overwrite output file
 -c <int>    Minimum estimated coverage of edge to be trusted, [1]
             edge coverage is calculated by counting overlaps that can replace this edge
 -R          Use number of matches as alignment score
 -r <float>  Best score cutoff, say best overlap MUST have alignment score >= <-r> * read's best score [0.95]
 -q <float>  Minimum coverage for similar unitig detection, say the aligned length of unitig A by unitig B, divided by total length of unitig A, [0.4]
 -u <int>    Min nodes of a layout to be output as independent unitig, [4]
 -B <int>    Maximum step in tracing bubbles, [20]
 -S <float>  Variance threshold of (alignment score / overlap) between ture and false overlaps, [0.50]
             Used in better_overlap_strgraph
---- DEBUG option ---
 -Q <string> Commands, [gCwgBgRURg]
             G: print_dot_strgraph
             g: print_simple_dot_strgraph
             w: mask_low_cov_edge_strgraph
             C: mask_contained_reads_strgraph
             B: best_overlap_strgraph
             t: bog_cut_tips_strgraph
             M: bog_merge_bubbles_strgraph
             U: recover_edges_inter_unitigs_strgraph
             R: repair_best_overlap_strgraph
             b: better_overlap_strgraph
             O: mask_self_circle_reads_strgraph
             T: reduce_transitive_strgraph
             L: longest_overlap_strgraph
             .: exit program

Example: 
$> wtlay -i wt.fa -b wt.zmo.obt -j wt.zmo.ext -o wt.lay -m 0.6 -c 1 -r 0.95
```

## smartdenovo_wtcyc

### Tool Description
WTCYC: Align long read against its reverse complementary

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
WTCYC: Align long read against its reverse complementary
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtcyc [options] <long_read_file>
Options:
 -t <int>    Number of threads, [1]
 -P <int>    Total parallel jobs, [1]
 -p <int>    Index of current job (0-based), [0]
             Suppose to run it parallelly in 60 nodes. For node1, -P 60 -p 0; node2, -P 60 -p 1, ...
 -o <string> Output of reads' regions after trimming, [-]
 -a <string> Output of alignments, [NULL]
 -f          Force overwrite output file
 -s <int>    Mininum alignment score, [400]
 -m <int>    Mininum alignment identity, [0.7]
 -M <int>    Alignment penalty: match, [2]
 -X <int>    Alignment penalty: mismatch, [-5]
 -O <int>    Alignment penalty: gap open, [-3]
 -E <int>    Alignment penalty: gap extension, [-1]
 -T <int>    Alignment penalty: read end clipping, 0: distable HSP extension, otherwise set to -30 or other [-100]
 -W <int>    Bandwidth, [800]

Example: 
$> wtcyc -t 32 wt.fa -fo wt.zmo.cyc -a wt.zmo.cyc.info
```

## smartdenovo_wtext

### Tool Description
WTEXT: Extending and clipping overlaps

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
WTEXT: Extending and clipping overlaps
SMARTdenovo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtext [options]
Options:
 -t <int>    Number of threads, [1]
 -P <int>    Total parallel jobs, [1]
 -p <int>    Index of current job (0-based), [0]
             Suppose to run it parallelly in 60 nodes. For node1, -P 60 -p 0; node2, -P 60 -p 1, ...
 -i <string> Long reads sequences file, + *
 -B <string> Long reads previous retained region, often from wtcyc, +
             Format: read_name\toffset\tlength
 -b <string> Long reads retained region, often from wtobt, +
             Format: read_name\toffset\tlength
 -j <string> Overlap file(s), + *
             Format: reads1\t+/-\tlen1\tbeg1\tend1\treads2\t+/-\tlen2\tbeg2\tend2\tscore\tidentity<float>\tmat\tmis\tins\tdel\tcigar
 -o <string> Output file of extended alignments, -:stdout, *
 -f          Force overwrite
 -W <float>  Bandwidth, [800]
 -M <int>    Alignment penalty: match, [2]
 -X <int>    Alignment penalty: mismatch, [-5]
 -O <int>    Alignment penalty: insertion or deletion, [-3]
 -E <int>    Alignment penalty: gap extension, [-1]
 -T <int>    Alignment penalty: read end clipping [-100]
 -S <int>    Maximum extension (bp) in each end, [400]

Example: 
$> wtext -t 32 -i wt.fa -b wt.zmo.obt -j wt.zmo.ovl -o wt.zmo.ext
```

## smartdenovo_wtmer

### Tool Description
WTMER: K-mer analysis of long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
WTMER: K-mer analysis of long reads
SMARTdenvo: Ultra-fast de novo assembler for high noisy long reads
Author: Jue Ruan <ruanjue@gmail.com>
Version: 1.0
Usage: wtmer [options]
Options:
 -i <string> Long reads sequences file, + *
 -o <string> Output file of kmer_frequency, *
 -f          Force overwrite
 -H          Disable homopolymer compression
 -k <int>    Kmer size, 5 <= <-k> <= 16, [16]
```

## smartdenovo_pairaln

### Tool Description
pairaln: align pairs of sequences read from standard input

### Metadata
- **Docker Image**: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
- **Homepage**: https://github.com/ruanjue/smartdenovo
- **Package**: https://anaconda.org/channels/bioconda/packages/smartdenovo/overview
- **Validation**: PASS

### Original Help Text
```text
Program: pairaln
 pairaln read paired sequences (fasta or fastq) from STDIN, here is an example input
 >read1
 AAGGCCTT
 >read2
 AAGCCTT
 and so on, read3, read4, ...
 pairaln will perform alignment on read1 and read2, read3 and read4, ...
 The default parameters is used for pacbio long reads
Usage: pairaln [options]
Author: Jue Ruan
Options:
 -s          Try both strands
 -M <int>    Alignment penalty: match, [2]
 -X <int>    Alignment penalty: mismatch, [-5]
 -O <int>    Alignment penalty: insertion or deletion, [-3]
 -E <int>    Alignment penalty: gap extension, [-1]
 -T <int>    Alignment penalty: read end clipping, 0: distable HSP extension, otherwise set to -100 or other [-100]
 -W <int>    Bandwidth, [800]
 -a          Output alignment
```

## Metadata
- **Skill**: generated
