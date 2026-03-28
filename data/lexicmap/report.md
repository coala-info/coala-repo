# lexicmap CWL Generation Report

## lexicmap_autocompletion

### Tool Description
Generate shell autocompletion scripts

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Total Downloads**: 4.8K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/shenwei356/LexicMap
- **Stars**: N/A
### Original Help Text
```text
Generate shell autocompletion scripts

Supported shell: bash|zsh|fish|powershell

Bash:

    # generate completion shell
    lexicmap autocompletion --shell bash

    # configure if never did.
    # install bash-completion if the "complete" command is not found.
    echo "for bcfile in ~/.bash_completion.d/* ; do source \$bcfile; done" >> ~/.bash_completion
    echo "source ~/.bash_completion" >> ~/.bashrc

Zsh:

    # generate completion shell
    lexicmap autocompletion --shell zsh --file ~/.zfunc/_lexicmap

    # configure if never did
    echo 'fpath=( ~/.zfunc "${fpath[@]}" )' >> ~/.zshrc
    echo "autoload -U compinit; compinit" >> ~/.zshrc

fish:

    lexicmap autocompletion --shell fish --file ~/.config/fish/completions/lexicmap.fish

Usage:
  lexicmap autocompletion [flags] 

Flags:
      --file string    autocompletion file (default "/root/.bash_completion.d/lexicmap.sh")
  -h, --help           help for autocompletion
      --shell string   autocompletion type (bash|zsh|fish|powershell) (default "bash")

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```


## lexicmap_index

### Tool Description
Generate an index from FASTA/Q sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Generate an index from FASTA/Q sequences

Input:
 *1. Sequences of each reference genome should be saved in separate FASTA/Q files, with reference identifiers
     in the file names.
  2. Input plain or gzip/xz/zstd/bzip2 compressed FASTA/Q files can be given via positional arguments or
     the flag -X/--infile-list with a list of input files.
     Flag -S/--skip-file-check is optional for skipping file checking if you trust the file list.
  3. Input can also be a directory containing sequence files via the flag -I/--in-dir, with multiple-level
     sub-directories allowed. A regular expression for matching sequencing files is available via the flag
     -r/--file-regexp.
  4. Some non-isolate assemblies might have extremely large genomes (e.g., GCA_000765055.1, >150 mb).
     The flag -g/--max-genome is used to skip these input files, and the file list would be written to a file
     (-G/--big-genomes).
     Changes since v0.5.0: 
       - Genomes with any single contig larger than the threshold will be skipped as before.
       - However, fragmented (with many contigs) genomes with the total bases larger than the threshold will
         be split into chunks and alignments from these chunks will be merged in "lexicmap search".
     You need to increase the value for indexing fungi genomes.
  5. Maximum genome size: 268,435,456.
     More precisely: $total_bases + ($num_contigs - 1) * 1000 <= 268,435,456, as we concatenate contigs with
     1000-bp intervals of N’s to reduce the sequence scale to index.
  6. A flag -l/--min-seq-len can filter out sequences shorter than the threshold (default is the k value).

  Attention:
   *1) ► You can rename the sequence files for convenience, e.g., GCF_000017205.1.fa.gz, because the genome
       identifiers in the index and search result would be: the basenames of files with common FASTA/Q file
       extensions removed, which are extracted via the flag -N/--ref-name-regexp.
       ► The extracted genome identifiers better be distinct, which will be shown in search results
       and are used to extract subsequences in the command "lexicmap utils subseq".
    2) ► Unwanted sequences like plasmids can be filtered out by content in FASTA/Q header via regular
       expressions (-B/--seq-name-filter).
    3) All degenerate bases are converted to their lexicographic first bases. E.g., N is converted to A.
        code  bases    saved
        A     A        A
        C     C        C
        G     G        G
        T/U   T        T

        M     A/C      A
        R     A/G      A
        W     A/T      A
        S     C/G      C
        Y     C/T      C
        K     G/T      G

        V     A/C/G    A
        H     A/C/T    A
        D     A/G/T    A
        B     C/G/T    C

        N     A/C/G/T  A

