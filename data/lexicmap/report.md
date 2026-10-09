# lexicmap CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| lexicmap_index | PASS | added the missing positional genome files; indexed 3 demo genomes and the index works for search |
| lexicmap_search | PASS | fixed --out-file flag; E. coli 16S query against 3 genomes gives the same hits as the expected demo result |
| lexicmap_utils_2blast | PASS | converted a search -a result to Blast-style alignments |
| lexicmap_utils_edit_genome_ids | PASS | renamed genome IDs in a writable index copy with a regex; genomes lists the new IDs |
| lexicmap_utils_genomes | PASS | listed the 3 genome IDs of the demo index |
| lexicmap_utils_kmers | PASS | listed 99 k-mers of mask 1 |
| lexicmap_utils_masks | PASS | exported the 20000 masks of the demo index |
| lexicmap_utils_merge_search_results | PASS | merged two search result files into one table |
| lexicmap_utils_reindex_seeds | PASS | re-indexed the seeds of a writable index copy with 1024 partitions |
| lexicmap_utils_remerge | Not completed | needs an unfinished index with a .tmp folder, which cannot be made here (tool reports tmp directory not found on a finished index) |
| lexicmap_utils_seed_pos | PASS | ran on an index built with --save-seed-pos; seed distance table and two histogram plots written |
| lexicmap_utils_subseq | PASS | extracted subsequences from search results and by genome, sequence and region; E. coli 16S sequence correct |

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


## lexicmap_utils_2blast

### Tool Description
Convert the tabular search result of \"lexicmap search -a\" to a Blast-style alignment format.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  lexicmap utils 2blast [flags] 

Flags:
  -b, --buffer-size string      ► Size of buffer, supported unit: K, M, G. You need increase the value
                                when "bufio.Scanner: token too long" error reported (default "20M")
  -h, --help                    help for 2blast
  -i, --ignore-case             ► Ignore cases of sgenome and sseqid
  -g, --kv-file-genome string   ► Two-column tabular file for mapping the target genome ID (sgenome)
                                to the corresponding value
  -s, --kv-file-seq string      ► Two-column tabular file for mapping the target sequence ID (sseqid)
                                to the corresponding value
  -o, --out-file string         ► Out file, supports and recommends a ".gz" suffix ("-" for stdout).
                                (default "-")

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_edit_genome_ids

### Tool Description
Edit genome IDs in the index via a regular expression.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Edit genome IDs in the index via a regular expression

Use cases:
  In the 'lexicmap index' command, users might forget to use the flag
  -N/--ref-name-regexp to extract the genome ID from the sequence file.
  A genome file from NCBI looks like:

    GCF_009818595.1_ASM981859v1_genomic.fna.gz

  In this case, the genome ID would be GCF_009818595.1_ASM981859v1_genomic,
  which is too long. So we can use this command to extract the assembly
  accession via:

    lexicmap utils edit-genome-ids -d t.lmi/ -p '^(\w{3}_\d{9}\.\d+).*' -r '$1'

Tips:
  - A backup file (genomes.map.bin.bak) will be created on the first run.

Usage:
  lexicmap utils edit-genome-ids [flags] 

Flags:
  -h, --help                 help for edit-genome-ids
  -d, --index string         ► Index directory created by "lexicmap index".
  -p, --pattern string       ► Search regular expression".
  -r, --replacement string   ► Replacement. Supporting capture variables.  e.g. $1 represents the text
                             of the first submatch. ATTENTION: for *nix OS, use SINGLE quote NOT double
                             quotes or use the \ escape character.

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_genomes

### Tool Description
View genome IDs in the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
View genome IDs in the index

Usage:
  lexicmap utils genomes [flags] 

Flags:
  -h, --help              help for genomes
  -d, --index string      ► Index directory created by "lexicmap index".
  -o, --out-file string   ► Out file, supports the ".gz" suffix ("-" for stdout). (default "-")

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_kmers

### Tool Description
View k-mers captured by the masks of the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  lexicmap utils kmers [flags] -d <index path> [-m <mask index>] [-o out.tsv.gz]

