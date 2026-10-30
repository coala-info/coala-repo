# mccortex CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mccortex_breakpoints | PASS | Called breakpoints of the sample against the phiX174 reference; calls written. |
| mccortex_bubbles | PASS | Found 40 bubbles between the phiX reference and sample colours. |
| mccortex_build | PASS | Built a phiX174 graph from 1,451 real read pairs (ENA ERR266411); k=31 graph with 17,709 k-mers. |
| mccortex_calls2vcf | PASS | Converted the breakpoint calls to VCF with the four known phiX174 strain SNPs (833, 2731, 2811, 3133). |
| mccortex_check | PASS | Checked the phiX graph; the report log shows it loaded and passed. |
| mccortex_clean | PASS | Cleaned the phiX graph to 5,386 k-mers (genome size); coverage and length histograms written. |
| mccortex_contigs | PASS | Assembled phiX contigs with a link file; 96.6% of 31-mers match phiX174, the rest are real strain SNPs. |
| mccortex_correct | PASS | Corrected the phiX read pairs against the graph with links; corrected FASTA files and gap histogram written. |
| mccortex_coverage | PASS | Coverage of the phiX genome in the cleaned graph written. |
| mccortex_dist | PASS | Distance matrix of the 2-colour phiX graph shows 5,356 and 5,201 shared k-mers. |
| mccortex_index | PASS | Indexed the sorted phiX graph; index file written. Note: --force crashes (segmentation fault) in this build. |
| mccortex_inferedges | PASS | Added edges to the cleaned phiX graph and wrote a new graph. |
| mccortex_join | PASS | Joined the reference and sample phiX graphs into a 2-colour graph. |
| mccortex_links | PASS | Cleaned and listed links of the k=13 phiX graph; list, threshold and coverage histogram written. |
| mccortex_pjoin | PASS | Merged two link files from the k=13 phiX graph into a 2-colour link file. Note: --graph gives Out of memory and --noredundant swallows the next argument in this build. |
| mccortex_popbubbles | PASS | Popped bubbles in the raw phiX graph: 17,709 to 17,425 k-mers. |
| mccortex_pview | PASS | Viewed the links of the k=13 phiX graph as text. |
| mccortex_reads | PASS | Filtered phiX read pairs by the reference graph; 1,428 of 1,451 pairs kept. |
| mccortex_rmsubstr | PASS | Reduced 1,451 reads plus a seed to 1,357 sequences. |
| mccortex_server | PASS | Answered info and k-mer queries read from a file; the k-mer answer shows coverage 37. |
| mccortex_sort | PASS | Sorted the raw phiX graph; k-mers come out in order. |
| mccortex_subgraph | PASS | Pulled 41 k-mers around one seed (31-mer plus 20 each side). |
| mccortex_thread | PASS | Threaded the phiX read pairs through the graph; link file and gap and fragment size histograms written. |
| mccortex_uniqkmers | PASS | Produced 5 random 31-mers that are not in the phiX graph. |
| mccortex_unitigs | PASS | Wrote the phiX unitig as GFA (one circular unitig of about 5.4 kb). |
| mccortex_vcfcov | PASS | Added k-mer coverage to the four phiX SNPs; alt allele coverage 32 to 36. |
| mccortex_vcfgeno | PASS | Genotyped the four phiX SNPs as haploid alt calls. |
| mccortex_view | PASS | Printed header and k-mers of the phiX graph; 17,709 k-mers listed. |

## mccortex_breakpoints

### Tool Description
Use a trusted assembled genome to call large events.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 breakpoints [options] <in.ctx> [in2.ctx ..]

  Use trusted assembled genome to call large events.  Output is gzipped.
  Memory (bytes) is roughly: num_kmers*(8+8+1) + num_ref_kmers*8 + links_mem

  -h, --help              This help message
  -q, --quiet             Silence status output normally printed to STDERR
  -f, --force             Overwrite output files
  -m, --memory <mem>      Memory to use
  -n, --nkmers <kmers>    Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>       Number of threads to use [default: 2]
  -p, --paths <in.ctp>    Load link file (can specify multiple times)
  -o, --out <out.txt.gz>  Save calls (gzipped output) [default: STDOUT]
  -s, --seq <in>          Trusted input (can specify multiple times)
  -r, --minref <N>        Require <N> kmers at ref breakpoint [default: 5]
  -R, --maxref <N>        Stop after <N> kmers at ref breakpoint [default: 1000]
  -E, --no-ref-edges      Don't load edges from the reference
