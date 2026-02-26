# sga CWL Generation Report

## sga_preprocess

### Tool Description
Prepare READS1, READS2, ... data files for assembly

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Total Downloads**: 18.6K
- **Last updated**: 2025-09-23
- **GitHub**: https://github.com/jts/sga
- **Stars**: N/A
### Original Help Text
```text
Usage: sga preprocess [OPTION] READS1 READS2 ...
Prepare READS1, READS2, ... data files for assembly
If pe-mode is turned on (pe-mode=1) then if a read is discarded its pair will be discarded as well.

      --help                           display this help and exit
      -v, --verbose                    display verbose output
          --seed                       set random seed

Input/Output options:
      -o, --out=FILE                   write the reads to FILE (default: stdout)
      -p, --pe-mode=INT                0 - do not treat reads as paired (default)
                                       1 - reads are paired with the first read in READS1 and the second
                                       read in READS2. The paired reads will be interleaved in the output file
                                       2 - reads are paired and the records are interleaved within a single file.
          --pe-orphans=FILE            if one half of a read pair fails filtering, write the passed half to FILE

Conversions/Filtering:
          --phred64                    convert quality values from phred-64 to phred-33.
          --discard-quality            do not output quality scores
      -q, --quality-trim=INT           perform Heng Li's BWA quality trim algorithm. 
                                       Reads are trimmed according to the formula:
                                       argmax_x{\sum_{i=x+1}^l(INT-q_i)} if q_l<INT
                                       where l is the original read length.
      -f, --quality-filter=INT         discard the read if it contains more than INT low-quality bases.
                                       Bases with phred score <= 3 are considered low quality. Default: no filtering.
                                       The filtering is applied after trimming so bases removed are not counted.
                                       Do not use this option if you are planning to use the BCR algorithm for indexing.
      -m, --min-length=INT             discard sequences that are shorter than INT
                                       this is most useful when used in conjunction with --quality-trim. Default: 40
      -h, --hard-clip=INT              clip all reads to be length INT. In most cases it is better to use
                                       the soft clip (quality-trim) option.
      --permute-ambiguous              Randomly change ambiguous base calls to one of possible bases.
                                       If this option is not specified, the entire read will be discarded.
      -s, --sample=FLOAT               Randomly sample reads or pairs with acceptance probability FLOAT.
      --dust                           Perform dust-style filtering of low complexity reads.
      --dust-threshold=FLOAT           filter out reads that have a dust score higher than FLOAT (default: 4.0).
      --suffix=SUFFIX                  append SUFFIX to each read ID

Adapter/Primer checks:
          --no-primer-check            disable the default check for primer sequences
      -r, --remove-adapter-fwd=STRING
      -c, --remove-adapter-rev=STRING  Remove the adapter STRING from input reads.

Report bugs to js18@sanger.ac.uk
```


## sga_index

### Tool Description
Index the reads in READSFILE using a suffixarray/bwt

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga index [OPTION] ... READSFILE
Index the reads in READSFILE using a suffixarray/bwt

  -v, --verbose                        display verbose output
      --help                           display this help and exit
  -a, --algorithm=STR                  BWT construction algorithm. STR can be:
                                       sais - induced sort algorithm, slower but works for very long sequences (default)
                                       ropebwt - very fast and memory efficient. use this for short (<200bp) reads
  -d, --disk=NUM                       use disk-based BWT construction algorithm. The suffix array/BWT will be constructed
                                       for batchs of NUM reads at a time. To construct the suffix array of 200 megabases of sequence
                                       requires ~2GB of memory, set this parameter accordingly.
  -t, --threads=NUM                    use NUM threads to construct the index (default: 1)
  -c, --check                          validate that the suffix array/bwt is correct
  -p, --prefix=PREFIX                  write index to file using PREFIX instead of prefix of READSFILE
      --no-reverse                     suppress construction of the reverse BWT. Use this option when building the index
                                       for reads that will be error corrected using the k-mer corrector, which only needs the forward index
      --no-forward                     suppress construction of the forward BWT. Use this option when building the forward and reverse index separately
      --no-sai                         suppress construction of the SAI file. This option only applies to -a ropebwt
  -g, --gap-array=N                    use N bits of storage for each element of the gap array. Acceptable values are 4,8,16 or 32. Lower
                                       values can substantially reduce the amount of memory required at the cost of less predictable memory usage.
                                       When this value is set to 32, the memory requirement is essentially deterministic and requires ~5N bytes where
                                       N is the size of the FM-index of READS2.
                                       The default value is 8.