Important parameters:

  --- Genome data ---
 *1. -b/--batch-size,       ► Maximum number of genomes in each batch (maximum: 131072, default: 5000).
                            ► If the number of input files exceeds this number, input files are split into multiple
                            batches and indexes are built for all batches. In the end, seed files are merged, while
                            genome data files are kept unchanged and collected.
                            ■ Bigger values increase indexing memory occupation and increase batch searching speed,
                            while single query searching speed is not affected.

  --- LexicHash mask generation ---
  0. -M/--mask-file,        ► File with custom masks, which could be exported from an existing index or newly
                            generated by "lexicmap utils masks".
                            This flag oversides -k/--kmer, -m/--masks, -s/--rand-seed, etc.
 *1. -k/--kmer,             ► K-mer size (maximum: 32, default: 31).
                            ■ Bigger values improve the search specificity and do not increase the index size.
 *2. -m/--masks,            ► Number of LexicHash masks (default: 20000).
                            ■ Bigger values improve the search sensitivity slightly, increase the index size,
                            and slow down the search (seed matching) speed.

  --- Seeds data (k-mer-value data) ---
 *1. --seed-max-desert      ► Maximum length of distances between seeds (default: 100).
                            The default value of 100 guarantees queries >=200 bp would match at least two seeds.
                            ► Large regions with no seeds are called sketching deserts. Deserts with seed distance
                            larger than this value will be filled by choosing k-mers roughly every
                            --seed-in-desert-dist (50 by default) bases.
                            ■ Big values decrease the search sensitivity for distant targets, speed up the indexing
                            speed, decrease the indexing memory occupation and decrease the index size. While the
                            alignment speed is almost not affected.
  2. -c/--chunks,           ► Number of seed file chunks (maximum: 128, default: value of -j/--threads).
                            ► Bigger values accelerate the search speed at the cost of a high disk reading load.
                            The maximum number should not exceed the maximum number of open files set by the
                            operating systems.
                            ► Make sure the value of '-j/--threads' in 'lexicmap search' is >= this value.
 *3. -J/--seed-data-threads ► Number of threads for writing seed data and merging seed chunks from all batches
                            (maximum: -c/--chunks, default: 8).
                            ■ The actual value is min(--seed-data-threads, max(1, --max-open-files/($batches_1_round + 2))),
                            where $batches_1_round = min(int($input_files / --batch-size), --max-open-files).
                            ■ Bigger values increase indexing speed at the cost of slightly higher memory occupation.
  4. --partitions,          ► Number of partitions for indexing each seed file (default: 4096).
                            ► Bigger values bring a little higher memory occupation.
                            ► After indexing, "lexicmap utils reindex-seeds" can be used to reindex the seeds data
                            with another value of this flag.
 *5. --max-open-files,      ► Maximum number of open files (default: 1024).
                            ► It's only used in merging indexes of multiple genome batches. If there are >100 batches,
                            ($input_files / --batch-size), please increase this value and set a bigger "ulimit -n" in shell.

Usage:
  lexicmap index [flags] [-k <k>] [-m <masks>] {-I <seqs dir> | [-S] -X <file list>} -O <index.lmi>

