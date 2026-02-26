# wtdbg2 CWL Generation Report

## wtdbg2

### Tool Description
De novo assembler for long noisy sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/wtdbg2:2.0--h470a237_0
- **Homepage**: https://github.com/ruanjue/wtdbg2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wtdbg2/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/ruanjue/wtdbg2
- **Stars**: N/A
### Original Help Text
```text
WTDBG: De novo assembler for long noisy sequences
Author: Jue Ruan <ruanjue@gmail.com>
Version: 2.0 (20180924)
Compiled: Mon Sep 24 15:38:04 UTC 2018
Usage: wtdbg2 [options]
Options:
 -i <string> Long reads sequences file (REQUIRED; can be multiple), []
 -I <string> Error-free sequences file (can be multiple), []
 -o <string> Prefix of output files (REQUIRED), []
 -t <int>    Number of threads, 0 for all cores, [4]
 -f          Force to overwrite output files
 -L <int>    Choose the longest subread and drop reads shorter than <int> (5000 recommended for PacBio) [0]
 -k <int>    Kmer fsize, 0 <= k <= 25, [0]
 -p <int>    Kmer psize, 0 <= p <= 25, [21]
             k + p <= 25, seed is <k-mer>+<p-homopolymer-compressed>
 -K <float>  Filter high frequency kmers, maybe repetitive, [1000]
             if K >= 1, take the integer value as cutoff, MUST <= 65535
             else, mask the top fraction part high frequency kmers
 -E <int>    Min kmer frequency, [2]
 -F          Filter low frequency kmers by a 4G-bytes array (max_occ=3 2-bits). Here, -E must greater than 1
 -S <int>    Subsampling kmers, 1/(<-S>) kmers are indexed, [4]
             -S is very useful in saving memeory and speeding up
             please note that subsampling kmers will have less matched length
 -X <int>    Max number of bin(256bp) in one gap, [4]
 -Y <int>    Max number of bin(256bp) in one deviation, [4]
 -x <int>    penalty for BIN gap, [-7]
 -y <int>    penalty for BIN deviation, [-21]
 -l <float>  Min length of alignment, [2048]
 -m <float>  Min matched, [200]
 -A          Keep contained reads during alignment
 -s <float>  Max length variation of two aligned fragments, [0.2]
 -e <int>    Min read depth of a valid edge, [3]
 -q          Quiet
 -v          Verbose (can be multiple)
 --help      Show more options
 ** more options **
 --cpu <int>
   See -t 0, default: all cores
 --input <string> +
   See -i
 --err-free-seq <string> +
   See -I. Error-free sequences will be firstly token for nodes, if --err-free-nodes is specified, only select nodes from those sequences
 --force
   See -f
 --prefix <string>
   See -o
 --kmer-fsize <int>
   See -k 0
 --kmer-psize <int>
   See -p 21
 --kmer-depth-max <float>
   See -K 1000
 --kmer-depth-min <int>
   See -E
 --kmer-depth-min-filter
   See -F
   `wtdbg` uses a 4 Gbytes array to counting the occurence (0-3) of kmers in the way of counting-bloom-filter. It will reduce memory space largely
    Orphaned kmers won't appear in building kbm-index
 --kmer-subampling <int>
   See -S 1
 --aln-kmer-sampling <int>
   Select no more than n seeds in a query bin, default: 256
 --dp-max-gap <int>
   See -X 4
 --dp-max-var <int>
   See -Y 4
 --dp-penalty-gap <int>
   See -x -7
 --dp-penalty-var <int>
   See -y -21
 --aln-min-length <int>
   See -l 2048
 --aln-min-match <int>
   See -m 200. Here the num of matches counting basepair of the matched kmer's regions
 --aln-max-var <float>
   See -s 0.2
 --aln-dovetail <int>
   Retain dovetail overlaps only, the max overhang size is <--aln-dovetail>, -1 to disable filtering, default: 256
 --aln-strand <int>
   1: forward, 2: reverse, 3: both. Please don't change the deault vaule 3, unless you exactly know what you are doing
 --aln-maxhit <int>
   Max n hits for each read in build graph, default: 1000
 --aln-bestn <int>
   Use best n hits for each read in build graph, 0: keep all, default: 500
   <prefix>.alignments always store all alignments
 -A, --aln-noskip
   Even a read was contained in previous alignment, still align it against other reads
 --verbose +
   See -v. -vvvv will display the most detailed information
 --quiet
   See -q
 -L <int>, --tidy-reads=<int>
   Default: 0. Pick longest subreads if possible. Filter reads less than <--tidy-reads>. Rename reads into 'S%010d' format. The first read is named as S0000000001
   Set to 0 bp to disable tidy. Suggested vaule is 5000 for pacbio reads
 --err-free-nodes
   Select nodes from error-free-sequences only. E.g. you have contigs assembled from NGS-WGS reads, and long noisy reads.
   You can type '--err-free-seq your_ctg.fa --input your_long_reads.fa --err-free-nodes' to perform assembly somehow act as long-reads scaffolding
 --limit-input <int>
   Limit the input sequences to at most <int> M bp. Usually for test
 --node-len <int>
   The default value is 1024, which is times of KBM_BIN_SIZE(always equals 256 bp). It specifies the length of intervals (or call nodes after selecting).
   kbm indexs sequences into BINs of 256 bp in size, so that many parameter should be times of 256 bp. There are: --node-len, --node-ovl, --aln-min-length, --aln-dovetail .   Other parameters are counted in BINs, --dp-max-gap, --dp-max-var .
 --node-matched-bins <int>
   Min matched bins in a node, default:1
 --node-ovl <int>
   Default: 256. Max overlap size between two adjacent intervals in any read. It is used in selecting best nodes representing reads in graph
 -e <int>, --edge-min=<int>
   Default: 3. The minimal depth of a valid edge is set to 3. In another word, Valid edges must be supported by at least 3 reads
   When the sequence depth is low, have a try with --edge-min 2. Or very high, try --edge-min 4
 --drop-low-cov-edges
   Don't attempt to rescue low coverage edges
 --node-min <int>
   Min depth of a intreval to be selected as valid node. Defaultly, this value is automaticly the same with --edge-min.
 --node-max <int>
   Nodes with too high depth will be regarded as repetitive, and be masked. Default: 200, more than 200 reads contain this node
 --ttr-cutoff-depth <int>, 0
 --ttr-cutoff-ratio <float>, 0.5
   Tiny Tandom Repeat. A node located inside ttr will bring noisy in graph, should be masked. The pattern of such nodes is:
   depth >= <--ttr-cutoff-depth>, and none of their edges have depth greater than depth * <--ttr-cutoff-ratio 0.5>
   set --ttr-cutoff-depth 0 to disable ttr masking
 --dump-kbm <string>
   Dump kbm index into file for loaded by `kbm` or `wtdbg`
 --load-kbm <string>
   Instead of reading sequences and building kbm index, which is time-consumed, loading kbm-index from already dumped file.
   Please note that, once kbm-index is mmaped by kbm -R <kbm-index> start, will just get the shared memory in minute time.
   See `kbm` -R <your_seqs.kbmidx> [start | stop]
 --load-alignments <string> +
   `wtdbg` output reads' alignments into <--prefix>.alignments, program can load them to fastly build assembly graph. Or you can offer
   other source of alignments to `wtdbg`. When --load-alignment, will only reading long sequences but skip building kbm index
   You can type --load-alignments <file> more than once to load alignments from many files
 --load-clips <string>
   Combined with --load-nodes. Load reads clips. You can find it in `wtdbg`'s <--prefix>.clps
 --load-nodes <sting>
   Load dumped nodes from previous execution for fast construct the assembly graph, should be combined with --load-clips. You can find it in `wtdbg`'s <--prefix>.1.nodes
 --bubble-step <int>
   Max step to search a bubble, meaning the max step from the starting node to the ending node. Default: 40
 --tip-step <int>
   Max step to search a tip, 10
 --ctg-min-length <int>
   Min length of contigs to be output, 5000
 --ctg-min-nodes <int>
   Min num of nodes in a contig to be ouput, 3
 --minimal-output
   Will generate as less output files (<--prefix>.*) as it can
 --bin-complexity-cutoff <int>
   Used in filtering BINs. If a BIN has less indexed valid kmers than <--bin-complexity-cutoff 2>, masks it.
 --no-local-graph-analysis
   Before building edges, for each node, local-graph-analysis reads all related reads and according nodes, and builds a local graph to judge whether to mask it
   The analysis aims to find repetitive nodes
 --no-read-length-sort
   Defaultly, `wtdbg` sorts input sequences by length DSC. The order of reads affects the generating of nodes in selecting important intervals
 --keep-isolated-nodes
   In graph clean, `wtdbg` normally masks isolated (orphaned) nodes
 --no-read-clip
   Defaultly, `wtdbg` clips a input sequence by analyzing its overlaps to remove high error endings, rolling-circle repeats (see PacBio CCS), and chimera.
   When building edges, clipped region won't contribute. However, `wtdbg` will use them in the final linking of unitigs
 --no-chainning-clip
   Defaultly, performs alignments chainning in read clipping
   ** If '--aln-bestn 0 --no-read-clip', alignments will be parsed directly, and less RAM spent on recording alignments
```