Report bugs to js18@sanger.ac.uk
```


## sga_merge

### Tool Description
Merge the sequence files READS1, READS2 into a single file/index

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga merge [OPTION] ... READS1 READS2
Merge the sequence files READS1, READS2 into a single file/index

  -v, --verbose                        display verbose output
      --help                           display this help and exit
  -t, --threads=NUM                    use NUM threads to merge the indices (default: 1)
  -p, --prefix=PREFIX                  write final index to files starting with PREFIX (the default is to concatenate the input filenames)
  -r, --remove                         remove the original BWT, SAI and reads files after the merge
  -g, --gap-array=N                    use N bits of storage for each element of the gap array. Acceptable values are 4,8,16 or 32. Lower
                                       values can substantially reduce the amount of memory required at the cost of less predictable memory usage.
                                       When this value is set to 32, the memory requirement is essentially deterministic and requires ~5N bytes where
                                       N is the size of the FM-index of READS2.
                                       The default value is 4.
      --no-sequence                    Suppress merging of the sequence files. Use this option when merging the index(es) separate e.g. in parallel
      --no-forward                     Suppress merging of the forward index. Use this option when merging the index(es) separate e.g. in parallel
      --no-reverse                     Suppress merging of the reverse index. Use this option when merging the index(es) separate e.g. in parallel


Report bugs to js18@sanger.ac.uk
```


## sga_bwt2fa

### Tool Description
Transform the bwt BWTFILE back into a set of sequences

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga bwt2fa [OPTION] ... BWTFILE
Transform the bwt BWTFILE back into a set of sequences

  -v, --verbose                        display verbose output
      --help                           display this help and exit
      -o,--outfile=FILE                write the sequences to FILE
      -p,--prefix=STR                  prefix the names of the reads with STR

Report bugs to js18@sanger.ac.uk
```


## sga_correct

### Tool Description
Correct sequencing errors in all the reads in READSFILE

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga correct [OPTION] ... READSFILE
Correct sequencing errors in all the reads in READSFILE

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -p, --prefix=PREFIX              use PREFIX for the names of the index files (default: prefix of the input file)
      -o, --outfile=FILE               write the corrected reads to FILE (default: READSFILE.ec.fa)
      -t, --threads=NUM                use NUM threads for the computation (default: 1)
          --discard                    detect and discard low-quality reads
      -d, --sample-rate=N              use occurrence array sample rate of N in the FM-index. Higher values use significantly
                                       less memory at the cost of higher runtime. This value must be a power of 2 (default: 128)
      -a, --algorithm=STR              specify the correction algorithm to use. STR must be one of kmer, hybrid, overlap. (default: kmer)
          --metrics=FILE               collect error correction metrics (error rate by position in read, etc) and write them to FILE

Kmer correction parameters:
      -k, --kmer-size=N                The length of the kmer to use. (default: 31)
      -x, --kmer-threshold=N           Attempt to correct kmers that are seen less than N times. (default: 3)
      -i, --kmer-rounds=N              Perform N rounds of k-mer correction, correcting up to N bases (default: 10)
      -O, --count-offset=N             When correcting a kmer, require the count of the new kmer is at least +N higher than the count of the old kmer. (default: 1)
          --learn                      Attempt to learn the k-mer correction threshold (experimental). Overrides -x parameter.

Overlap correction parameters:
      -e, --error-rate                 the maximum error rate allowed between two sequences to consider them overlapped (default: 0.04)
      -m, --min-overlap=LEN            minimum overlap required between two reads (default: 45)
      -M, --min-count-max-base=INT     minimum count of the base that has the highest count in overlap correction.
                                       The base of the read is only corrected if the maximum base has at least this count.
                                       Should avoid mis-corrections in low coverage regions (default: 4)
      -X, --base-threshold=N           Attempt to correct bases in a read that are seen less than N times (default: 2)
      -c, --conflict=INT               use INT as the threshold to detect a conflicted base in the multi-overlap (default: 5)
      -l, --seed-length=LEN            force the seed length to be LEN. By default, the seed length in the overlap step
                                       is calculated to guarantee all overlaps with --error-rate differences are found.
                                       This option removes the guarantee but will be (much) faster. As SGA can tolerate some
                                       missing edges, this option may be preferable for some data sets.
      -s, --seed-stride=LEN            force the seed stride to be LEN. This parameter will be ignored unless --seed-length
                                       is specified (see above). This parameter defaults to the same value as --seed-length
      -b, --branch-cutoff=N            stop the overlap search at N branches. This parameter is used to control the search time for
                                       highly-repetitive reads. If the number of branches exceeds N, the search stops and the read
                                       will not be corrected. This is not enabled by default.
      -r, --rounds=NUM                 iteratively correct reads up to a maximum of NUM rounds (default: 1)

Report bugs to js18@sanger.ac.uk
```