```

## mccortex_bubbles

### Tool Description
Find bubbles in the graph, which are potential variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 bubbles [options] <in.ctx> [in2.ctx ...]

  Find bubbles in the graph, which are potential variants.

  -h, --help              This help message
  -q, --quiet             Silence status output normally printed to STDERR
  -f, --force             Overwrite output files
  -o, --out <bub.txt.gz>  Output file [required]
  -m, --memory <mem>      Memory to use
  -n, --nkmers <kmers>    Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>       Number of threads to use [default: 2]
  -p, --paths <in.ctp>    Load link file (can specify multiple times)
  -H, --haploid <col>     List of haploid colours (e.g. ref colour); '*' means all
  -A, --max-allele <len>  Max bubble branch length in kmers [default: 2000]
  -F, --max-flank <len>   Max flank length in kmers [default: 500]
  -S, --keep-serial       Keep serial bubbles. Use if mapping is hard. Higher FP.

  When loading link files with -p, use offset (e.g. 2:in.ctp) to specify
  which colour to load the data into.
```

## mccortex_build

### Tool Description
Construct a cortex graph from FASTA, FASTQ or BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 build [options] <out.ctx>

  Build a cortex graph.  

  -h, --help               This help message
  -q, --quiet              Silence status output normally printed to STDERR
  -f, --force              Overwrite output files
  -m, --memory <mem>       Memory to use
  -n, --nkmers <kmers>     Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>        Number of threads to use [default: 2]
  -k, --kmer <kmer>        Kmer size must be odd (31 >= k >= 3)
  -s, --sample <name>      Sample name (required before any seq args)
  -1, --seq <in.fa>        Load sequence data
  -2, --seq2 <in1:in2>     Load paired end sequence data
  -i, --seqi <in.bam>      Load paired end sequence from a single file
  -Q, --fq-cutoff <Q>      Filter quality scores [default: 0 (off)]
  -O, --fq-offset <N>      FASTQ ASCII offset    [default: 0 (auto-detect)]
  -H, --cut-hp <bp>        Breaks reads at homopolymers >= <bp> [default: off]
  -p, --remove-pcr         Remove (or keep) PCR duplicate reads
  -P, --keep-pcr           Don't do PCR duplicate removal [default]
  -M, --matepair <orient>  Mate pair orientation: FF,FR,RF,RR [default: FR]
                           (for --keep_pcr only)
  -g, --graph <in.ctx>     Load samples from a graph file (.ctx)
  -I, --intersect <i.ctx>  Only load kmers that appear in i.ctx. Multiple -I
                           graphs will be merged, not intersected. Treated as
                           single colour graphs.
  -S, --sort               Output a graph file ordered by kmer

  Note: Argument must come before input file
  PCR duplicate removal works by ignoring read (pairs) if (both) reads
  start at the same k-mer as any previous read. Carried out per sample, not 
  per file. --sample <name> is required before sequence input can be loaded.
  Consecutive sequence options are loaded into the same colour.
  --graph argument can have colours specifed e.g. in.ctx:0,6-8 will load
  samples 0,6,7,8.  Graphs are loaded into new colours.
  See `mccortex31 join` to combine .ctx files
```

## mccortex_calls2vcf

### Tool Description
Convert bubble or breakpoint calls to VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 calls2vcf [options] <in.txt.gz> <ref.fa> [ref2.fa ...]

  Convert a bubble or breakpoint call file to VCF. If input is a bubble file
  the --mapped <flanks.sam> argument is required.

  -h, --help             This help message
  -q, --quiet            Silence status output normally printed to STDERR
  -f, --force            Overwrite output files
  -o, --out <out.txt>    Save output graph file [default: STDOUT]
  -O, --out-fmt <f>      Format vcf|vcfgz|bcf|ubcf

  -F, --flanks <in.bam>  Mapped flanks in SAM or BAM file (bubble caller only)
  -Q, --min-mapq <Q>     Flank must map with MAPQ >= <Q> [default: 30]
  -A, --max-align <M>    Max alignment attempted [default: 500]
  -L, --max-allele <M>   Max allele length printed [default: 500]

  Alignment scoring:
  -m, --match <m>       [default:  1]
  -M, --mismatch <m>    [default: -2]
  -g, --gap-open <m>    [default: -4]
  -G, --gap-extend <m>  [default: -1]
```