Flags:
  -h, --help              help for kmers
  -d, --index string      ► Index directory created by "lexicmap index".
  -m, --mask int          ► View k-mers captured by Xth mask. (0 for all) (default 1)
  -f, --only-forward      ► Only output forward k-mers.
  -o, --out-file string   ► Out file, supports and recommends a ".gz" suffix ("-" for stdout).
                          (default "-")

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_masks

### Tool Description
View masks of the index or generate new masks randomly.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
View masks of the index or generate new masks randomly

Usage:
  lexicmap utils masks [flags] { -d <index path> | [-k <k>] [-n <masks>] [-s <seed>] } [-o out.tsv.gz]

Flags:
  -h, --help              help for masks
  -d, --index string      ► Index directory created by "lexicmap index".
  -k, --kmer int          ► Maximum k-mer size. K needs to be <= 32. (default 31)
  -m, --masks int         ► Number of masks. (default 40000)
  -o, --out-file string   ► Out file, supports and recommends a ".gz" suffix ("-" for stdout).
                          (default "-")
  -p, --prefix int        ► Length of mask k-mer prefix for checking low-complexity (0 for no
                          checking). (default 15)
  -s, --seed int          ► The seed for generating random masks. (default 1)

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_merge_search_results

### Tool Description
Merge search results from multiple indexes (several files for the same queries).

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  lexicmap utils merge-search-results [flags] 

Flags:
  -b, --buffer-size string   ► Size of buffer, supported unit: K, M, G. You need increase the value
                             when "bufio.Scanner: token too long" error reported (default "20M")
  -h, --help                 help for merge-search-results
  -o, --out-file string      ► Out file, supports the ".gz" suffix ("-" for stdout). (default "-")
  -q, --query string         ► Query ID to merge

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_reindex_seeds

### Tool Description
Recreate indexes of k-mer-value (seeds) data.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Recreate indexes of k-mer-value (seeds) data

Usage:
  lexicmap utils reindex-seeds [flags] 

Flags:
  -h, --help             help for reindex-seeds
  -d, --index string     ► Index directory created by "lexicmap index".
      --partitions int   ► Number of partitions for re-indexing seeds (k-mer-value data) files. The
                         value needs to be the power of 4. (default 4096)

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_remerge

### Tool Description
Rerun the merging step for an unfinished index.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Rerun the merging step for an unfinished index

When to use this command?

- Only one thread is used for merging indexes, which happens when there are
  a lot (>200 batches) of batches ($inpu_files / --batch-size) and the value
  of --max-open-files is not big enough. E.g.,

  22:54:24.420 [INFO] merging 297 indexes...
  22:54:24.455 [INFO]   [round 1]
  22:54:24.455 [INFO]     batch 1/1, merging 297 indexes to xxx.lmi.tmp/r1_b1 with 1 threads...

  ► Then you can run this command with a bigger --max-open-files (e.g., 4096) and 
  -J/--seed-data-threads (e.g., 12. 12 needs be <= 4096/(297+2)=13.7).
  And you need to set a bigger 'ulimit -n' if the value of --max-open-files is bigger than 1024.

- The Slurm/PBS job time limit is almost reached and the merging step won't be finished before that.

- Disk quota is reached in the merging step.

Usage:
  lexicmap utils remerge [flags] [flags] -d <index path>

Flags:
  -h, --help                    help for remerge
  -d, --index string            ► Index directory created by "lexicmap index".
      --max-open-files int      ► Maximum opened files, used in merging indexes. If there are >100
                                batches, please increase this value and set a bigger "ulimit -n" in
                                shell. (default 1024)
  -J, --seed-data-threads int   ► Number of threads for writing seed data and merging seed chunks from
                                all batches, the value should be in range of [1, -c/--chunks]. If there
                                are >100 batches, please also increase the value of --max-open-files and
                                set a bigger "ulimit -n" in shell. (default 8)

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_seed_pos