## sga_fm-merge

### Tool Description
Merge unambiguously sequences from the READSFILE using the FM-index. This program requires filter to be run before it and rmdup to be run after.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga fm-merge [OPTION] ... READSFILE
Merge unambiguously sequences from the READSFILE using the FM-index.
This program requires filter to be run before it and rmdup to be run after.

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -p, --prefix=PREFIX              use PREFIX for the names of the index files (default: prefix of the input file)
      -t, --threads=NUM                use NUM worker threads (default: no threading)
      -m, --min-overlap=LEN            minimum overlap required between two reads to merge (default: 45)
      -o, --outfile=FILE               write the merged sequences to FILE (default: basename.merged.fa)

Report bugs to js18@sanger.ac.uk
```


## sga_overlap

### Tool Description
Compute pairwise overlap between all the sequences in READS

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga overlap [OPTION] ... READSFILE
Compute pairwise overlap between all the sequences in READS

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -t, --threads=NUM                use NUM worker threads to compute the overlaps (default: no threading)
      -e, --error-rate                 the maximum error rate allowed to consider two sequences aligned (default: exact matches only)
      -m, --min-overlap=LEN            minimum overlap required between two reads (default: 45)
      -p, --prefix=PREFIX              use PREFIX for the names of the index files (default: prefix of the input file)
      -f, --target-file=FILE           perform the overlap queries against the reads in FILE
      -x, --exhaustive                 output all overlaps, including transitive edges
          --exact                      force the use of the exact-mode irreducible block algorithm. This is faster
                                       but requires that no substrings are present in the input set.
      -l, --seed-length=LEN            force the seed length to be LEN. By default, the seed length in the overlap step
                                       is calculated to guarantee all overlaps with --error-rate differences are found.
                                       This option removes the guarantee but will be (much) faster. As SGA can tolerate some
                                       missing edges, this option may be preferable for some data sets.
      -s, --seed-stride=LEN            force the seed stride to be LEN. This parameter will be ignored unless --seed-length
                                       is specified (see above). This parameter defaults to the same value as --seed-length
      -d, --sample-rate=N              sample the symbol counts every N symbols in the FM-index. Higher values use significantly
                                       less memory at the cost of higher runtime. This value must be a power of 2 (default: 128)

Report bugs to js18@sanger.ac.uk
```


## sga_assemble

