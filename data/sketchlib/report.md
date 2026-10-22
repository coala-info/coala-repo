# sketchlib CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sketchlib_append | PASS |  |
| sketchlib_delete | PASS |  |
| sketchlib_dist | PASS |  |
| sketchlib_info | PASS |  |
| sketchlib_inverted_build | PASS |  |
| sketchlib_inverted_precluster | PASS |  |
| sketchlib_inverted_query | PASS |  |
| sketchlib_merge | PASS |  |
| sketchlib_sketch | PASS |  |

## sketchlib_sketch

### Tool Description
Create sketches from input data

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Total Downloads**: 589
- **Last updated**: 2025-12-02
- **GitHub**: https://github.com/bacpop/sketchlib.rust
- **Stars**: N/A
### Original Help Text
```text
Create sketches from input data

Usage: sketchlib sketch [OPTIONS] -o <OUTPUT> <--k-vals <K_VALS>|--k-seq <K_SEQ>> <SEQ_FILES|-f <FILE_LIST>>

Arguments:
  [SEQ_FILES]...
          List of input FASTA files

Options:
  -f <FILE_LIST>
          File listing input files (tab separated name, sequences, see README)

      --concat-fasta
          Treat every sequence in an input file as a new sample (aa only)

  -o <OUTPUT>
          Output prefix

  -k, --k-vals <K_VALS>
          K-mer list (comma separated k-mer values to sketch at)

      --k-seq <K_SEQ>
          K-mer linear sequence (start,end,step)

  -s, --sketch-size <SKETCH_SIZE>
          Sketch size
          
          [default: 1000]

      --seq-type <SEQ_TYPE>
          Type of sequence to hash
          
          [default: dna]
          [possible values: dna, aa, pdb]

      --level <LEVEL>
          aaHash 'level'

          Possible values:
          - level1: Level1: All amino acids are different
          - level2: Level2: Groups T,S; D,E; Q,K,R; V,I,L,M; W,F,Y
          - level3: Level3: Additionally groups A with T,S; N with D,E
          
          [default: level1]

  -v, --verbose
          Show progress messages

      --quiet
          Don't show any messages

      --single-strand
          Ignore reverse complement (all contigs are oriented along same strand)

      --min-count <MIN_COUNT>
          Minimum k-mer count (with reads)
          
          [default: 5]

      --min-qual <MIN_QUAL>
          Minimum k-mer quality (with reads)
          
          [default: 20]

      --threads <THREADS>
          Number of CPU threads
          
          [default: 1]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## sketchlib_dist

### Tool Description
Calculate pairwise distances using sketches

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate pairwise distances using sketches

Usage: sketchlib dist [OPTIONS] <REF_DB> [QUERY_DB]

Arguments:
  <REF_DB>    The .skm file used as the reference
  [QUERY_DB]  The .skm file used as the query (omit for ref v ref)

Options:
  -o <OUTPUT>
          Output filename (omit to output to stdout)
      --knn <KNN>
          Calculate sparse distances with k nearest-neighbours
      --subset <SUBSET>
          Sample names to analyse
  -k <KMER>
          K-mer length (if provided only calculate Jaccard distance)
      --ani
          Calculate ANI rather than Jaccard dists, using Poisson model
      --threads <THREADS>
          Number of CPU threads [default: 1]
      --completeness-file <COMPLETENESS_FILE>
          File listing sample and completeness estimate 0.0-1.0 (tab separated)
      --completeness-cutoff <COMPLETENESS_CUTOFF>
          minimum completeness for a sample to be corrected but the completeness correction [default: 0.64]
  -v, --verbose
          Show progress messages
      --quiet
          Don't show any messages
  -h, --help
          Print help
  -V, --version
          Print version
```


## sketchlib_merge

### Tool Description
Merge two sketch files (.skm and .skd pair)

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Merge two sketch files (.skm and .skd pair)

Usage: sketchlib merge [OPTIONS] -o <OUTPUT> <DB1> <DB2>

Arguments:
  <DB1>  The first .skd (sketch data) file
  <DB2>  The second .skd (sketch data) file

Options:
  -o <OUTPUT>    Output filename for the merged sketch
  -v, --verbose  Show progress messages
      --quiet    Don't show any messages
  -h, --help     Print help
  -V, --version  Print version
```


## sketchlib_append

### Tool Description
Append new genomes to be sketched to an existing sketch database

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Append new genomes to be sketched to an existing sketch database

Usage: sketchlib append [OPTIONS] -o <OUTPUT> <DB> [SEQ_FILES]...

Arguments:
  <DB>
          Sketching database basename (so without .skm or .skd)

  [SEQ_FILES]...
          List of input FASTA files

Options:
  -f <FILE_LIST>
          File listing input files (tab separated name, sequences)

  -o <OUTPUT>
          Output filename for the merged sketch

      --single-strand
          Ignore reverse complement (all contigs are oriented along same strand)

      --min-count <MIN_COUNT>
          Minimum k-mer count (with reads)
          
          [default: 5]

      --min-qual <MIN_QUAL>
          Minimum k-mer quality (with reads)
          
          [default: 20]

      --concat-fasta
          Treat every sequence in an input file as a new sample (aa only)

      --threads <THREADS>
          Number of CPU threads
          
          [default: 1]

      --level <LEVEL>
          aaHash 'level'

          Possible values:
          - level1: Level1: All amino acids are different
          - level2: Level2: Groups T,S; D,E; Q,K,R; V,I,L,M; W,F,Y
          - level3: Level3: Additionally groups A with T,S; N with D,E
          
          [default: level1]

  -v, --verbose
          Show progress messages

      --quiet
          Don't show any messages

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```