### Tool Description
Extract and plot the distance and positions of seeds (k-mers) in the index.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  lexicmap utils seed-pos [flags] 

Flags:
  -a, --all-refs             ► Output for all reference genomes. This would take a long time for an
                             index with a lot of genomes.
  -b, --bins int             ► Number of bins in histograms. (default 100)
      --color-index int      ► Color index (1-7). (default 1)
      --force                ► Overwrite existing output directory.
      --height float         ► Histogram height (unit: inch). (default 4)
  -h, --help                 help for seed-pos
  -d, --index string         ► Index directory created by "lexicmap index".
      --max-open-files int   ► Maximum opened files, used for extracting sequences. (default 512)
  -D, --min-dist int         ► Only output records with seed distance >= this value.
  -o, --out-file string      ► Out file, supports and recommends a ".gz" suffix ("-" for stdout).
                             (default "-")
  -O, --plot-dir string      ► Output directory for 1) histograms of seed distances, 2) histograms of
                             numbers of seeds in sliding windows.
      --plot-ext string      ► Histogram plot file extention. (default ".png")
  -n, --ref-name strings     ► Reference name(s).
  -s, --slid-step int        ► The step size of sliding windows for counting the number of seeds
                             (default 100)
  -w, --slid-window int      ► The window size of sliding windows for counting the number of seeds
                             (default 250)
  -v, --verbose              ► Show more columns including position of the previous seed and sequence
                             between the two seeds. Warning: it's slow to extract the sequences,
                             recommend set -D 1000 or higher values to filter results 
      --width float          ► Histogram width (unit: inch). (default 6)

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## lexicmap_utils_subseq

### Tool Description
Extract subsequences from the index by genome ID, sequence ID and region, or from search results.

### Metadata
- **Docker Image**: quay.io/biocontainers/lexicmap:0.8.1--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/LexicMap
- **Package**: https://anaconda.org/channels/bioconda/packages/lexicmap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  lexicmap utils subseq [flags] 

Flags:
  -b, --buffer-size string     ► Size of buffer, supported unit: K, M, G. You need increase the value
                               when "bufio.Scanner: token too long" error reported (default "20M")
  -D, --downstream int         ► Extract extra N bp on the downstream of the aligned/specified region.
  -h, --help                   help for subseq
  -e, --ignore-err             ► Ignore errors such as 'reference name not found' or 'failed to
                               extract subsequence'. Switch on this flag if search results are merged
                               from multiple indexes.
  -d, --index string           ► Index directory created by "lexicmap index".
  -w, --line-width int         ► Line width of sequence (0 for no wrap). (default 60)
      --max-open-files int     ► Maximum opened files. It mainly affects candidate subsequence
                               extraction. Increase this value if you have hundreds of genome batches or
                               have multiple queries, and do not forgot to set a bigger "ulimit -n" in
                               shell if the value is > 1024. (default 1024)
  -H, --no-header-row          ► The search result file has no header row, this happens when using
                               tools like awk to filter the file.
  -o, --out-file string        ► Out file, supports the ".gz" suffix ("-" for stdout). (default "-")
  -n, --ref-name string        ► Reference name.
  -r, --region string          ► Region of the subsequence (1-based).
  -R, --revcom                 ► Extract subsequence on the negative strand.
  -f, --search-result string   ► Use search result file from "lexicmap search" as input. It can be "-"
                               to accept filtered result from stdin
  -s, --seq-id string          ► Sequence ID. If the value is empty, the positions in the region are
                               treated as that in the concatenated sequence.
  -U, --upstream int           ► Extract extra N bp on the upstream of the aligned/specified region.

Global Flags:
  -X, --infile-list string   ► File of input file list (one file per line). If given, they are
                             appended to files from CLI arguments.
      --log string           ► Log file.
      --quiet                ► Do not print any verbose information. But you can write them to a file
                             with --log.
  -j, --threads int          ► Number of CPU cores to use. By default, it uses all available cores.
                             (default 20)
```

## Metadata
- **Skill**: generated