### Tool Description
Create contigs from the assembly graph ASQGFILE.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga assemble [OPTION] ... ASQGFILE
Create contigs from the assembly graph ASQGFILE.

  -v, --verbose                        display verbose output
      --help                           display this help and exit
      -o, --out-prefix=NAME            use NAME as the prefix of the output files (output files will be NAME-contigs.fa, etc)
      -m, --min-overlap=LEN            only use overlaps of at least LEN. This can be used to filter
                                       the overlap set so that the overlap step only needs to be run once.
          --transitive-reduction       remove transitive edges from the graph. Off by default.
          --max-edges=N                limit each vertex to a maximum of N edges. For highly repetitive regions
                                       this helps save memory by culling excessive edges around unresolvable repeats (default: 128)

Bubble/Variation removal parameters:
      -b, --bubble=N                   perform N bubble removal steps (default: 3)
      -d, --max-divergence=F           only remove variation if the divergence between sequences is less than F (default: 0.05)
      -g, --max-gap-divergence=F       only remove variation if the divergence between sequences when only counting indels is less than F (default: 0.01)
                                       Setting this to 0.0 will suppress removing indel variation
          --max-indel=D                do not remove variation that is an indel of length greater than D (default: 20)


Trimming parameters:
      -x, --cut-terminal=N             cut off terminal branches in N rounds (default: 10)
      -l, --min-branch-length=LEN      remove terminal branches only if they are less than LEN bases in length (default: 150)

Small repeat resolution parameters:
      -r,--resolve-small=LEN           resolve small repeats using spanning overlaps when the difference between the shortest
                                       and longest overlap is greater than LEN (default: not performed)

Report bugs to js18@sanger.ac.uk
```


## sga_oview

### Tool Description
Draw overlaps in ASQGFILE

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga oview [OPTION] ... ASQGFILE
Draw overlaps in ASQGFILE

  -v, --verbose                        display verbose output
      --help                           display this help and exit
      -i, --id=ID                      only show overlaps for read with ID
      -m, --max-overhang=D             only show D overhanging bases of the alignments (default: 6)
      -d, --default-padding=D          pad the overlap lines with D characters (default: 20)

Report bugs to js18@sanger.ac.uk
```


## sga_subgraph

### Tool Description
Extract the subgraph around the sequence with ID from an asqg file.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga subgraph [OPTION] ... ID ASQGFILE
Extract the subgraph around the sequence with ID from an asqg file.

  -v, --verbose                        display verbose output
      --help                           display this help and exit
      -o, --out=FILE                   write the subgraph to FILE (default: subgraph.asqg.gz)
      -s, --size=N                     the size of the subgraph to extract, all vertices that are at most N hops
                                       away from the root will be included (default: 5)

Report bugs to js18@sanger.ac.uk
```


## sga_filter

### Tool Description
Remove reads from a data set.
The currently available filters are removing exact-match duplicates
and removing reads with low-frequency k-mers.
Automatically rebuilds the FM-index without the discarded reads.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga filter [OPTION] ... READSFILE
Remove reads from a data set.
The currently available filters are removing exact-match duplicates
and removing reads with low-frequency k-mers.
Automatically rebuilds the FM-index without the discarded reads.

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -p, --prefix=PREFIX              use PREFIX for the names of the index files (default: prefix of the input file)
      -o, --outfile=FILE               write the qc-passed reads to FILE (default: READSFILE.filter.pass.fa)
      -t, --threads=NUM                use NUM threads to compute the overlaps (default: 1)
      -d, --sample-rate=N              use occurrence array sample rate of N in the FM-index. Higher values use significantly
                                       less memory at the cost of higher runtime. This value must be a power of 2 (default: 128)
      --no-duplicate-check             turn off duplicate removal
      --substring-only                 when removing duplicates, only remove substring sequences, not full-length matches
      --no-kmer-check                  turn off the kmer check
      --kmer-both-strand               mimimum kmer coverage is required for both strand
      --homopolymer-check              check reads for hompolymer run length sequencing errors
      --low-complexity-check           filter out low complexity reads

K-mer filter options:
      -k, --kmer-size=N                The length of the kmer to use. (default: 27)
      -x, --kmer-threshold=N           Require at least N kmer coverage for each kmer in a read. (default: 3)

Report bugs to js18@sanger.ac.uk
```


