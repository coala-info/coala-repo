# hackgap CWL Generation Report

## hackgap_The

### Tool Description
hackgap: error: argument COMMAND: invalid choice: 'The' (choose from count, countwith, pycount, info)

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Total Downloads**: 784
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: hackgap [-h] [--version] [--debug] COMMAND ...
hackgap: error: argument COMMAND: invalid choice: 'The' (choose from count, countwith, pycount, info)
```


## hackgap_COMMAND

### Tool Description
hackgap: error: argument COMMAND: invalid choice: 'COMMAND' (choose from count, countwith, pycount, info)

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hackgap [-h] [--version] [--debug] COMMAND ...
hackgap: error: argument COMMAND: invalid choice: 'COMMAND' (choose from count, countwith, pycount, info)
```


## hackgap_count

### Tool Description
Count k-mers in specified files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hackgap count [-h] [--files FAST[AQ] [FAST[AQ] ...]] -o OUTPUT_PREFIX
                     (-k INT | --mask MASK) -n INT [--maxcount INT]
                     [--filtersizes GB [GB ...]]
                     [--filterfiles FAST[AQ] [FAST[AQ] ...]] [--rcmode MODE]
                     [--markweak] [--statistics {none,summary,details,full}]
                     [--unaligned] [--aligned] [--hashfunctions HASHFUNCTIONS]
                     [--bucketsize INT] [--fill FLOAT] [--subtables INT]
                     [--threads-read INT] [--threads-split INT]
                     [--maxwalk INT] [--walkseed INT] [--maxfailures INT]

options:
  -h, --help            show this help message and exit
  --files, -f FAST[AQ] [FAST[AQ] ...]
                        file(s) in which to count k-mers ([gzipped] FASTA or
                        FASTQ)
  -o, --out OUTPUT_PREFIX
                        path/prefix of output file with k-mer count hash
                        (required; use '/dev/null' or 'null' or 'none' to
                        avoid output)
  -k, --kmersize INT    k-mer size
  --mask MASK           gapped k-mer mask (quoted string like '#__##_##__#')
  -n, --nobjects INT    number of objects to be stored
  --maxcount, -M INT    maximum count value [65535]; should be 2**N - 1 for
                        some N
  --filtersizes, -s GB [GB ...]
                        size of filter(s) in gigabytes, up to 3 filter levels.
                        For counting without filtering, do not specify this
                        option.
  --filterfiles, -F FAST[AQ] [FAST[AQ] ...]
                        optionally, different file(s) to populate filters
                        ([gzipped] FASTA or FASTQ); the default and typical
                        use case is to use the same files as for counting, so
                        usually, you do not want to use this option.
  --rcmode MODE         mode specifying how to encode k-mers
  --markweak            mark weak vs. strong k-mers after counting (slow)
  --statistics, --stats {none,summary,details,full}
                        statistics level of detail (none, *summary*, details,
                        full (all subtables))
  --unaligned           use unaligned buckets (smaller, slightly slower;
                        default)
  --aligned             use power-of-two aligned buckets (faster, but larger)
  --hashfunctions, --functions HASHFUNCTIONS
                        hash functions: 'default', 'random', or
                        func0:func1:func2:func3
  --bucketsize, -b, -p INT
                        bucket size, i.e. number of elements on a bucket
  --fill FLOAT          desired fill rate of the hash table
  --subtables INT       number of subtables used; subtables+1 threads are used
  --threads-read INT    number of reader threads
  --threads-split INT   number of splitter threads
  --maxwalk INT         maximum length of random walk through hash table
                        before failing [500]
  --walkseed INT        seed for random walks while inserting elements [7]
  --maxfailures INT     continue even after this many failures [default:0;
                        forever:-1]
```


## hackgap_or

### Tool Description
hackgap: error: argument COMMAND: invalid choice: 'or' (choose from count, countwith, pycount, info)

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hackgap [-h] [--version] [--debug] COMMAND ...
hackgap: error: argument COMMAND: invalid choice: 'or' (choose from count, countwith, pycount, info)
```