## mccortex_check

### Tool Description
Load and check graph (.ctx) and link (.ctp) files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 check [options] <graph.ctx>
  Load a graph into memory along with any link files to check they are valid.

  -h, --help             This help message
  -q, --quiet            Silence status output normally printed to STDERR
  -m, --memory <mem>     Memory to use
  -n, --nkmers <kmers>   Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>      Number of threads to use [default: 2]
  -p, --paths <in.ctp>   Load link file (can specify multiple times)
  -E, --no-edge-check    Don't check kmer edges
```

## mccortex_clean

### Tool Description
Clean errors from a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 clean [options] <in.ctx> [in2.ctx ...]

  Clean a cortex graph. Joins graphs first, if multiple inputs given.
  If output graph file is not specified just saves output statistics.
  If given a multisample graph, cleans each sample against the merged population.

  -h, --help               This help message
  -q, --quiet              Silence status output normally printed to STDERR
  -f, --force              Overwrite output files
  -o, --out <out.ctx>      Save output graph file [required]
  -m, --memory <mem>       Memory to use
  -n, --nkmers <kmers>     Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>        Number of threads to use [default: 2]
  -N, --ncols <N>          Number of graph colours to use
  -S, --sort               Output a graph file ordered by kmer

  Cleaning:
  -T[L], --tips[=L]        Clip tips shorter than <L> kmers [default: auto]
  -U[X], --unitigs[=X]     Remove low coverage unitigs with median cov < X [default: auto]
  -B, --fallback <T>       Fall back threshold if we can't pick

  Statistics:
  -c, --covg-before <out.csv> Save kmer coverage histogram before cleaning
  -C, --covg-after <out.csv>  Save kmer coverage histogram after cleaning
  -l, --len-before <out.csv>  Save unitig length histogram before cleaning
  -L, --len-after <out.csv>   Save unitig length histogram after cleaning

  --unitigs without a threshold, causes a calculated threshold to be used
  Default: --tips 2*kmer_size --unitigs
  Set thresholds to zero to turn-off cleaning
```

## mccortex_contigs