## sga_rmdup

### Tool Description
Remove duplicate reads from the data set.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga rmdup [OPTION] ... READFILE
Remove duplicate reads from the data set.

  -v, --verbose                        display verbose output
      --help                           display this help and exit
      -o, --out=FILE                   write the output to FILE (default: READFILE.rmdup.fa)
      -p, --prefix=PREFIX              use PREFIX instead of the prefix of the reads filename for the input/output files
      -e, --error-rate                 the maximum error rate allowed to consider two sequences identical (default: exact matches required)
      -t, --threads=N                  use N threads (default: 1)
      -d, --sample-rate=N              sample the symbol counts every N symbols in the FM-index. Higher values use significantly
                                       less memory at the cost of higher runtime. This value must be a power of 2 (default: 256)

Report bugs to js18@sanger.ac.uk
```


## sga_gen-ssa

### Tool Description
Build a sampled suffix array for the reads in READSFILE using the BWT

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga gen-ssa [OPTION] ... READSFILE
Build a sampled suffix array for the reads in READSFILE using the BWT

  -v, --verbose                        display verbose output
      --help                           display this help and exit
  -t, --threads=NUM                    use NUM threads to construct the index (default: 1)
  -c, --check                          validate that the suffix array/bwt is correct
  -s, --sai-only                       only build the lexicographic index

Report bugs to js18@sanger.ac.uk
```


## sga_scaffold