## hackgap_countwith

### Tool Description
Count k-mers in files using an existing index.

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hackgap countwith [-h] [--files FAST[AQ] [FAST[AQ] ...]]
                         -o OUTPUT_PREFIX --index INPUT_PREFIX
                         [--threads-read INT] [--threads-split INT]
                         [--statistics {none,summary,details,full}]

options:
  -h, --help            show this help message and exit
  --files, -f FAST[AQ] [FAST[AQ] ...]
                        file(s) in which to count k-mers ([gzipped] FASTA or
                        FASTQ)
  -o, --out OUTPUT_PREFIX
                        path/prefix of output file with k-mer count hash
                        (required; use '/dev/null' or 'null' or 'none' to
                        avoid output)
  --index INPUT_PREFIX  path/prefix of the existing index which should be used
                        for counting
  --threads-read INT    number of reader threads
  --threads-split INT   number of splitter threads
  --statistics, --stats {none,summary,details,full}
                        statistics level of detail (none, *summary*, details,
                        full (all subtables))
```


## hackgap_pycount

### Tool Description
Index and count k-mers in FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hackgap pycount [-h] [-k INT] [--rcmode MODE] --fastq FASTQ [FASTQ ...]
                       [-o OUTPUT_PREFIX]

options:
  -h, --help            show this help message and exit
  -k, --kmersize INT    k-mer size
  --rcmode MODE         mode specifying how to encode k-mers
  --fastq, -q FASTQ [FASTQ ...]
                        FASTQ file(s) to index and count
  -o, --out OUTPUT_PREFIX
                        name of output file (dummy, unused)
```


## hackgap_info

### Tool Description
Prints information about a hash table.

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hackgap info [-h] [--outprefix OUTPREFIX]
                    [--format {native,packed,text,txt,dna}]
                    [--filterexpression EXPRESSION]
                    [--compilefilter FUNCTIONPATH [PARAM ...]]
                    [--statistics LEVEL] [--showvalues INT]
                    INPUTPREFIX

positional arguments:
  INPUTPREFIX           file name of existing hash table (without extension
                        .hash or .info)

options:
  -h, --help            show this help message and exit
  --outprefix, --export, -o, -e OUTPREFIX
                        file name prefix of exported data, extended by
                        .{key,chc.val}.{txt,data}.
  --format {native,packed,text,txt,dna}
                        output format [native (default): use native integer
                        arrays (uint{8,16,32,64}); packed: use bit-backed
                        arrays; text: use text files (one integer per line);
                        dna: text file with DNA k-mers (one k-mer per line)]
  --filterexpression, -f EXPRESSION
                        filter expression using variables `key`, `choice`,
                        `value`, e.g. '(choice != 0) and (value & 3 == 3)'.
                        Output (but not statistics) will be restricted to
                        items for which the filter expression is true.
  --compilefilter, -c FUNCTIONPATH [PARAM ...]
                        string specifying `path/module::compiler_func` that
                        will be called with the valueset, the appinfo and
                        given additional parameters (PARAM) to compile a
                        filter function that takes key, choice and value as
                        arguments.
  --statistics LEVEL    level of detail of statistics to be shown (none,
                        summary, details, full)
  --showvalues INT      number of values to show in value statistics (none,
                        all, INT)
```


## hackgap_counts

### Tool Description
hackgap: error: argument COMMAND: invalid choice: 'counts' (choose from count, countwith, pycount, info)

### Metadata
- **Docker Image**: quay.io/biocontainers/hackgap:1.0.1--pyhdfd78af_0
- **Homepage**: https://gitlab.com/rahmannlab/hackgap
- **Package**: https://anaconda.org/channels/bioconda/packages/hackgap/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hackgap [-h] [--version] [--debug] COMMAND ...
hackgap: error: argument COMMAND: invalid choice: 'counts' (choose from count, countwith, pycount, info)
```


## Metadata
- **Skill**: not generated