### Tool Description
Assemble contigs for a sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 contigs [options] <input.ctx> [in2.ctx ...]

  Assemble contigs from the graph, print statistics

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -f, --force           Overwrite output files
  -m, --memory <mem>    Memory to use
  -n, --nkmers <N>      Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>     Number of threads to use [default: 2]
  -o, --out <out.fa>    Print contigs in FASTA [default: don't print]
  -c, --colour <c>      Pull out contigs from the given colour [default: 0]
  -p, --paths <in.ctp>  Load link file (can specify multiple times)
  -N, --ncontigs <N>    Pull out <N> contigs from random kmers [default: 0, no limit]
  -s, --seed <in.fa>    Use seed kmers from a file. Reads must be of kmer length
  -r, --reseed          Sample seed kmers with replacement
  -R, --no-reseed       Do not use a seed kmer if it is used in a contig [default]
  -P, --use-seed-paths  Use unused paths to seed contigs [default: off]
  -G, --genome <G>      Genome size in bases
  -C, --confid-cumul <C>   Halt if cumulative confidence is < C {0..1} [default: off]
  -T, --confid-step <C>    Halt if single step confidence is < C {0..1} [default: off]
  -S, --confid-csv <f.csv> Save confidence table to <save.csv>
  -M, --no-missing-check   Do not use the missing information check
```

## mccortex_correct

### Tool Description
Error correct reads against a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 correct [options] <input.ctx>

  Correct reads against a (population) graph. Uses paths if specified.
  Bases are printed in lower case if they cannot be corrected.

  -h, --help               This help message
  -q, --quiet              Silence status output normally printed to STDERR
  -f, --force              Overwrite output files
  -m, --memory <mem>       Memory to use (e.g. 1M, 20GB)
  -n, --nkmers <N>         Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>        Number of threads to use [default: 2]
  -p, --paths <in.ctp>     Load link file (can specify multiple times)

  Input:
  -1, --seq <in:out>       Correct reads (output: <out>.fa.gz)
  -2, --seq2 <in1:in2:out> Correct reads (output: <out>{,.1,.2}.fa.gz)
  -i, --seqi <in.bam:out>  Correct reads (output: <out>{,.1,.2}.fa.gz)
  -F, --format <f>         Output format may be: FASTA or FASTQ
  -M, --matepair <orient>  Mate pair orientation: FF,FR,RF,RR [default: FR]
  -Q, --fq-cutoff <Q>      Filter quality scores [default: 0 (off)]
  -O, --fq-offset <N>      FASTQ ASCII offset    [default: 0 (auto-detect)]
  -H, --cut-hp <bp>        Breaks reads at homopolymers >= <bp> [default: off]
  -l, --min-frag-len <bp>  Min fragment size for --seq2 [default:0]
  -L, --max-frag-len <bp>  Max fragment size for --seq2 [default:1000]

  Correction:
  -w, --one-way            Use one-way gap filling (conservative)
  -W, --two-way            Use two-way gap filling (liberal)
  -d, --gap-diff-const <d> Set parameters for allowable gap lengths (decimals):
  -D, --gap-diff-coeff <D>   abs(gap_exp - gap_seen) <= gap_exp*D + d
  -X, --max-context        Number of kmers to use either side of a gap
  -e, --end-check          Extra check after bridging gap [default: on]
  -E, --no-end-check       Skip extra check after gap bridging
  -Z, --fq-zero <char>     Replace zero'd quality score with character <char>
  -P, --print-orig         Print original sequence in the read name ('orig=SEQ')
  -g, --gap-hist <o.csv>   Save size distribution of sequence gaps bridged
  -G, --frag-hist <o.csv>  Save size distribution of PE fragments
  -C, --contig-hist <.csv> Save size distribution of assembled contigs

  -c, --colour <col>       Sample graph colour to correct against

  Output is <O>.fq.gz for FASTQ, <O>.fa.gz for FASTA, <O>.txt.gz for plain
  --seq outputs <out>.fa.gz, --seq2 outputs <out>.1.fa.gz, <out>.2.fa.gz
  --seq must come AFTER two/oneway options. Output may be slightly shuffled.
```

## mccortex_coverage

### Tool Description
Print contig coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 coverage [options] <in.ctx> [in2.ctx ..]

  Print contig coverage

  -h, --help           This help message
  -q, --quiet          Silence status output normally printed to STDERR
  -f, --force          Overwrite output files
  -m, --memory <mem>   Memory to use (e.g. 1M, 20GB)
  -n, --nkmers <N>     Number of hash table entries (e.g. 1G ~ 1 billion)
  -e, --edges          Print edges as well. Uses hex encoding [TGCA|TGCA].
  -E, --degree         Print edge degree: 00. 01/ 02[ 10\ 11- 12{ 20] 21} 22X
  -s, --seq <in>       Sequence file to get coverages for (can specify multiple times)
  -o, --out <out.txt>  Save output [default: STDOUT]
```

## mccortex_dist

### Tool Description
Make a colour k-mer distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 dist [options] <in.ctx> [in2.ctx ...]

  Generate a distance matrix counting kmers shared between colours.

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -f, --force           Overwrite output files
  -m, --memory <mem>    Memory to use
  -n, --nkmers <kmers>  Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>     Number of threads to use [default: 2]
  -o, --out <out.csv>   Ouput matrix, tab separated [defaults to STDOUT]
```

## mccortex_index

### Tool Description
Index a sorted cortex graph file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 index [options] <in.ctx>

  Index a sorted cortex graph file (sort with `mccortex31 sort` first).

  -h, --help               This help message
  -q, --quiet              Silence status output normally printed to STDERR
  -f, --force              Overwrite output files
  -o, --out <out.ctx.idx>  Output file [default: STDOUT]
  -s, --block-size <S>     Block of <S> bytes [default: 4MB]
  -b, --block-kmers <B>    Block of <B> kmers
```

## mccortex_inferedges

### Tool Description
Infer graph edges between k-mers before calling thread.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 inferedges [options] <pop.ctx>

  Infer edges adds edges between all kmers that share k-1 bases.
  By default adds all missing edges (--all). To add only edges that exist in
  at least one other sample in the population, use --pop.
  It is important that you run this step before doing read threading.

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -f, --force           Overwrite output files
  -o, --out <out.ctx>   Save output graph file
  -m, --memory <mem>    Memory to use (e.g. 1M, 20GB)
  -n, --nkmers <N>      Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>     Number of threads to use [default: 2]
  -P, --pop             Add edges that are in the union only
  -A, --all             Add all edges [default]
```

## mccortex_join

### Tool Description
Combine graphs, filter graph intersections.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 join [options] in1.ctx [[offset:]in2.ctx[:1,2,4-5] ...]

  Merge cortex graphs.

  -h, --help              This help message
  -q, --quiet             Silence status output normally printed to STDERR
  -f, --force             Overwrite output files
  -o, --out <out.ctx>     Output file [required]
  -m, --memory <mem>      Memory to use
  -n, --nkmers <kmers>    Number of hash table entries (e.g. 1G ~ 1 billion)
  -N, --ncols <c>         How many colours to load at once [default: 1]
  -i, --intersect <a.ctx> Only load the kmers that are in graph A.ctx. Can be
                          specified multiple times. <a.ctx> is NOT merged into
                          the output file.
  -S, --sort              Output sorted graph file

  Files can be specified with specific colours: samples.ctx:2,3
  Offset specifies where to load the first colour: 3:samples.ctx
```

## mccortex_links

### Tool Description
Clean and plot link files (.ctp).

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 links [options] <in.ctp.gz>

  Clean, minimise and list cortex links. Works on a stream of input only,
  so memory usage is very low.

  -h,--help               This help message
  -q,--quiet              Silence status output normally printed to STDERR
  -f,--force              Overwrite output files
  -o,--out <out.ctp.gz>   Save output link file [default: STDOUT]

  -L,--limit <N>          Only use links from first N kmers

One or more of:
  -l,--list <out.txt>     List as CSV links
  -P,--plot <out.dot>     Plot last from limit
  -c,--clean <N>          Remove junction choices with coverage < N
  -T,--threshold <t.txt>  Calculate the cleaning threshold, write to file
  -H,--covg-hist <f.csv>  Write link coverage matrix to a csv file
  -D,--max-dist <max>     Set max dist when using --covg-hist ...
  -C,--max-covg <max>     Set max covg when using --covg-hist ...
```

## mccortex_pjoin

### Tool Description
Merge link files (.ctp).

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 pjoin [options] <in1.ctp.gz> [[offset:]in2.ctp[:0,2-4] ...]

  Merge cortex link files.

  -h, --help             This help message
  -q, --quiet            Silence status output normally printed to STDERR
  -f, --force            Overwrite output files
  -o, --out <out.ctp.gz> Output file [required]
  -m, --memory <mem>     Memory to use (required) recommend 80G for human
  -n, --nkmers <nkmers>  Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>      Number of threads to use [default: 2]
  -g, --graph <in.ctx>   Get number of hash table entries from graph file
  -c, --outcols <C>      How many 'colours' should the output file have
  -r, --noredundant      Remove redundant paths

  Files can be specified with specific colours: samples.ctp:2,3
  Offset specifies where to load the first colour: 3:samples.ctp
```

## mccortex_popbubbles

### Tool Description
Pop bubbles in the population graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 pop [options] <in.ctx> [in2.ctx ...]

  Pop bubbles in the graph. All graphs are loaded and treated as one colour
  for bubble popping. Output is a multicolour graph.

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -f, --force           Overwrite output files
  -o, --out <out.ctx>   Output file [required]
  -m, --memory <mem>    Memory to use
  -n, --nkmers <kmers>  Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>     Number of threads to use [default: 2]
  -C, --max-covg <C>    Only remove branches whose mean coverage is less than <C>
  -L, --max-len <L>     Only remove branches whose lengths are less than <L> kmers
  -D, --max-diff <D>    Only pop bubbles whose branch lengths are within <D> kmers
```

## mccortex_pview

### Tool Description
Text view of a cortex link file (.ctp).

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 pview [options] [-p <in.ctp>] <in.ctx> [in2.ctx ...]

  View cortex link files (.ctp).

  -h, --help             This help message
  -q, --quiet            Silence status output normally printed to STDERR
  -m, --memory <mem>     Memory to use
  -n, --nkmers <kmers>   Number of hash table entries (e.g. 1G ~ 1 billion)
  -p, --paths <in.ctp>   Load link file (can specify multiple times)
```

## mccortex_reads

### Tool Description
Filter reads against a graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 reads [options] <in.ctx>[:cols] [in2.ctx ...]

  Filters reads based on which have a kmer in the graph. 

  -h, --help                  This help message
  -q, --quiet                 Silence status output normally printed to STDERR
  -f, --force                 Overwrite output files
  -m, --memory <mem>          Memory to use
  -n, --nkmers <kmers>        Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>           Number of threads to use [default: 2]
  -F, --format <f>            Output format may be: FASTA, FASTQ [default: FASTQ]
  -v, --invert                Print reads/read pairs with no kmer in graph
  -1, --seq  <in>:<O>         Writes output to <O>.fq.gz
  -2, --seq2 <in1>:<in2>:<O>  Writes output to <O>.{1,2}.fq.gz
  -i, --seqi <in>:<O>         Writes output to <O>.{1,2}.fq.gz

  Output is <O>.fq.gz for FASTQ, <O>.fa.gz for FASTA, <O>.txt.gz for plain
  Paired reads are saved to e.g. <O>.1.fq.gz, <O>.2.fq.gz, and unpaired reads
  to <O>.fq.gz.

  User can specify --seq/--seq2/--seqi multiple times. If either read of a
  pair touches the graph, both are printed.
```

## mccortex_rmsubstr

### Tool Description
Reduce a set of strings to remove substrings.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 rmsubstr [options] <in.fa> [in2.fq ...]

  Remove duplicate sequences and those that occur as substrings of others.
  Matching is case insensitive and includes matching reverse complement.

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -f, --force           Overwrite output files
  -o, --out <out.txt>   Save output [default: STDOUT]
  -m, --memory <mem>    Memory to use
  -n, --nkmers <kmers>  Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>     Number of threads to use [default: 2]
  -k, --kmer <kmer>     Kmer size must be odd (31 >= k >= 3)
  -F, --format <f>      Output format may be: FASTA, FASTQ [default: FASTQ]
  -v, --invert          Only print strings that are substrings
```

## mccortex_server

### Tool Description
Interactively query the graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 server [options] <in.ctx> [in2.ctx ...]

  Interactively query the graph. Responds to STDOUT with JSON.
  Commands are:
  * 'info'     - print graph header
  * 'random'   - print a random kmer
  * 'ACACCAA'  - print information for the given kmer

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -m, --memory <mem>    Memory to use
  -n, --nkmers <kmers>  Number of hash table entries (e.g. 1G ~ 1 billion)
  -p, --paths <in.ctp>  Load link file (can specify multiple times)
  -S, --single-line     Reponses on a single line
  -C, --coverages       Load coverages for kmers+links
  -E, --edges           Load per sample edges
  -D, --disk            Read from disk (one graph only, must be sorted)
```

## mccortex_sort

### Tool Description
Sort the k-mers in a graph file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 sort [options] <in.ctx>

  Sort a cortex graph file. Loads entire graph into memory then sorts.

  -h, --help              This help message
  -q, --quiet             Silence status output normally printed to STDERR
  -f, --force             Overwrite output files
  -m, --memory <mem>      Memory to use
  -n, --nkmers <kmers>    Number of hash table entries (e.g. 1G ~ 1 billion)
  -o, --out <out.ctx>     Output file [default: overwrite input]
```

## mccortex_subgraph

### Tool Description
Filter a subgraph using seed k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 subgraph [options] <in.ctx>[:cols] [in2.ctx ...]

  Loads graphs (in.ctx) and dumps a graph (out.ctx) that contains all kmers within
  <dist> edges of kmers in <seeds.fa>.  Maintains number of colours / covgs etc.
  Loads seed files twice: 1) get seed; 2) extend;  This lowers memory requirement
  for large (seed) graphs but means seed files cannot be pipes / sockets.

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -f, --force           Overwrite output files
  -o, --out <out.ctx>   Save output graph file [required]
  -m, --memory <mem>    Memory to use
  -n, --nkmers <kmers>  Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>     Number of threads to use [default: 2]
  -N, --ncols <c>       How many colours to load at once [default: 1]
  -1, --seq <seed.fa>   Read in a seed file [require at least one]
  -d, --dist <N>        Number of kmers to extend by [default: 0]
  -v, --invert          Dump kmers not in subgraph
  -U, --unitigs         Grab entire runs of kmers that are touched by a read
```

## mccortex_thread

### Tool Description
Thread reads through a cleaned graph to make links.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 thread [options] <in.ctx>

  Thread reads through the graph.  Save to file <out.ctp>.  <pop.ctx> can should
  have everyone in it and can be a pooled graph (with only 1 colour).  Samples
  are loaded from <in.ctx> files one at a time.

  -h, --help               This help message
  -q, --quiet              Silence status output normally printed to STDERR
  -f, --force              Overwrite output files
  -o, --out <out.ctp.gz>   Save output file [required]
  -m, --memory <mem>       Memory to use (e.g. 1M, 20GB)
  -n, --nkmers <N>         Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>        Number of threads to use [default: 2]
  -p, --paths <in.ctp>     Load link file (can specify multiple times)
  -0, --zero-paths         Zero counts on initially loaded links. Use if existing
                           links were built from sequence being re-used by this run

  Input:
  -1, --seq <in.fa>        Thread reads from file (supports sam,bam,fq,*.gz
  -2, --seq2 <in1:in2>     Thread paired end sequences
  -i, --seqi <in.bam>      Thread PE reads from a single file
  -M, --matepair <orient>  Mate pair orientation: FF,FR,RF,RR [default: FR]
  -Q, --fq-cutoff <Q>      Filter quality scores [default: 0 (off)]
  -O, --fq-offset <N>      FASTQ ASCII offset    [default: 0 (auto-detect)]
  -H, --cut-hp <bp>        Breaks reads at homopolymers >= <bp> [default: off]
  -l, --min-frag-len <bp>  Min fragment size for --seq2 [default:0]
  -L, --max-frag-len <bp>  Max fragment size for --seq2 [default:1000]

  Link Params:
  -w, --one-way            Use one-way gap filling (conservative) [default]
  -W, --two-way            Use two-way gap filling (liberal)
  -d, --gap-diff-const <d> Set parameters for allowable gap lengths (decimals):
  -D, --gap-diff-coeff <D>   abs(gap_exp - gap_seen) <= gap_exp*D + d
  -X, --max-context        Number of kmers to use either side of a gap
  -e, --end-check          Extra check after bridging gap [default: on]
  -E, --no-end-check       Skip extra check after gap bridging
  -g, --gap-hist <o.csv>   Save size distribution of sequence gaps bridged
  -G, --frag-hist <o.csv>  Save size distribution of PE fragments

  -u, --use-new-paths      Use links as they are being added (higher err rate) [default: no]

  Debugging Options: Probably best not to touch these
    -x,--print-contigs -y,--print-paths -z,--print-reads

  When loading existing links with -p, use offset (e.g. 2:in.ctp) to specify
  which colour to load the data into. See `mccortex31 pjoin` to combine .ctp files
```

## mccortex_uniqkmers

### Tool Description
Generate random unique k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 uniqkmers [options] <N>

  Generate <N> random unique kmers not in the graph.

  -h, --help              This help message
  -q, --quiet             Silence status output normally printed to STDERR
  -f, --force             Overwrite output files
  -o, --out <bub.fa>      Output file [default: STDOUT]
  -m, --memory <mem>      Memory to use
  -n, --nkmers <kmers>    Number of hash table entries (e.g. 1G ~ 1 billion)
  -k, --kmer <K>          Kmer size (required if only giving --seq input)
  -g, --graph <in.ctx>    Load kmers from the graph file
  -1, --seq <in.fa>       Load kmers from a sequence file [SAM/BAM/FASTQ etc.]
  -F, --flank <in.fa>     Add flanking kmers to <in.fa>
```

## mccortex_unitigs

### Tool Description
Pull out unitigs in FASTA, DOT or GFA format.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 unitigs [options] <in.ctx> [<in2.ctx> ...]

  Print unitigs with k-1 bases of overlap.

  -h, --help            This help message
  -q, --quiet           Silence status output normally printed to STDERR
  -f, --force           Overwrite output files
  -o, --out <out.txt>   Save output graph file [default: STDOUT]
  -m, --memory <mem>    Memory to use
  -n, --nkmers <kmers>  Number of hash table entries (e.g. 1G ~ 1 billion)
  -t, --threads <T>     Number of threads to use [default: 2]
  -F, --fasta           Print in FASTA format (default)
  -g, --gfa             Print in Graphical Fragment Assembly (GFA) format
  -d, --dot             Print in graphviz (DOT) format
  -P, --points          Used with --dot, print contigs as points

  e.g. mccortex31 unitigs --dot in.ctx | dot -Tpdf > in.pdf
```

## mccortex_vcfcov

### Tool Description
Coverage of a VCF against cortex graphs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 vcfcov [options] <in.vcf> <in.ctx> [in2.ctx ...]

  Add coverage to a VCF using cortex graphs. It is recommended to use
  uncleaned graphs. The VCF must be sorted by position, with duplicates removed
  Indels ought to be left aligned to remove duplicates.

  -h, --help             This help message
  -q, --quiet            Silence status output normally printed to STDERR
  -f, --force            Overwrite output files
  -m, --memory <mem>     Memory to use
  -n, --nkmers <kmers>   Number of hash table entries (e.g. 1G ~ 1 billion)
  -o, --out <out.vcf>    Output file [default: STDOUT]
  -O, --out-fmt <f>      Format vcf|vcfgz|bcf|ubcf
  -r, --ref <ref.fa>     Reference file [required]
  -L, --max-var-len <A>  Only use alleles <= A bases long [default: 100]
  -N, --max-nvars <N>    Limit haplotypes to <= N variants [default: 8]
  -M, --low-mem          Two-passes of VCF to only load needed kmers [default]
  -H, --high-mem         One-pass of VCF, all kmers loaded (when streaming VCF)
```

## mccortex_vcfgeno

### Tool Description
Genotype a VCF after running vcfcov.

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 vcfgeno [options] <in.vcf>

  Genotype a VCF after running vcfcov to add sample coverage. VCF does not
  need to be sorted. Currently only supports biallelic and ploidy 1 or 2.

  -h, --help           This help message
  -q, --quiet          Silence status output normally printed to STDERR
  -f, --force          Overwrite output files
  -o, --out <out.vcf>  Output file [default: STDOUT]
  -O, --out-fmt <f>    Format vcf|vcfgz|bcf|ubcf
  -E, --err <E>        List of sample error rates (per bp) [0.01]
  -D, --cov <C>        List of genome coverage per colour
  -C, --kcov <C>       List of kmer coverage per colour
  -P, --ploidy <P>     <ploidy> or sample:chr:ploidy (can be used repeatedly)
                       'sample' and 'chr' can be comma-separated lists
                       '.' means all. Be careful: applied in order.
  -l, --llk            Print all log likelihoods
  -r, --rm-cov         Remove tags set by 'vcfcov' command
  -R, --read-len <R>   List to override read lengths [optional]

  Notes: 
  1. Lists are comma-separated. If given a single value it will apply to all colours.
  2. User must give exactly one of --cov, --kcov
  3. 'kmer coverage' is calculated by: D * (R - k + 1) / R  where:
       D is sequence depth (X);  R is read length;  k is kmer size
     Or calculate with: `mccortex31 view <graph.ctx>`
     Or look at output from: mccortex31 clean <graph.ctx>

 Human ploidy example:
   mccortex31 vcfgeno \
      --cov 21,42,30 \
      --ploidy .:.:2 --ploidy .:Y:0 --ploidy John,Tom:X,Y:1 \
      in.vcf > out.vcf
```

## mccortex_view

### Tool Description
Text view of a cortex graph file (.ctx).

### Metadata
- **Docker Image**: quay.io/biocontainers/mccortex:1.0--h24782f9_7
- **Homepage**: https://github.com/mcveanlab/mccortex
- **Package**: https://anaconda.org/channels/bioconda/packages/mccortex/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mccortex31 view [options] <in.ctx>

  View a cortex graph as a list of kmers with coverage and edges

  -h, --help   This help message
  -q, --quiet  Silence status output normally printed to STDERR

  -k, --kmers  Print kmers
  -c, --check  Check kmers
  -i, --info   Print info

 Default is [--info --check]
```