### Tool Description
Construct scaffolds from CONTIGSFILE using distance estimates.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scaffold [OPTION] ... [--pe PE-DE] [--mate-pair MATEPAIR-DE] CONTIGSFILE
Construct scaffolds from CONTIGSFILE using distance estimates. 
The distance estimates are read from the --pe and --matepair parameters

      --help                           display this help and exit
      -v, --verbose                    display verbose output
          --pe=FILE                    load links derived from paired-end (short insert) libraries from FILE
          --mate-pair=FILE             load links derived from mate-pair (long insert) libraries from FILE
      -m, --min-length=N               only use contigs at least N bp in length to build scaffolds (default: no minimun).
      -g, --asqg-file=FILE             optionally load the sequence graph from FILE
      -a, --astatistic-file=FILE       load Myers' A-statistic values from FILE. This is used to
                                       determine unique and repetitive contigs with the -u/--unique-astat
                                       and -r/--repeat-astat parameters (required)
      -u, --unique-astat=FLOAT         Contigs with an a-statitic value about FLOAT will be considered unique (default: 20.0)
      -c, --min-copy-number=FLOAT      remove vertices with estimated copy number less than FLOAT (default: 0.5f)
      -s, --max-sv-size=N              collapse heterozygous structural variation if the event size is less than N (default: 0)
      -o, --outfile=FILE               write the scaffolds to FILE (default: CONTIGSFILE.scaf
          --remove-conflicting         if two contigs have multiple distance estimates between them and they do not agree, break the scaffold
                                       at this point
          --strict                     perform strict consistency checks on the scaffold links. If a vertex X has multiple edges, a path will
                                       be searched for that contains every vertex linked to X. If no such path can be found, the edge of X are removed.
                                       This builds very conservative scaffolds that should be highly accurate.

Report bugs to js18@sanger.ac.uk
```


## sga_scaffold2fasta

### Tool Description
Write out a fasta file for the scaffolds indicated in SCAFFOLDFILE

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scaffold2fasta [OPTION] ... [-f CONTIGSFILE | -a ASQGFILE] SCAFFOLDFILE
Write out a fasta file for the scaffolds indicated in SCAFFOLDFILE
One of -f CONTIGSFILE or -a ASQGFILE must be provided. If an asqg file is provided,
the program can attempt to determine the sequence linking the scaffold components by
walking the graph/

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -f, --contig-file=FILE           read the contig sequences from FILE
      -a, --asqg-file=FILE             read the contig string graph from FILE. This supercedes --contig-file
                                       this is usually the output from the sga-assemble step
          --no-singletons              do not output scaffolds that consist of a single contig
      -o, --outfile=FILE               write the scaffolds to FILE (default: scaffolds.fa)
      -m, --min-length=N               only output scaffolds longer than N bases
          --write-unplaced             output unplaced contigs that are larger than minLength
          --write-names                write the name of contigs contained in the scaffold in the FASTA header
          --min-gap-length=N           separate contigs by at least N bases. All predicted gaps less
                                       than N will be extended to N (default: 25)
          --use-overlap                attempt to merge contigs using predicted overlaps.
                                       This can help close gaps in the scaffolds but comes
                                       with a small risk of collapsing tandem repeats.
      -g, --graph-resolve=MODE         if an ASQG file is present, attempt to resolve the links
                                       between contigs using walks through the graph. The MODE parameter
                                       is a string describing the algorithm to use.
                                       The MODE parameter must be one of best-any|best-unique|unique|none.
                                       best-any: The walk with length closest to the estimated
                                       distance between the contigs will be chosen to resolve the gap.
                                       If multiple best walks are found, the tie is broken arbitrarily.
                                       best-unique: as above but if there is a tie no walk will be chosen.
                                       unique: only resolve the gap if there is a single walk between the contigs
                                       none: do not resolve gaps using the graph
                                       The most conservative most is unique, then best-unique with best-any being the most
                                       aggressive. The default is unique
      -d, --distanceFactor=T           Accept a walk as correctly resolving a gap if the walk length is within T standard 
                                       deviations from the estimated distance (default: 3.0f)

Report bugs to js18@sanger.ac.uk
```


## sga_gapfill

### Tool Description
Fill in scaffold gaps using walks through a de Bruijn graph

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga gapfill [OPTION] SCAFFOLDS.fa
Fill in scaffold gaps using walks through a de Bruijn graph

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -p, --prefix=NAME                load the FM-index with prefix NAME
      -s, --start-kmer=K               First kmer size used to attempt to resolve each gap (default: 91)
      -e, --end-kmer=K                 Last kmer size used to attempt to resolve each gap (default: 51)
      -x, --kmer-threshold=T           only use kmers seen at least T times
      -t, --threads=NUM                use NUM computation threads
      -d, --sample-rate=N              use occurrence array sample rate of N in the FM-index. Higher values use significantly
                                       less memory at the cost of higher runtime. This value must be a power of 2 (default: 128)

Report bugs to js18@sanger.ac.uk
```


## sga_graph-diff

### Tool Description
Find and report strings only present in the graph of VARIANT when compared to BASE

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga graph-diff [OPTION] --base BASE.fa --variant VARIANT.fa --ref REFERENCE.fa
Find and report strings only present in the graph of VARIANT when compared to BASE

General options:
      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -p, --prefix=NAME                prefix the output files with NAME
      -t, --threads=NUM                use NUM computation threads
          --genome-size=N              (optional) set the size of the genome to be N bases
                                       this is used to determine the number of bits to use in the bloom filter
                                       if unset, it will be calculated from the reference genome FASTA file
          --precache-reference=STR     precache the named chromosome of the reference genome
                                       If STR is "all" the entire reference will be cached

Index options:
      -r, --variant=FILE               call variants present in the read set in FILE
      -b, --base=FILE                  use the read set in FILE as the base line for comparison
                                       if this option is not given, reference-based calls will be made
          --reference=FILE             use the reference sequence in FILE

Algorithm options:
      -k, --kmer=K                     use K-mers to discover variants
      -x, --min-discovery-count=T      require a variant k-mer to be seen at least T times
      -a, --algorithm=STR              select the assembly algorithm to use from: debruijn, string
      -m, --min-overlap=N              require at least N bp overlap when assembling using a string graph
          --min-dbg-count=T            only use k-mers seen T times when assembling using a de Bruijn graph

Report bugs to js18@sanger.ac.uk
```


## sga_graph-concordance

### Tool Description
Count read support for variants in a vcf file

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga graph-concordance [OPTION] ... -r variant.fastq -b base.fastq VCF_FILE
Count read support for variants in a vcf file

      --help                           display this help and exit
      -v, --verbose                    display verbose output
          --reference=STR              load the reference genome from FILE
      -t, --threads=NUM                use NUM threads to compute the overlaps (default: 1)
      -g, --germline=FILE              load germline variants from FILE

Report bugs to js18@sanger.ac.uk
```


## sga_rewrite-evidence-bam

### Tool Description
Discard mate-pair alignments from a BAM file that are potentially erroneous

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga rewrite-evidence-bam [OPTION] ... EVIDENCE_BAM_FILE
Discard mate-pair alignments from a BAM file that are potentially erroneous

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -f, --fastq=FILE                 parse the read names and sequences from the fastq file in F (required)
      -m, --merge-bam=FILE             merge the evidence BAM alignments with the alignments in F
      -o, --outfile=FILE               write the new BAM file to F

Report bugs to js18@sanger.ac.uk
```


## sga_haplotype-filter

### Tool Description
Remove haplotypes and their associated variants from a data set.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga haplotype-filter [OPTION] ... HAPLOTYPE_FILE VCF_FILE
Remove haplotypes and their associated variants from a data set.

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -r, --reads=FILE                 load the FM-index of the reads in FILE
          --reference=STR              load the reference genome from FILE
          --haploid                    force use of the haploid model
      -o, --out-prefix=STR             write the passed haplotypes and variants to STR.vcf and STR.fa
      -t, --threads=NUM                use NUM threads to compute the overlaps (default: 1)

Report bugs to js18@sanger.ac.uk
```


## sga_somatic-variant-filters

### Tool Description
Filters somatic variants based on tumor and normal BAM files and a reference genome.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
somatic-variant-filters: option '--help' requires an argument
somatic-variant-filters: missing arguments
somatic-variant-filters: a --tumor-bam must be provided
somatic-variant-filters: a --normal-bam must be provided
somatic-variant-filters: a --reference must be provided
```


## sga_preqc

### Tool Description
Perform pre-assembly quality checks

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga preqc [OPTION] ... READSFILE
Perform pre-assembly quality checks

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -t, --threads=NUM                use NUM threads (default: 1)
          --simple                     only compute the metrics that do not need the FM-index
          --max-contig-length=N        stop contig extension at N bp (default: 50000)
          --reference=FILE             use the reference FILE to calculate GC plot
          --diploid-reference-mode     generate metrics assuming that the input data
                                       is a reference genome, not a collection of reads
          --force-EM                   force preqc to proceed even if the coverage model
                                       does not converge. This allows the rest of the program to continue
                                       but the branch and genome size estimates may be misleading

Report bugs to js18@sanger.ac.uk
```


## sga_stats

### Tool Description
Print statistics about the read set. Currently this only prints a histogram
of the k-mer counts

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga stats [OPTION] ... READSFILE
Print statistics about the read set. Currently this only prints a histogram
of the k-mer counts

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -p, --prefix=PREFIX              use PREFIX for the names of the index files (default: prefix of the input file)
      -t, --threads=NUM                use NUM threads to compute the overlaps (default: 1)
      -d, --sample-rate=N              use occurrence array sample rate of N in the FM-index. Higher values use significantly
                                       less memory at the cost of higher runtime. This value must be a power of 2 (default: 128)
      -k, --kmer-size=N                The length of the kmer to use. (default: 27)
      -n, --num-reads=N                Only use N reads to compute the statistics
      -b, --branch-cutoff=N            stop the overlap search at N branches. This lowers the compute time but will bias the statistics
                                       away from repetitive reads
      --run-lengths                    Print the run length distribution of the BWT
      --kmer-distribution              Print the distribution of kmer counts
      --no-overlap                     Suppress the overlap-based error statistics (faster if you only want the k-mer distribution)

Report bugs to js18@sanger.ac.uk
```


## sga_filterBAM

### Tool Description
Discard mate-pair alignments from a BAM file that are potentially erroneous

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga filterBAM [OPTION] ... ASQGFILE BAMFILE
Discard mate-pair alignments from a BAM file that are potentially erroneous

      --help                           display this help and exit
      -v, --verbose                    display verbose output
      -a, --asqg=FILE                  load an asqg file and filter pairs that are shorter than --max-distance
      -d, --max-distance=LEN           search the graph for a path completing the mate-pair fragment. If the path is less than LEN
                                       then the pair will be discarded.
      -e, --error-rate=F               filter out pairs where one read has an error rate higher than F (default: no filter)
      -q, --min-quality=F              filter out pairs where one read has mapping quality less than F (default: 10)
      -o, --out-bam=FILE               write the filtered reads to FILE
      -p, --prefix=STR                 load the FM-index with prefix STR
      -x, --max-kmer-depth=N           filter out pairs that contain a kmer that has been seen in the FM-index more than N times
      -c, --mate-contamination         filter out pairs aligning with FR orientation, which may be contiminates in a mate pair library

Report bugs to js18@sanger.ac.uk
```


## sga_cluster

### Tool Description
Extract clusters of reads belonging to the same connected components.

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga cluster [OPTION] READS
Extract clusters of reads belonging to the same connected components.

  -v, --verbose                        display verbose output
      --help                           display this help and exit
      -o, --out=FILE                   write the clusters to FILE (default: clusters.txt)
      -c, --min-cluster-size=N         only write clusters with at least N reads (default: 2)
      -x, --max-cluster-size=N         abort the search if the cluster size exceeds N
      -m, --min-overlap=N              require an overlap of at least N bases between reads (default: 45)
      -e, --error-rate                 the maximum error rate allowed to consider two sequences aligned (default: exact matches only)
      -t, --threads=NUM                use NUM worker threads to compute the overlaps (default: no threading)
      -i, --iterations=NUM             limit cluster extension to NUM iterations
          --extend=FILE                extend previously existing clusters in FILE
          --limit=FILE                 do not extend through the sequences in FILE

Report bugs to js18@sanger.ac.uk
```


## sga_kmer-count

### Tool Description
Generate a table of the k-mers in src.{bwt,fa,fq}, and optionally count the number of time they appears in testX.bwt.
Output on stdout the canonical kmers and their counts on forward and reverse strand if input is .bwt
If src is a sequence file output forward and reverse counts for each kmer in the file

### Metadata
- **Docker Image**: biocontainers/sga:v0.10.15-4-deb_cv1
- **Homepage**: https://github.com/jts/sga
- **Package**: https://anaconda.org/channels/bioconda/packages/sga/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sga kmer-count [OPTION] src.{bwt,fa,fq} [test1.bwt] [test2.bwt]
Generate a table of the k-mers in src.{bwt,fa,fq}, and optionally count the number of time they appears in testX.bwt.
Output on stdout the canonical kmers and their counts on forward and reverse strand if input is .bwt
If src is a sequence file output forward and reverse counts for each kmer in the file

      --help                           display this help and exit
      --version                        display program version
      -k, --kmer-size=N                The length of the kmer to use. (default: 27)
      -d, --sample-rate=N              use occurrence array sample rate of N in the FM-index. Higher values use significantly
                                       less memory at the cost of higher runtime. This value must be a power of 2 (default: 128)
      -c, --cache-length=N             Cache Length for bwt lookups (default: 10)

Report bugs to js18@sanger.ac.uk
```