## sketchlib_info

### Tool Description
Print information about a .skm file

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Print information about a .skm file

Usage: sketchlib info [OPTIONS] <SKM_FILE>

Arguments:
  <SKM_FILE>  Sketch metadata file (.skm) to describe

Options:
      --sample-info  Write out the information for every sample contained
  -v, --verbose      Show progress messages
      --quiet        Don't show any messages
  -h, --help         Print help
  -V, --version      Print version
```


## sketchlib_delete

### Tool Description
Delete genome(s) from a database (input: one id per line)

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Delete genome(s) from a database (input: one id per line)

Usage: sketchlib delete [OPTIONS] <DB> <SAMPLES> <OUTPUT_FILE>

Arguments:
  <DB>           Sketching database
  <SAMPLES>      Input file with IDs to delete (one ID per line)
  <OUTPUT_FILE>  output file name

Options:
  -v, --verbose  Show progress messages
      --quiet    Don't show any messages
  -h, --help     Print help
  -V, --version  Print version
```

## sketchlib_inverted_build

### Tool Description
Create sketches from input data and store in an inverted index structure

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Create sketches from input data and store in an inverted index structure

Usage: sketchlib inverted build [OPTIONS] -o <OUTPUT> [SEQ_FILES]...

Arguments:
  [SEQ_FILES]...  List of input FASTA files

Options:
  -f <FILE_LIST>                       File listing input files (tab separated name, sequences, see README)
  -o <OUTPUT>                          Output filename for the merged sketch
      --write-skq                      Also write an .skq file, which is needed by 'precluster' mode
      --species-names <SPECIES_NAMES>  File listing species names, or clusters, for phylogenetic ordering
  -s, --sketch-size <SKETCH_SIZE>      Sketch size [default: 1000]
  -k, --kmer-length <KMER_LENGTH>      K-mer size [default: 21]
      --single-strand                  Ignore reverse complement (all contigs are oriented along same strand)
      --min-count <MIN_COUNT>          Minimum k-mer count (with reads) [default: 5]
  -v, --verbose                        Show progress messages
      --min-qual <MIN_QUAL>            Minimum k-mer quality (with reads) [default: 20]
      --quiet                          Don't show any messages
      --threads <THREADS>              Number of CPU threads [default: 1]
  -h, --help                           Print help
  -V, --version                        Print version
```

## sketchlib_inverted_query

### Tool Description
Find distances against an inverted index

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Find distances against an inverted index

Usage: sketchlib inverted query [OPTIONS] <SKI> [SEQ_FILES]...

Arguments:
  <SKI>
          The inverted index (.ski) file used as the reference

  [SEQ_FILES]...
          List of input FASTA files

Options:
  -f <FILE_LIST>
          File listing input files (tab separated name, sequences, see README)

  -o <OUTPUT>
          Output filename (omit to output to stdout)

      --query-type <QUERY_TYPE>
          Type of query to perform

          Possible values:
          - match-count: Count the number of matching bins for each sample in the index
          - all-bins:    Return samples which match at every bin
          - any-bins:    Return samples which match at least one bin
          
          [default: match-count]

      --min-count <MIN_COUNT>
          Minimum k-mer count (with reads)
          
          [default: 5]

      --min-qual <MIN_QUAL>
          Minimum k-mer quality (with reads)
          
          [default: 20]

      --threads <THREADS>
          Number of CPU threads
          
          [default: 1]

  -v, --verbose
          Show progress messages

      --quiet
          Don't show any messages

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

## sketchlib_inverted_precluster

### Tool Description
Use an inverted index to reduce query comparisons

### Metadata
- **Docker Image**: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
- **Homepage**: https://github.com/bacpop/sketchlib.rust
- **Package**: https://anaconda.org/channels/bioconda/packages/sketchlib/overview
- **Validation**: PASS

### Original Help Text
```text
Use an inverted index to reduce query comparisons

Usage: sketchlib inverted precluster [OPTIONS] <--skd <SKD>|--count> <SKI>

Arguments:
  <SKI>  The inverted index (.ski) file used as the reference

Options:
      --skd <SKD>
          The .skd/.skm file prefix, which must have the same samples and k-mer length as the .ski file
  -o <OUTPUT>
          Output filename (omit to output to stdout)
      --count
          Do not run analysis, only return the number of comparisons
      --knn <KNN>
          Reduce to a maximum of k nearest-neighbours [default: 50]
      --ani
          Calculate ANI rather than Jaccard dists, using Poisson model
      --threads <THREADS>
          Number of CPU threads [default: 1]
      --completeness-file <COMPLETENESS_FILE>
          Completeness file
      --completeness-cutoff <COMPLETENESS_CUTOFF>
          minimum completeness for a sample to be corrected but the completeness correction [default: 0.64]
  -v, --verbose
          Show progress messages
      --quiet
          Don't show any messages
  -h, --help
          Print help
  -V, --version
          Print version
```

## Metadata
- **Skill**: not generated