Flags:
  -b, --batch-size int            ► Maximum number of genomes in each batch (maximum value: 131072)
                                  (default 5000)
  -G, --big-genomes string        ► Out file of skipped files with $total_bases + ($num_contigs - 1) *
                                  $contig_interval >= -g/--max-genome. The second column is one of the
                                  skip types: no_valid_seqs, too_large_genome, too_many_seqs.
  -c, --chunks int                ► Number of chunks for storing seeds (k-mer-value data) files. Max:
                                  128. Default: the value of -j/--threads. (default 20)
      --contig-interval int       ► Length of interval (N's) between contigs in a genome. It can't be
                                  too small (<1000) or some alignments might be fragmented (default 1000)
      --debug                     ► Print debug information.
  -r, --file-regexp string        ► Regular expression for matching sequence files in -I/--in-dir,
                                  case ignored. Attention: use double quotation marks for patterns
                                  containing commas, e.g., -p '"A{2,}"'. (default
                                  "\\.(f[aq](st[aq])?|fna)(\\.gz|\\.xz|\\.zst|\\.bz2)?$")
      --force                     ► Overwrite existing output directory.
  -h, --help                      help for index
  -I, --in-dir string             ► Input directory containing FASTA/Q files. Directory and file
                                  symlinks are followed.
  -k, --kmer int                  ► Maximum k-mer size. K needs to be <= 32. (default 31)
  -M, --mask-file string          ► File of custom masks. This flag oversides -k/--kmer, -m/--masks,
                                  -s/--rand-seed etc.
  -m, --masks int                 ► Number of LexicHash masks. (default 20000)
  -g, --max-genome int            ► Maximum genome size. Genomes with any single contig larger than
                                  the threshold will be skipped, while fragmented (with many contigs)
                                  genomes larger than the threshold will be split into chunks and
                                  alignments from these chunks will be merged in "lexicmap search". The
                                  value needs to be smaller than the maximum supported genome size:
                                  268435456. (default 15000000)
      --max-open-files int        ► Maximum opened files, used in merging indexes. If there are >100
                                  batches, please increase this value and set a bigger "ulimit -n" in
                                  shell. (default 1024)
  -l, --min-seq-len int           ► Maximum sequence length to index. The value would be k for values
                                  <= 0. (default -1)
      --no-desert-filling         ► Disable sketching desert filling (only for debug).
  -O, --out-dir string            ► Output LexicMap index directory.
      --partitions int            ► Number of partitions for indexing seeds (k-mer-value data) files.
                                  The value needs to be the power of 4. (default 4096)
  -s, --rand-seed int             ► Rand seed for generating random masks. (default 1)
  -N, --ref-name-regexp string    ► Regular expression (must contains "(" and ")") for extracting the
                                  reference name from the filename. Attention: use double quotation
                                  marks for patterns containing commas, e.g., -p '"A{2,}"'. (default
                                  "(?i)(.+)\\.(f[aq](st[aq])?|fna)(\\.gz|\\.xz|\\.zst|\\.bz2)?$")
      --save-seed-pos             ► Save seed positions, which can be inspected with "lexicmap utils
                                  seed-pos".
  -J, --seed-data-threads int     ► Number of threads for writing seed data and merging seed chunks
                                  from all batches, the value should be in range of [1, -c/--chunks]. If
                                  there are >100 batches, please also increase the value of
                                  --max-open-files and set a bigger "ulimit -n" in shell. (default 8)
  -d, --seed-in-desert-dist int   ► Distance of k-mers to fill deserts. (default 50)
  -D, --seed-max-desert int       ► Maximum length of sketching deserts, or maximum seed distance.
                                  Deserts with seed distance larger than this value will be filled by
                                  choosing k-mers roughly every --seed-in-desert-dist bases. (default 100)
  -B, --seq-name-filter strings   ► List of regular expressions for filtering out sequences by
                                  contents in FASTA/Q header/name, case ignored.
  -S, --skip-file-check           ► Skip input file checking when given files or a file list.

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```


## lexicmap_search

### Tool Description
Search sequences against an index

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Search sequences against an index

Attention:
  1. Input should be (gzipped) FASTA or FASTQ records from files or stdin.
  2. One or more input files are accepted, via positional parameters
     and/or a file list via the flag -X/--infile-list.
  3. For multiple queries, the order of queries in output might be different from the input.

Tips:
  1. When using -a/--all, the search result would be formatted to Blast-style format
     with 'lexicmap utils 2blast'. And the search speed would be slightly slowed down.
  2. Alignment result filtering is performed in the final phase, so stricter filtering criteria,
     including -q/--min-qcov-per-hsp, -Q/--min-qcov-per-genome, and -i/--align-min-match-pident,
     do not significantly accelerate the search speed. Hence, you can search with default
     parameters and then filter the result with tools like awk or csvtk.
  3. Users can limit search by TaxId(s) via -t/--taxids or --taxid-file.
     Only genomes with descendant TaxIds of the specific ones or themselves are searched,
     in a similar way with BLAST+ 2.15.0 or later versions.
     Negative values are allowed as a black list.

     For example, searching non-Escherichia (561) genera of Enterobacteriaceae (543) family with
     -t 543,-561.

     Users only need to provide NCBI-format taxdump files (-T/--taxdump, can also create from
     any taxonomy data with TaxonKit https://bioinf.shenwei.me/taxonkit/usage/#create-taxdump )
     and a genome-ID-to-TaxId mapping file (-G/--genome2taxid).
     There's no need to rebuild the index.

Alignment result relationship:

  Query
  ├── Subject genome
      ├── Subject sequence
          ├── HSP cluster (a cluster of neighboring HSPs)
              ├── High-Scoring segment Pair (HSP)

  Here, the defination of HSP is similar with that in BLAST. Actually there are small gaps in HSPs.

  > A High-scoring Segment Pair (HSP) is a local alignment with no gaps that achieves one of the
  > highest alignment scores in a given search. https://www.ncbi.nlm.nih.gov/books/NBK62051/

Output format:
  Tab-delimited format with 20+ columns, with 1-based positions.

    1.  query,    Query sequence ID.
    2.  qlen,     Query sequence length.
    3.  hits,     Number of subject genomes.
    4.  sgenome,  Subject genome ID.
    5.  sseqid,   Subject sequence ID.
    6.  qcovGnm,  Query coverage (percentage) per genome: $(aligned bases in the genome)/$qlen.
    7.  cls,      Nth HSP cluster in the genome. (just for improving readability)
                  It's useful to show if multiple adjacent HSPs are collinear.
    8.  hsp,      Nth HSP in the genome.         (just for improving readability)
    9.  qcovHSP   Query coverage (percentage) per HSP: $(aligned bases in a HSP)/$qlen.
    10. alenHSP,  Aligned length in the current HSP.
    11. pident,   Percentage of identical matches in the current HSP.
    12. gaps,     Gaps in the current HSP.
    13. qstart,   Start of alignment in query sequence.
    14. qend,     End of alignment in query sequence.
    15. sstart,   Start of alignment in subject sequence.
    16. send,     End of alignment in subject sequence.
    17. sstr,     Subject strand.
    18. slen,     Subject sequence length.
    19. evalue,   Expect value.
    20. bitscore, Bit score.
    21. cigar,    CIGAR string of the alignment.                      (optional with -a/--all)
    22. qseq,     Aligned part of query sequence.                     (optional with -a/--all)
    23. sseq,     Aligned part of subject sequence.                   (optional with -a/--all)
    24. align,    Alignment text ("|" and " ") between qseq and sseq. (optional with -a/--all)

Result ordering:
  For a HSP cluster, SimilarityScore = max(bitscore*pident)
  1. Within each HSP cluster, HSPs are sorted by sstart.
  2. Within each subject genome, HSP clusters are sorted in descending order by SimilarityScore.
  3. Results of multiple subject genomes are sorted by the highest SimilarityScore of HSP clusters.

Usage:
  lexicmap search [flags] -d <index path> [query.fasta[.gz] ...] [-o result.tsv[.gz]]

Flags:
      --align-band int                 ► Band size in backtracking the score matrix (pseudo alignment
                                       phase). (default 100)
      --align-ext-len int              ► Extend length of upstream and downstream of seed regions, for
                                       extracting query and target sequences for alignment. It should be
                                       <= contig interval length in database. (default 1000)
      --align-max-gap int              ► Maximum gap in a HSP segment. (default 20)
  -l, --align-min-match-len int        ► Minimum aligned length in a HSP segment. (default 50)
  -i, --align-min-match-pident float   ► Minimum base identity (percentage) in a HSP segment. (default 70)
  -a, --all                            ► Output more columns, e.g., matched sequences. Use this if you
                                       want to output blast-style format with "lexicmap utils 2blast".
      --debug                          ► Print debug information, including a progress bar.
                                       (recommended when searching with one query).
      --gc-interval int                ► Force garbage collection every N queries (0 for disable). The
                                       value can't be too small. (default 64)
  -G, --genome2taxid string            ► Two-column tabular file for mapping genome ID to TaxId,
                                       needed for filtering results with TaxIds. Genome IDs in the index
                                       can be exported via "lexicmap utils genomes -d db.lmi/ | csvtk
                                       cut -t -f 1 | csvtk uniq -Ut"
  -h, --help                           help for search
  -d, --index string                   ► Index directory created by "lexicmap index".
  -k, --keep-genomes-without-taxid     ► Keep genome hits without TaxId, i.e., those without TaxId in
                                       the --genome2taxid file.
  -w, --load-whole-seeds               ► Load the whole seed data into memory for faster seed
                                       matching. It will consume a lot of RAM.
  -e, --max-evalue float               ► Maximum evalue of a HSP segment. (default 10)
      --max-open-files int             ► Maximum opened files. It mainly affects candidate subsequence
                                       extraction. Increase this value if you have hundreds of genome
                                       batches or have multiple queries, and do not forgot to set a
                                       bigger "ulimit -n" in shell if the value is > 1024. (default 1024)
  -J, --max-query-conc int             ► Maximum number of concurrent queries. Bigger values do not
                                       improve the batch searching speed and consume much memory. (default 8)
  -Q, --min-qcov-per-genome float      ► Minimum query coverage (percentage) per genome.
  -q, --min-qcov-per-hsp float         ► Minimum query coverage (percentage) per HSP.
  -o, --out-file string                ► Out file, supports a ".gz" suffix ("-" for stdout). (default "-")
      --seed-max-dist int              ► Minimum distance between seeds in seed chaining. It should be
                                       <= contig interval length in database. (default 1000)
      --seed-max-gap int               ► Minimum gap in seed chaining. (default 50)
  -p, --seed-min-prefix int            ► Minimum (prefix/suffix) length of matched seeds (anchors).
                                       (default 15)
  -P, --seed-min-single-prefix int     ► Minimum (prefix/suffix) length of matched seeds (anchors) if
                                       there's only one pair of seeds matched. (default 17)
  -T, --taxdump string                 ► Directory containing taxdump files (nodes.dmp, names.dmp,
                                       etc.), needed for filtering results with TaxIds. For other
                                       non-NCBI taxonomy data, please use 'taxonkit create-taxdump' to
                                       create taxdump files.
      --taxid-file string              ► TaxIds from a file for filtering results, where the taxids
                                       are equal to or are the children of the given taxids. Negative
                                       values are allowed as a black list.
  -t, --taxids strings                 ► TaxIds(s) for filtering results, where the taxids are equal
                                       to or are the children of the given taxids. Negative values are
                                       allowed as a black list.
  -n, --top-n-genomes int              ► Keep top N genome matches for a query (0 for all) in chaining
                                       phase. Value 1 is not recommended as the best chaining result
                                       does not always bring the best alignment, so it better be >= 100.
                                       (default 0)

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```


## lexicmap_utils

### Tool Description
Some utilities

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Some utilities

Usage:
  lexicmap utils [command] 

Available Commands:
  2blast               Convert the default search output to blast-style format
  edit-genome-ids      Edit genome IDs in the index via a regular expression
  genomes              View genome IDs in the index
  kmers                View k-mers captured by the masks
  masks                View masks of the index or generate new masks randomly
  merge-search-results Merge a query's search results from multiple indexes
  reindex-seeds        Recreate indexes of k-mer-value (seeds) data
  remerge              Rerun the merging step for an unfinished index
  seed-pos             Extract and plot seed positions via reference name(s)
  subseq               Extract subsequence via 1) reference name, sequence ID, position and strand, or 2) search result

Flags:
  -h, --help   help for utils

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)

Use "lexicmap utils [command] --help" for more information about a command.
```


## Metadata
- **Skill**: generated
