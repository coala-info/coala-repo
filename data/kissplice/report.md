# kissplice CWL Generation Report

## kissplice

### Tool Description
local assembly of SNPs, indels and AS events

### Metadata
- **Docker Image**: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
- **Homepage**: http://kissplice.prabi.fr
- **Package**: https://anaconda.org/channels/bioconda/packages/kissplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kissplice/overview
- **Total Downloads**: 16.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: kissplice [-h] [-r READFILES] [-k KVAL] [-b BVAL] [-l LLMAX]
                 [-m LL_MIN] [-M UL_MAX] [-g GRAPH_PREFIX] [-o OUT_DIR]
                 [-d PATH_TO_TMP] [-t NBPROCS] [-s OUTPUT_SNPS] [-v] [-u]
                 [-c MIN_COV] [-C MIN_RELATIVE_COV] [-e MIN_EDIT_DIST]
                 [-y MAX_CYCLES] [--mismatches MISM] [--mismatchesSNP MISMSNP]
                 [--counts COUNTSMETHOD] [--min_overlap MINOVERLAP]
                 [--timeout TIMEOUT] [--version] [--output-context]
                 [--output-path] [--output-branch-count] [--keep-bccs]
                 [--not-experimental] [--max-memory MAX_MEMORY]
                 [--keep-counts] [--get-mapping-info] [--stranded]
                 [--strandedAbsoluteThreshold STRANDEDABSOLUTETHRESHOLD]
                 [--strandedRelativeThreshold STRANDEDRELATIVETHRESHOLD]
                 [--keep-redundancy] [--keep-low-complexity]
                 [--lc-entropy-threshold LC_ENT] [--get-redundance-info]
                 [--get-low-complexity-info] [--type1-only]

kisSplice - local assembly of SNPs, indels and AS events

options:
  -h, --help            show this help message and exit
  -r READFILES          input fasta/q read files or compressed (.gz) fasta/q
                        files (mutiple, such as "-r file1 -r file2...")
  -k KVAL               k-mer size (default=41)
  -b BVAL               maximum number of branching nodes (default 5)
  -l LLMAX              maximal length of the shorter path (default: 2k+1)
  -m LL_MIN             minimum length of the shorter path (default 2k-8)
  -M UL_MAX             maximum length of the longest path (default 1000000),
                        skipped exons longer than UL_MAX are not reported
  -g GRAPH_PREFIX       path and prefix to pre-built de Bruijn graph (suffixed
                        by .edges/.nodes) if jointly used with -r, graph used
                        to find bubbles and reads used for quantification
  -o OUT_DIR            path to store the results and the summary log file
                        (default = ./results)
  -d PATH_TO_TMP        specific directory (absolute path) where to build
                        temporary files (default temporary directory
                        otherwise)
  -t NBPROCS            number of cores (must be <= number of physical cores)
  -s OUTPUT_SNPS        0, 1 or 2. Changes which types of SNPs will be output.
                        If 0 (default), will not output SNPs. If 1, will
                        output Type0a-SNPs. If 2, will output Type0a and
                        Type0b SNPs (warning: this option may increase a lot
                        the running time. You might also want to try the
                        experimental algorithm here)
  -v                    Verbose mode
  -u                    keep the nodes/edges file for unfinished bccs
  -c MIN_COV            an integer, k-mers present strictly less than this
                        number of times in the dataset will be discarded
                        (default 2)
  -C MIN_RELATIVE_COV   a percentage from [0,1), edges with relative coverage
                        below this number are removed (default 0.05)
  -e MIN_EDIT_DIST      edit distance threshold, if the two sequences (paths)
                        of a bubble have edit distance smaller than this
                        threshold, the bubble is classified as an inexact
                        repeat (default 3)
  -y MAX_CYCLES         maximal number of bubbles enumeration in each bcc. If
                        exceeded, no bubble is output for the bcc (default
                        100M)
  --mismatches MISM     Maximal number of substitutions authorized between a
                        read and a fragment (for quantification only), default
                        2. If you increase the mismatch and use --counts think
                        of increasing min_overlap too.
  --mismatchesSNP MISMSNP
                        Maximal number of substitutions authorized between a
                        read and a fragment (for quantification only) for SNP,
                        default 0.
  --counts COUNTSMETHOD
                        0,1 or 2 . Changes how the counts will be reported. If
                        0 : total counts, if 1: counts on junctions, if 2
                        (default): all counts. see User guide for more
                        information
  --min_overlap MINOVERLAP
                        Set how many nt must overlap a junction to be counted
                        by --counts option. Default=5. see User guide for more
                        information
  --timeout TIMEOUT     max amount of time (in seconds) spent for enumerating
                        bubbles in each bcc. If exceeded, no bubble is output
                        for the bcc (default 100000)
  --version             show program's version number and exit
  --output-context      Will output the maximum non-ambiguous context of a
                        bubble
  --output-path         Will output the id of the nodes composing the two
                        paths of the bubbles.
  --output-branch-count
                        Will output the number of branching nodes in each
                        path.
  --keep-bccs           Keep the node/edges files for all bccs.
  --not-experimental    Do not use a new experimental algorithm that searches
                        for bubbles by listing all paths.
  --max-memory MAX_MEMORY
                        If you use the experimental algorithm, you must
                        provide the maximum size of the process's virtual
                        memory (address space) in megabytes (default
                        unlimited). WARNING: this option does not work on Mac
                        operating systems.
  --keep-counts         Keep the .counts file after the sequencing-errors-
                        removal step.
  --get-mapping-info    Creates a file with the KissReads mapping information
                        of the reads on the bubbles.
  --stranded            Execute kissreads in stranded mode.
  --strandedAbsoluteThreshold STRANDEDABSOLUTETHRESHOLD
                        Sets the minimum number of reads mapping to a path of
                        a bubble in a read set is needed to call a strand.
  --strandedRelativeThreshold STRANDEDRELATIVETHRESHOLD
                        If a strand is called for a path of a bubble in a read
                        set, but the proportion of reads calling this strand
                        is less than this threshold, then the strand of the
                        path is set to '?' (any strand - not enough evidence
                        to call a strand).
  --keep-redundancy     Keep the Type_1 redundant cycles in the result file.
  --keep-low-complexity
                        Keep the low-complexity Type_1 cycles in the result
                        file.
  --lc-entropy-threshold LC_ENT
                        Cycles with a Shannon entropy value for their upper
                        path below this value will be removed (use --keep-low-
                        complexity to keep them).
  --get-redundance-info
                        Creates files with informations on compressed
                        redundant cycles.
  --get-low-complexity-info
                        Creates a file with informations on removed low-
                        complexity cycles.
  --type1-only          Only quantify Type 1 bubbles (alternative splicing
                        events, MAJOR SPEED UP with -b > 10 BUT all other
                        bubbles will not appear in the result file).
```

