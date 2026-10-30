# obitools4 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| obitools4_obiannotate | PASS |  |
| obitools4_obiclean | PASS |  |
| obitools4_obicleandb | Failed | tool bug: the program has no --taxonomy option in this build and always stops with: species is not a valid rank. |
| obitools4_obicomplement | PASS |  |
| obitools4_obiconsensus | PASS |  |
| obitools4_obiconvert | PASS |  |
| obitools4_obicount | PASS |  |
| obitools4_obicsv | PASS |  |
| obitools4_obidemerge | PASS |  |
| obitools4_obidistribute | PASS |  |
| obitools4_obigrep | PASS |  |
| obitools4_obijoin | PASS |  |
| obitools4_obikmermatch | PASS |  |
| obitools4_obikmersimcount | PASS |  |
| obitools4_obilandmark | PASS |  |
| obitools4_obimatrix | PASS |  |
| obitools4_obimicrosat | PASS |  |
| obitools4_obimultiplex | PASS |  |
| obitools4_obipairing | PASS |  |
| obitools4_obipcr | PASS |  |
| obitools4_obiscript | PASS |  |
| obitools4_obisplit | PASS |  |
| obitools4_obisummary | PASS | The --map option crashes with a nil pointer error; the main summary mode works. |
| obitools4_obitag | PASS |  |
| obitools4_obitagpcr | PASS |  |
| obitools4_obitaxonomy | PASS |  |
| obitools4_obiuniq | PASS |  |

## obitools4_obiannotate

### Tool Description
Add, edit or delete attributes (annotations) of sequence records, optionally after selecting records with obigrep-like conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obiannotate [--add-lca-in <SLOT_NAME>] [--aho-corasick <string>]
                [--allows-indels] [--approx-pattern <PATTERN>]...
                [--attribute|-a <KEY=VALUE>]... [--batch-size <int>] [--clear]
                [--compressed|-Z] [--cut <###:###>] [--debug]
                [--definition|-D <PATTERN>]... [--delete-tag <KEY>]... [--ecopcr]
                [--embl] [--fail-on-taxonomy] [--fasta] [--fasta-output]
                [--fastq] [--fastq-output] [--force-one-cpu] [--genbank]
                [--has-attribute|-A <KEY>]... [--help|-h|-?]
                [--id-list <FILENAME>] [--identifier|-I <PATTERN>]...
                [--ignore-taxon|-i <TAXID>]... [--input-OBI-header]
                [--input-json-header] [--inverse-match|-v] [--json-output]
                [--keep|-k <KEY>]... [--lca-error <#.###>] [--length]
                [--max-count|-C <COUNT>] [--max-cpu <int>]
                [--max-length|-L <LENGTH>] [--min-count|-c <COUNT>]
                [--min-length|-l <LENGTH>] [--no-order] [--no-progressbar]
                [--only-forward] [--out|-o <FILENAME>] [--output-OBI-header|-O]
                [--output-json-header]
                [--paired-mode <forward|reverse|and|or|andnot|xor>]
                [--paired-with <FILENAME>] [--pattern <string>]
                [--pattern-error <int>] [--pattern-name <string>] [--pprof]
                [--pprof-goroutine <int>] [--pprof-mutex <int>]
                [--predicate|-p <EXPRESSION>]...
                [--rename-tag|-R <NEW_NAME=OLD_NAME>]...
                [--require-rank <RANK_NAME>]...
                [--restrict-to-taxon|-r <TAXID>]... [--scientific-name]
                [--sequence|-s <PATTERN>]... [--set-identifier <EXPRESSION>]
                [--set-tag|-S <KEY=EXPRESSION>]... [--skip-empty] [--solexa]
                [--taxonomic-path] [--taxonomic-rank] [--taxonomy|-t <string>]
                [--update-taxid] [--valid-taxid] [--version]
                [--with-taxon-at-rank <RANK_NAME>]... [<args>]

OPTIONS:
    --add-lca-in <SLOT_NAME>                             From the taxonomic annotation of the sequence (taxid slot or merged_taxid slot), a new slot named <SLOT_NAME> is added with the taxid of the lowest common ancester corresponding to the current annotation. (default: "")

    --aho-corasick <string>                              Adds an aho-corasick attribut with the count of matches of the provided patterns. (default: "")

    --allows-indels                                      Allows for indel during pattern matching (default: false)

    --approx-pattern <PATTERN>                           Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive. (default: [])

    --attribute|-a <KEY=VALUE>                           Regular expression pattern matched against the attributes of the sequence record. the value of this attribute is of the form : key:regular_pattern. The pattern is case sensitive. Several -a options can be used on the same command line and in this last case, the selected sequence records will match all constraints. (default: {})

    --batch-size <int>                                   Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --clear                                              Clears all attributes associated to the sequence records. (default: false)

    --compressed|-Z                                      Compress all the result using gzip (default: false)

    --cut <###:###>                                      A pattern decribing how to cut the sequence (default: "")

    --debug                                              Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --definition|-D <PATTERN>                            Regular expression pattern to be tested against the sequence definition. The pattern is case insensitive. (default: [])

    --delete-tag <KEY>                                    Deletes attribute named <KEY>.When this attribute is missing, the sequence record is skipped and the next one is examined. (default: [])

    --ecopcr                                             Read data following the ecoPCR output format. (default: false)

    --embl                                               Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy                                   Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                                              Read data following the fasta format. (default: false)

    --fasta-output                                       Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                                              Read data following the fastq format. (default: false)

    --fastq-output                                       Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                                      Force to use only one cpu core for parallel processing (default: false)

    --genbank                                            Read data following the Genbank flatfile format. (default: false)

    --has-attribute|-A <KEY>                             Selects sequence records having an attribute whose key = <KEY>. (default: [])

    --help|-h|-?                                         (default: false)

    --id-list <FILENAME>                                 <FILENAME> points to a text file containing the list of sequence record identifiers to be selected. The file format consists in a single identifier per line. (default: "")

    --identifier|-I <PATTERN>                            Regular expression pattern to be tested against the sequence identifier. The pattern is case insensitive. (default: [])

    --ignore-taxon|-i <TAXID>                            Require that the actual taxon of the sequence doesn't belong the provided taxid. (default: [])

    --input-OBI-header                                   FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header                                  FASTA/FASTQ title line annotations follow json format. (default: false)

    --inverse-match|-v                                   Inverts the sequence record selection. (default: false)

    --json-output                                        Write sequence in json format. (default: false)

    --keep|-k <KEY>                                      Keeps only attribute with key <KEY>. Several -k options can be combined. (default: [])

    --lca-error <#.###>                                  Error rate tolerated on the taxonomical discription during the lowest common ancestor. At most a fraction of lca-error of the taxonomic information can disagree with the estimated LCA. (default: 0.000000)

    --length                                             Adds attribute with seq_length as a key and sequence length as a value. (default: false)

    --max-count|-C <COUNT>                               Selects sequence records occuring no more than max count time in the data set. (default: 2000000000)

    --max-cpu <int>                                      Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --max-length|-L <LENGTH>                             Selects sequence records whose sequence length is equal or shorter than lmax. (default: 2000000000)

    --min-count|-c <COUNT>                               Selects sequence records occuring at least min count time in the data set. (default: 1)

    --min-length|-l <LENGTH>                             Selects sequence records whose sequence length is equal or longer than lmin. (default: 1)

    --no-order                                           When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                                     Disable the progress bar printing (default: false)

    --only-forward                                       Look for pattern only on forward strand (default: false)

    --out|-o <FILENAME>                                  Filename used for saving the output (default: "-")

    --output-OBI-header|-O                               output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header                                 output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-mode <forward|reverse|and|or|andnot|xor>    If paired reads are passed to obibrep, that option determines how the conditions are applied to both reads. (default: "forward")

    --paired-with <FILENAME>                             Filename containing the paired reads (default: "")

    --pattern <string>                                   Adds a pattern attribut containing the pattern, a pattern_match slot indicating the matched sequence, and a pattern_error slot indicating the number difference between the pattern and the match to the sequence. (default: "")

    --pattern-error <int>                                Maximum number of allowed error during pattern matching (default: 0)

    --pattern-name <string>                              specify the name to use as prefix for the slots reporting the match (default: "pattern")

    --pprof                                              Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>                              Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>                                  Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --predicate|-p <EXPRESSION>                          boolean expression to be evaluated for each sequence record. The attribute keys defined for each sequence record can be used in the expression as variable names. An extra variable named ‘sequence’ refers to the sequence record itself. Several -p options can be used on the same command line and in this last case, the selected sequence records will match all constraints. (default: [])

    --rename-tag|-R <NEW_NAME=OLD_NAME>                  Changes attribute name <OLD_NAME> to <NEW_NAME>. When attribute named <OLD_NAME> is missing, the sequence record is skipped and the next one is examined. (default: {})

    --require-rank <RANK_NAME>                           Select sequences belonging a taxon with a rank <RANK_NAME> (default: [])

    --restrict-to-taxon|-r <TAXID>                       Require that the actual taxon of the sequence belongs the provided taxid. (default: [])

    --scientific-name                                    Annotate the sequence with its scientific name (default: false)

    --sequence|-s <PATTERN>                              Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive. (default: [])

    --set-identifier <EXPRESSION>                        An expression used to assigned the new id of the sequence (default: "")

    --set-tag|-S <KEY=EXPRESSION>                        Creates a new attribute named with a key <KEY> sets with a value computed from <EXPRESSION>. (default: {})

    --skip-empty                                         Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                                             Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomic-path                                     Annotate the sequence with its taxonomic path (default: false)

    --taxonomic-rank                                     Annotate the sequence with its taxonomic rank (default: false)

    --taxonomy|-t <string>                               Path to the taxonomy database. (default: "")

    --update-taxid                                       Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --valid-taxid                                        Validate the taxonomic classification of the sequences. (default: false)

    --version                                            Prints the version and exits. (default: false)

    --with-taxon-at-rank <RANK_NAME>                     Adds taxonomic annotation at taxonomic rank <RANK_NAME>. (default: [])
```

## obitools4_obiclean

### Tool Description
Denoise metabarcoding data: label each sequence variant per sample as head, internal or singleton, to remove PCR and sequencing errors.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obiclean [--batch-size <int>] [--compressed|-Z] [--debug] [--detect-chimera]
             [--distance|-d <int>] [--ecopcr] [--embl] [--fasta] [--fasta-output]
             [--fastq] [--fastq-output] [--force-one-cpu] [--genbank] [--head|-H]
             [--help|-h|-?] [--input-OBI-header] [--input-json-header]
             [--json-output] [--max-cpu <int>] [--min-eval-rate <int>]
             [--min-sample-count <int>] [--no-order] [--no-progressbar]
             [--out|-o <FILENAME>] [--output-OBI-header|-O]
             [--output-json-header] [--pprof] [--pprof-goroutine <int>]
             [--pprof-mutex <int>] [--ratio|-r <float64>] [--sample|-s <string>]
             [--save-graph <string>] [--save-ratio <string>] [--skip-empty]
             [--solexa] [--version] [<args>]

OPTIONS:
    --batch-size <int>          Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z             Compress all the result using gzip (default: false)

    --debug                     Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --detect-chimera            Detect chimera sequences. (default: false)

    --distance|-d <int>         Maximum numbers of differences between two variant sequences (default: %d). (default: 1)

    --ecopcr                    Read data following the ecoPCR output format. (default: false)

    --embl                      Read data following the EMBL flatfile format. (default: false)

    --fasta                     Read data following the fasta format. (default: false)

    --fasta-output              Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                     Read data following the fastq format. (default: false)

    --fastq-output              Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu             Force to use only one cpu core for parallel processing (default: false)

    --genbank                   Read data following the Genbank flatfile format. (default: false)

    --head|-H                   Select only sequences with the head status in at least one sample. (default: false)

    --help|-h|-?                (default: false)

    --input-OBI-header          FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header         FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output               Write sequence in json format. (default: false)

    --max-cpu <int>             Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --min-eval-rate <int>       Minimum abundance of a sequence to be used to evaluate mutation rate. (default: 1000)

    --min-sample-count <int>    Minimum number of samples a sequence must be present in to be considered in the analysis. (default: 1)

    --no-order                  When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar            Disable the progress bar printing (default: false)

    --out|-o <FILENAME>         Filename used for saving the output (default: "-")

    --output-OBI-header|-O      output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header        output FASTA/FASTQ title line annotations follow json format. (default: false)

    --pprof                     Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>     Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>         Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --ratio|-r <float64>        Threshold ratio between counts (rare/abundant counts) of two sequence records so that the less abundant one is a variant of the more abundant (default: %3.2f). (default: 1.000000)

    --sample|-s <string>        Attribute containing sample descriptions (default %s). (default: "sample")

    --save-graph <string>       Creates a directory containing the set of DAG used by the obiclean clustering algorithm. The graph files follow the graphml format. (default: "__@@NOSAVE@@__")

    --save-ratio <string>       Creates a file containing the set of abundance ratio on the graph edge. The ratio file follows the csv format. (default: "__@@NOSAVE@@__")

    --skip-empty                Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                    Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --version                   Prints the version and exits. (default: false)
```

## obitools4_obicleandb

### Tool Description
Clean a reference database: keep only sequences with a valid taxonomic annotation, optionally restricted by taxon or rank.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obicleandb [--batch-size <int>] [--compressed|-Z] [--debug] [--ecopcr]
               [--embl] [--fasta] [--fasta-output] [--fastq] [--fastq-output]
               [--force-one-cpu] [--genbank] [--help|-h|-?]
               [--ignore-taxon|-i <TAXID>]... [--input-OBI-header]
               [--input-json-header] [--json-output] [--max-cpu <int>]
               [--no-order] [--no-progressbar] [--out|-o <FILENAME>]
               [--output-OBI-header|-O] [--output-json-header] [--pprof]
               [--pprof-goroutine <int>] [--pprof-mutex <int>]
               [--require-rank <RANK_NAME>]...
               [--restrict-to-taxon|-r <TAXID>]... [--skip-empty] [--solexa]
               [--update-taxids] [--valid-taxid] [--version] [<args>]

OPTIONS:
    --batch-size <int>                Number of sequence per batch for paralelle processing (default: 10, env: OBIBATCHSIZE)

    --compressed|-Z                   Compress all the result using gzip (default: false)

    --debug                           Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                          Read data following the ecoPCR output format. (default: false)

    --embl                            Read data following the EMBL flatfile format. (default: false)

    --fasta                           Read data following the fasta format. (default: false)

    --fasta-output                    Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                           Read data following the fastq format. (default: false)

    --fastq-output                    Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                   Force to use only one cpu core for parallel processing (default: false)

    --genbank                         Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                      (default: false)

    --ignore-taxon|-i <TAXID>         Require that the actual taxon of the sequence doesn't belong the provided taxid. (default: [])

    --input-OBI-header                FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header               FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                     Write sequence in json format. (default: false)

    --max-cpu <int>                   Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                        When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                  Disable the progress bar printing (default: false)

    --out|-o <FILENAME>               Filename used for saving the output (default: "-")

    --output-OBI-header|-O            output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header              output FASTA/FASTQ title line annotations follow json format. (default: false)

    --pprof                           Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>           Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>               Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --require-rank <RANK_NAME>        Select sequences belonging a taxon with a rank <RANK_NAME> (default: [])

    --restrict-to-taxon|-r <TAXID>    Require that the actual taxon of the sequence belongs the provided taxid. (default: [])

    --skip-empty                      Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                          Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --update-taxids                   Indicates if decrecated Taxids must be corrected. (default: false)

    --valid-taxid                     Validate the taxonomic classification of the sequences. (default: false)

    --version                         Prints the version and exits. (default: false)
```

## obitools4_obicomplement

### Tool Description
Reverse-complement the sequences of a sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obicomplement [--batch-size <int>] [--compressed|-Z] [--debug] [--ecopcr]
                  [--embl] [--fail-on-taxonomy] [--fasta] [--fasta-output]
                  [--fastq] [--fastq-output] [--force-one-cpu] [--genbank]
                  [--help|-h|-?] [--input-OBI-header] [--input-json-header]
                  [--json-output] [--max-cpu <int>] [--no-order]
                  [--no-progressbar] [--out|-o <FILENAME>]
                  [--output-OBI-header|-O] [--output-json-header]
                  [--paired-with <FILENAME>] [--pprof] [--pprof-goroutine <int>]
                  [--pprof-mutex <int>] [--skip-empty] [--solexa]
                  [--taxonomy|-t <string>] [--update-taxid] [--version] [<args>]

OPTIONS:
    --batch-size <int>          Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z             Compress all the result using gzip (default: false)

    --debug                     Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                    Read data following the ecoPCR output format. (default: false)

    --embl                      Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy          Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                     Read data following the fasta format. (default: false)

    --fasta-output              Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                     Read data following the fastq format. (default: false)

    --fastq-output              Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu             Force to use only one cpu core for parallel processing (default: false)

    --genbank                   Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                (default: false)

    --input-OBI-header          FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header         FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output               Write sequence in json format. (default: false)

    --max-cpu <int>             Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                  When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar            Disable the progress bar printing (default: false)

    --out|-o <FILENAME>         Filename used for saving the output (default: "-")

    --output-OBI-header|-O      output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header        output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>    Filename containing the paired reads (default: "")

    --pprof                     Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>     Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>         Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                    Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>      Path to the taxonomy database. (default: "")

    --update-taxid              Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                   Prints the version and exits. (default: false)
```

## obitools4_obiconsensus

### Tool Description
Build consensus sequences from sequence variants (denoising by consensus), optionally in clustering mode.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obiconsensus [--batch-size <int>] [--cluster|-C] [--compressed|-Z] [--debug]
                 [--distance|-d <int>] [--ecopcr] [--embl] [--fasta]
                 [--fasta-output] [--fastq] [--fastq-output] [--force-one-cpu]
                 [--genbank] [--help|-h|-?] [--input-OBI-header]
                 [--input-json-header] [--json-output] [--kmer-size <SIZE>]
                 [--low-coverage <float64>] [--max-cpu <int>] [--no-order]
                 [--no-progressbar] [--no-singleton] [--out|-o <FILENAME>]
                 [--output-OBI-header|-O] [--output-json-header] [--pprof]
                 [--pprof-goroutine <int>] [--pprof-mutex <int>]
                 [--sample|-s <string>] [--save-graph <string>]
                 [--save-ratio <string>] [--skip-empty] [--solexa] [--unique|-U]
                 [--version] [<args>]

OPTIONS:
    --batch-size <int>          Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --cluster|-C                Switch obiconsensus into its clustering mode. (default: false)

    --compressed|-Z             Compress all the result using gzip (default: false)

    --debug                     Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --distance|-d <int>         Maximum numbers of differences between two variant sequences (default: %d). (default: 1)

    --ecopcr                    Read data following the ecoPCR output format. (default: false)

    --embl                      Read data following the EMBL flatfile format. (default: false)

    --fasta                     Read data following the fasta format. (default: false)

    --fasta-output              Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                     Read data following the fastq format. (default: false)

    --fastq-output              Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu             Force to use only one cpu core for parallel processing (default: false)

    --genbank                   Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                (default: false)

    --input-OBI-header          FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header         FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output               Write sequence in json format. (default: false)

    --kmer-size <SIZE>          The size of the kmer used to build the consensus. Default value = -1, which means that the kmer size is estimated from the data (default: -1)

    --low-coverage <float64>    If the coverage of a sample is lower than this value, it will be discarded. (default: 0.000000)

    --max-cpu <int>             Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                  When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar            Disable the progress bar printing (default: false)

    --no-singleton              If set, sequences occurring a single time in the data set are discarded. (default: false)

    --out|-o <FILENAME>         Filename used for saving the output (default: "-")

    --output-OBI-header|-O      output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header        output FASTA/FASTQ title line annotations follow json format. (default: false)

    --pprof                     Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>     Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>         Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --sample|-s <string>        Attribute containing sample descriptions (default %s). (default: "sample")

    --save-graph <string>       Creates a directory containing the set of DAG used by the obiclean clustering algorithm. The graph files follow the graphml format. (default: "__@@NOSAVE@@__")

    --save-ratio <string>       Creates a file containing the set of abundance ratio on the graph edge. The ratio file follows the csv format. (default: "__@@NOSAVE@@__")

    --skip-empty                Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                    Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --unique|-U                 If set, sequences are dereplicated on the output (obiuniq). (default: false)

    --version                   Prints the version and exits. (default: false)
```

## obitools4_obicount

### Tool Description
Count the sequence records, reads, variants or symbols in sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obicount [--batch-size <int>] [--debug] [--ecopcr] [--embl] [--fasta]
             [--fastq] [--force-one-cpu] [--genbank] [--help|-h|-?]
             [--input-OBI-header] [--input-json-header] [--max-cpu <int>]
             [--no-order] [--pprof] [--pprof-goroutine <int>]
             [--pprof-mutex <int>] [--reads|-r] [--solexa] [--symbols|-s]
             [--variants|-v] [--version] [<args>]

OPTIONS:
    --batch-size <int>         Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --debug                    Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                   Read data following the ecoPCR output format. (default: false)

    --embl                     Read data following the EMBL flatfile format. (default: false)

    --fasta                    Read data following the fasta format. (default: false)

    --fastq                    Read data following the fastq format. (default: false)

    --force-one-cpu            Force to use only one cpu core for parallel processing (default: false)

    --genbank                  Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?               (default: false)

    --input-OBI-header         FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header        FASTA/FASTQ title line annotations follow json format. (default: false)

    --max-cpu <int>            Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                 When several input files are provided, indicates that there is no order among them. (default: false)

    --pprof                    Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>    Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>        Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --reads|-r                 Prints read counts. (default: false)

    --solexa                   Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --symbols|-s               Prints symbol counts. (default: false)

    --variants|-v              Prints variant counts. (default: false)

    --version                  Prints the version and exits. (default: false)
```

## obitools4_obicsv

### Tool Description
Convert sequence files to CSV, with a choice of attributes and columns.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obicsv [--auto] [--batch-size <int>] [--compressed|-Z] [--count] [--debug]
           [--definition|-d] [--ecopcr] [--embl] [--fail-on-taxonomy] [--fasta]
           [--fastq] [--force-one-cpu] [--genbank] [--help|-h|-?] [--ids|-i]
           [--input-OBI-header] [--input-json-header] [--keep|-k <KEY>]...
           [--max-cpu <int>] [--na-value <NAVALUE>] [--no-order]
           [--no-progressbar] [--obipairing] [--out|-o <FILENAME>] [--pprof]
           [--pprof-goroutine <int>] [--pprof-mutex <int>] [--quality|-q]
           [--sequence|-s] [--solexa] [--taxon] [--taxonomy|-t <string>]
           [--update-taxid] [--version] [<args>]

OPTIONS:
    --auto                     Based on the first sequences, propose a list of attibutes to print (default: false)

    --batch-size <int>         Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z            Compress all the result using gzip (default: false)

    --count                    Prints the count attribute in the output (default: false)

    --debug                    Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --definition|-d            Prints sequence definition in the output. (default: false)

    --ecopcr                   Read data following the ecoPCR output format. (default: false)

    --embl                     Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy         Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                    Read data following the fasta format. (default: false)

    --fastq                    Read data following the fastq format. (default: false)

    --force-one-cpu            Force to use only one cpu core for parallel processing (default: false)

    --genbank                  Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?               (default: false)

    --ids|-i                   Prints sequence ids in the ouput. (default: false)

    --input-OBI-header         FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header        FASTA/FASTQ title line annotations follow json format. (default: false)

    --keep|-k <KEY>            Keeps only attribute with key <KEY>. Several -k options can be combined. (default: [])

    --max-cpu <int>            Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --na-value <NAVALUE>       A string representing non available values in the CSV file. (default: "NA")

    --no-order                 When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar           Disable the progress bar printing (default: false)

    --obipairing               Prints the attributes added by obipairing (default: false)

    --out|-o <FILENAME>        Filename used for saving the output (default: "-")

    --pprof                    Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>    Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>        Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --quality|-q               Prints sequence quality in the output. (default: false)

    --sequence|-s              Prints sequence itself in the output. (default: false)

    --solexa                   Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxon                    Prints the NCBI taxid and its related scientific name (default: false)

    --taxonomy|-t <string>     Path to the taxonomy database. (default: "")

    --update-taxid             Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                  Prints the version and exits. (default: false)
```

## obitools4_obidemerge

### Tool Description
Demerge a merged attribute (for example sample) so that each sample gets its own sequence record again.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obidemerge [--batch-size <int>] [--compressed|-Z] [--debug]
               [--demerge|-d <string>] [--ecopcr] [--embl] [--fail-on-taxonomy]
               [--fasta] [--fasta-output] [--fastq] [--fastq-output]
               [--force-one-cpu] [--genbank] [--help|-h|-?] [--input-OBI-header]
               [--input-json-header] [--json-output] [--max-cpu <int>]
               [--no-order] [--no-progressbar] [--out|-o <FILENAME>]
               [--output-OBI-header|-O] [--output-json-header]
               [--paired-with <FILENAME>] [--pprof] [--pprof-goroutine <int>]
               [--pprof-mutex <int>] [--skip-empty] [--solexa]
               [--taxonomy|-t <string>] [--update-taxid] [--version] [<args>]

OPTIONS:
    --batch-size <int>          Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z             Compress all the result using gzip (default: false)

    --debug                     Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --demerge|-d <string>       Indicates which slot has to be demerged. (default: "sample")

    --ecopcr                    Read data following the ecoPCR output format. (default: false)

    --embl                      Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy          Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                     Read data following the fasta format. (default: false)

    --fasta-output              Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                     Read data following the fastq format. (default: false)

    --fastq-output              Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu             Force to use only one cpu core for parallel processing (default: false)

    --genbank                   Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                (default: false)

    --input-OBI-header          FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header         FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output               Write sequence in json format. (default: false)

    --max-cpu <int>             Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                  When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar            Disable the progress bar printing (default: false)

    --out|-o <FILENAME>         Filename used for saving the output (default: "-")

    --output-OBI-header|-O      output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header        output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>    Filename containing the paired reads (default: "")

    --pprof                     Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>     Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>         Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                    Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>      Path to the taxonomy database. (default: "")

    --update-taxid              Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                   Prints the version and exits. (default: false)
```

## obitools4_obidistribute

### Tool Description
Distribute sequence records into several output files, by a classifier attribute, in batches or by hash code.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obidistribute --pattern|-p <string> [--append|-A] [--batch-size <int>]
                  [--batches|-n <int>] [--classifier|-c <string>]
                  [--compressed|-Z] [--debug] [--directory|-d <string>]
                  [--ecopcr] [--embl] [--fasta] [--fasta-output] [--fastq]
                  [--fastq-output] [--force-one-cpu] [--genbank]
                  [--hash|-H <int>] [--help|-h|-?] [--input-OBI-header]
                  [--input-json-header] [--json-output] [--max-cpu <int>]
                  [--na-value <string>] [--no-order] [--no-progressbar]
                  [--out|-o <FILENAME>] [--output-OBI-header|-O]
                  [--output-json-header] [--pprof] [--pprof-goroutine <int>]
                  [--pprof-mutex <int>] [--skip-empty] [--solexa] [--version]
                  [<args>]

REQUIRED PARAMETERS:
    --pattern|-p <string>       The template used to build the names of the output files. The variable part is represented by '%s'. Example : toto_%s.fastq.

OPTIONS:
    --append|-A                 Indicates to append sequence to files if they already exist. (default: false)

    --batch-size <int>          Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --batches|-n <int>          Indicates in how many batches the input file must bee splitted. (default: 0)

    --classifier|-c <string>    The name of a tag annotating the sequences. The name must corresponds to a string, a integer or a boolean value. That value will be used to dispatch sequences amoong the different files (default: "")

    --compressed|-Z             Compress all the result using gzip (default: false)

    --debug                     Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --directory|-d <string>     The name of a tag annotating the sequences. The name must corresponds to a string, a integer or a boolean value. That value will be used to dispatch sequences amoong the different directory in conjunction with the -c|--classifier options (default: "")

    --ecopcr                    Read data following the ecoPCR output format. (default: false)

    --embl                      Read data following the EMBL flatfile format. (default: false)

    --fasta                     Read data following the fasta format. (default: false)

    --fasta-output              Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                     Read data following the fastq format. (default: false)

    --fastq-output              Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu             Force to use only one cpu core for parallel processing (default: false)

    --genbank                   Read data following the Genbank flatfile format. (default: false)

    --hash|-H <int>             Indicates to split the input into at most <n> batch based on a hash code of the seequence. (default: 0)

    --help|-h|-?                (default: false)

    --input-OBI-header          FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header         FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output               Write sequence in json format. (default: false)

    --max-cpu <int>             Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --na-value <string>         Value used when the classifier tag is not defined for a sequence. (default: "NA")

    --no-order                  When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar            Disable the progress bar printing (default: false)

    --out|-o <FILENAME>         Filename used for saving the output (default: "-")

    --output-OBI-header|-O      output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header        output FASTA/FASTQ title line annotations follow json format. (default: false)

    --pprof                     Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>     Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>         Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                    Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --version                   Prints the version and exits. (default: false)
```

## obitools4_obigrep

### Tool Description
Select sequence records by identifier, definition, sequence pattern, attributes, length, count, predicate or taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obigrep [--allows-indels] [--approx-pattern <PATTERN>]...
            [--attribute|-a <KEY=VALUE>]... [--batch-size <int>]
            [--compressed|-Z] [--debug] [--definition|-D <PATTERN>]... [--ecopcr]
            [--embl] [--fail-on-taxonomy] [--fasta] [--fasta-output] [--fastq]
            [--fastq-output] [--force-one-cpu] [--genbank]
            [--has-attribute|-A <KEY>]... [--help|-h|-?] [--id-list <FILENAME>]
            [--identifier|-I <PATTERN>]... [--ignore-taxon|-i <TAXID>]...
            [--input-OBI-header] [--input-json-header] [--inverse-match|-v]
            [--json-output] [--max-count|-C <COUNT>] [--max-cpu <int>]
            [--max-length|-L <LENGTH>] [--min-count|-c <COUNT>]
            [--min-length|-l <LENGTH>] [--no-order] [--no-progressbar]
            [--only-forward] [--out|-o <FILENAME>] [--output-OBI-header|-O]
            [--output-json-header]
            [--paired-mode <forward|reverse|and|or|andnot|xor>]
            [--paired-with <FILENAME>] [--pattern-error <int>] [--pprof]
            [--pprof-goroutine <int>] [--pprof-mutex <int>]
            [--predicate|-p <EXPRESSION>]... [--require-rank <RANK_NAME>]...
            [--restrict-to-taxon|-r <TAXID>]... [--save-discarded <FILENAME>]
            [--sequence|-s <PATTERN>]... [--skip-empty] [--solexa]
            [--taxonomy|-t <string>] [--update-taxid] [--valid-taxid] [--version]
            [<args>]

OPTIONS:
    --allows-indels                                      Allows for indel during pattern matching (default: false)

    --approx-pattern <PATTERN>                           Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive. (default: [])

    --attribute|-a <KEY=VALUE>                           Regular expression pattern matched against the attributes of the sequence record. the value of this attribute is of the form : key:regular_pattern. The pattern is case sensitive. Several -a options can be used on the same command line and in this last case, the selected sequence records will match all constraints. (default: {})

    --batch-size <int>                                   Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                                      Compress all the result using gzip (default: false)

    --debug                                              Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --definition|-D <PATTERN>                            Regular expression pattern to be tested against the sequence definition. The pattern is case insensitive. (default: [])

    --ecopcr                                             Read data following the ecoPCR output format. (default: false)

    --embl                                               Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy                                   Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                                              Read data following the fasta format. (default: false)

    --fasta-output                                       Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                                              Read data following the fastq format. (default: false)

    --fastq-output                                       Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                                      Force to use only one cpu core for parallel processing (default: false)

    --genbank                                            Read data following the Genbank flatfile format. (default: false)

    --has-attribute|-A <KEY>                             Selects sequence records having an attribute whose key = <KEY>. (default: [])

    --help|-h|-?                                         (default: false)

    --id-list <FILENAME>                                 <FILENAME> points to a text file containing the list of sequence record identifiers to be selected. The file format consists in a single identifier per line. (default: "")

    --identifier|-I <PATTERN>                            Regular expression pattern to be tested against the sequence identifier. The pattern is case insensitive. (default: [])

    --ignore-taxon|-i <TAXID>                            Require that the actual taxon of the sequence doesn't belong the provided taxid. (default: [])

    --input-OBI-header                                   FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header                                  FASTA/FASTQ title line annotations follow json format. (default: false)

    --inverse-match|-v                                   Inverts the sequence record selection. (default: false)

    --json-output                                        Write sequence in json format. (default: false)

    --max-count|-C <COUNT>                               Selects sequence records occuring no more than max count time in the data set. (default: 2000000000)

    --max-cpu <int>                                      Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --max-length|-L <LENGTH>                             Selects sequence records whose sequence length is equal or shorter than lmax. (default: 2000000000)

    --min-count|-c <COUNT>                               Selects sequence records occuring at least min count time in the data set. (default: 1)

    --min-length|-l <LENGTH>                             Selects sequence records whose sequence length is equal or longer than lmin. (default: 1)

    --no-order                                           When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                                     Disable the progress bar printing (default: false)

    --only-forward                                       Look for pattern only on forward strand (default: false)

    --out|-o <FILENAME>                                  Filename used for saving the output (default: "-")

    --output-OBI-header|-O                               output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header                                 output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-mode <forward|reverse|and|or|andnot|xor>    If paired reads are passed to obibrep, that option determines how the conditions are applied to both reads. (default: "forward")

    --paired-with <FILENAME>                             Filename containing the paired reads (default: "")

    --pattern-error <int>                                Maximum number of allowed error during pattern matching (default: 0)

    --pprof                                              Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>                              Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>                                  Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --predicate|-p <EXPRESSION>                          boolean expression to be evaluated for each sequence record. The attribute keys defined for each sequence record can be used in the expression as variable names. An extra variable named ‘sequence’ refers to the sequence record itself. Several -p options can be used on the same command line and in this last case, the selected sequence records will match all constraints. (default: [])

    --require-rank <RANK_NAME>                           Select sequences belonging a taxon with a rank <RANK_NAME> (default: [])

    --restrict-to-taxon|-r <TAXID>                       Require that the actual taxon of the sequence belongs the provided taxid. (default: [])

    --save-discarded <FILENAME>                          Indicates in which file not selected sequences must be saved. (default: "")

    --sequence|-s <PATTERN>                              Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive. (default: [])

    --skip-empty                                         Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                                             Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>                               Path to the taxonomy database. (default: "")

    --update-taxid                                       Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --valid-taxid                                        Validate the taxonomic classification of the sequences. (default: false)

    --version                                            Prints the version and exits. (default: false)
```

## obitools4_obijoin

### Tool Description
Join sequence records with the records of another file using one or several key attributes.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obijoin --join-with|-j <string> [--batch-size <int>] [--by|-b <string>]...
            [--compressed|-Z] [--debug] [--ecopcr] [--embl] [--fail-on-taxonomy]
            [--fasta] [--fasta-output] [--fastq] [--fastq-output]
            [--force-one-cpu] [--genbank] [--help|-h|-?] [--input-OBI-header]
            [--input-json-header] [--json-output] [--max-cpu <int>] [--no-order]
            [--no-progressbar] [--out|-o <FILENAME>] [--output-OBI-header|-O]
            [--output-json-header] [--paired-with <FILENAME>] [--pprof]
            [--pprof-goroutine <int>] [--pprof-mutex <int>] [--skip-empty]
            [--solexa] [--taxonomy|-t <string>] [--update-id|-i]
            [--update-quality|-q] [--update-sequence|-s] [--update-taxid]
            [--version] [<args>]

REQUIRED PARAMETERS:
    --join-with|-j <string>     file name of the file to join with.

OPTIONS:
    --batch-size <int>          Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --by|-b <string>            to declare join keys. (default: [])

    --compressed|-Z             Compress all the result using gzip (default: false)

    --debug                     Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                    Read data following the ecoPCR output format. (default: false)

    --embl                      Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy          Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                     Read data following the fasta format. (default: false)

    --fasta-output              Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                     Read data following the fastq format. (default: false)

    --fastq-output              Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu             Force to use only one cpu core for parallel processing (default: false)

    --genbank                   Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                (default: false)

    --input-OBI-header          FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header         FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output               Write sequence in json format. (default: false)

    --max-cpu <int>             Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                  When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar            Disable the progress bar printing (default: false)

    --out|-o <FILENAME>         Filename used for saving the output (default: "-")

    --output-OBI-header|-O      output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header        output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>    Filename containing the paired reads (default: "")

    --pprof                     Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>     Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>         Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                    Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>      Path to the taxonomy database. (default: "")

    --update-id|-i              Update the sequence IDs in the joined file. (default: false)

    --update-quality|-q         Update the quality in the joined file. (default: false)

    --update-sequence|-s        Update the sequence in the joined file. (default: false)

    --update-taxid              Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                   Prints the version and exits. (default: false)
```

## obitools4_obikmermatch

### Tool Description
Match query sequences against reference sequences using shared kmers.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obikmermatch [--batch-size <int>] [--compressed|-Z] [--debug]
                 [--delta|-d <int>] [--ecopcr] [--embl] [--fail-on-taxonomy]
                 [--fast-absolute|-a] [--fasta] [--fasta-output] [--fastq]
                 [--fastq-output] [--force-one-cpu] [--gap-penalty|-G <float64>]
                 [--genbank] [--help|-h|-?] [--input-OBI-header]
                 [--input-json-header] [--json-output] [--kmer-size|-k <int>]
                 [--max-cpu <int>] [--max-kmers|-M <int>]
                 [--min-shared-kmers|-m <int>] [--no-order] [--no-progressbar]
                 [--out|-o <FILENAME>] [--output-OBI-header|-O]
                 [--output-json-header] [--paired-with <FILENAME>]
                 [--penalty-scale|-X <float64>] [--pprof]
                 [--pprof-goroutine <int>] [--pprof-mutex <int>]
                 [--reference|-r <string>]... [--self|-s] [--skip-empty]
                 [--solexa] [--sparse|-S] [--taxonomy|-t <string>]
                 [--update-taxid] [--version] [<args>]

OPTIONS:
    --batch-size <int>              Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                 Compress all the result using gzip (default: false)

    --debug                         Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --delta|-d <int>                Delta value for the match. (default: 5)

    --ecopcr                        Read data following the ecoPCR output format. (default: false)

    --embl                          Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy              Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fast-absolute|-a              Use fast absolute score mode. (default: false)

    --fasta                         Read data following the fasta format. (default: false)

    --fasta-output                  Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                         Read data following the fastq format. (default: false)

    --fastq-output                  Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                 Force to use only one cpu core for parallel processing (default: false)

    --gap-penalty|-G <float64>      Gap penalty expressed as the multiply factor applied to the mismatch score between two nucleotides with a quality of 40 (default 2). (default: 2.000000)

    --genbank                       Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                    (default: false)

    --input-OBI-header              FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header             FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                   Write sequence in json format. (default: false)

    --kmer-size|-k <int>            Kmer size to use. (default: 30)

    --max-cpu <int>                 Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --max-kmers|-M <int>            Maximum number of occurrence of a kmer. (default: -1)

    --min-shared-kmers|-m <int>     Minimum number of shared kmers between two sequences. (default: 1)

    --no-order                      When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                Disable the progress bar printing (default: false)

    --out|-o <FILENAME>             Filename used for saving the output (default: "-")

    --output-OBI-header|-O          output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header            output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>        Filename containing the paired reads (default: "")

    --penalty-scale|-X <float64>    Scale factor applied to the mismatch score and the gap penalty (default 1). (default: 1.000000)

    --pprof                         Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>         Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>             Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --reference|-r <string>         Reference sequence. (default: [])

    --self|-s                       Compare references with themselves. (default: false)

    --skip-empty                    Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                        Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --sparse|-S                     Set sparse kmer mode. (default: false)

    --taxonomy|-t <string>          Path to the taxonomy database. (default: "")

    --update-taxid                  Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                       Prints the version and exits. (default: false)
```

## obitools4_obikmersimcount

### Tool Description
Count the kmers that query sequences share with reference sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obikmersimcount [--batch-size <int>] [--compressed|-Z] [--debug] [--ecopcr]
                    [--embl] [--fail-on-taxonomy] [--fasta] [--fasta-output]
                    [--fastq] [--fastq-output] [--force-one-cpu] [--genbank]
                    [--help|-h|-?] [--input-OBI-header] [--input-json-header]
                    [--json-output] [--kmer-size|-k <int>] [--max-cpu <int>]
                    [--max-kmers|-M <int>] [--min-shared-kmers|-m <int>]
                    [--no-order] [--no-progressbar] [--out|-o <FILENAME>]
                    [--output-OBI-header|-O] [--output-json-header]
                    [--paired-with <FILENAME>] [--pprof]
                    [--pprof-goroutine <int>] [--pprof-mutex <int>]
                    [--reference|-r <string>]... [--self|-s] [--skip-empty]
                    [--solexa] [--sparse|-S] [--taxonomy|-t <string>]
                    [--update-taxid] [--version] [<args>]

OPTIONS:
    --batch-size <int>             Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                Compress all the result using gzip (default: false)

    --debug                        Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                       Read data following the ecoPCR output format. (default: false)

    --embl                         Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy             Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                        Read data following the fasta format. (default: false)

    --fasta-output                 Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                        Read data following the fastq format. (default: false)

    --fastq-output                 Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                Force to use only one cpu core for parallel processing (default: false)

    --genbank                      Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                   (default: false)

    --input-OBI-header             FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header            FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                  Write sequence in json format. (default: false)

    --kmer-size|-k <int>           Kmer size to use. (default: 30)

    --max-cpu <int>                Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --max-kmers|-M <int>           Maximum number of occurrence of a kmer. (default: -1)

    --min-shared-kmers|-m <int>    Minimum number of shared kmers between two sequences. (default: 1)

    --no-order                     When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar               Disable the progress bar printing (default: false)

    --out|-o <FILENAME>            Filename used for saving the output (default: "-")

    --output-OBI-header|-O         output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header           output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>       Filename containing the paired reads (default: "")

    --pprof                        Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>        Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>            Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --reference|-r <string>        Reference sequence. (default: [])

    --self|-s                      Compare references with themselves. (default: false)

    --skip-empty                   Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                       Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --sparse|-S                    Set sparse kmer mode. (default: false)

    --taxonomy|-t <string>         Path to the taxonomy database. (default: "")

    --update-taxid                 Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                      Prints the version and exits. (default: false)
```

## obitools4_obilandmark

### Tool Description
Select landmark sequences from a collection and annotate each sequence with its coordinates relative to the landmarks.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obilandmark [--batch-size <int>] [--center|-n <int>] [--compressed|-Z]
                [--debug] [--ecopcr] [--embl] [--fail-on-taxonomy] [--fasta]
                [--fasta-output] [--fastq] [--fastq-output] [--force-one-cpu]
                [--genbank] [--help|-h|-?] [--input-OBI-header]
                [--input-json-header] [--json-output] [--max-cpu <int>]
                [--no-order] [--no-progressbar] [--out|-o <FILENAME>]
                [--output-OBI-header|-O] [--output-json-header] [--pprof]
                [--pprof-goroutine <int>] [--pprof-mutex <int>] [--skip-empty]
                [--solexa] [--taxonomy|-t <string>] [--update-taxid] [--version]
                [<args>]

OPTIONS:
    --batch-size <int>         Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --center|-n <int>          Number of landmark sequences to be selected. (default: 200)

    --compressed|-Z            Compress all the result using gzip (default: false)

    --debug                    Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                   Read data following the ecoPCR output format. (default: false)

    --embl                     Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy         Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                    Read data following the fasta format. (default: false)

    --fasta-output             Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                    Read data following the fastq format. (default: false)

    --fastq-output             Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu            Force to use only one cpu core for parallel processing (default: false)

    --genbank                  Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?               (default: false)

    --input-OBI-header         FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header        FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output              Write sequence in json format. (default: false)

    --max-cpu <int>            Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                 When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar           Disable the progress bar printing (default: false)

    --out|-o <FILENAME>        Filename used for saving the output (default: "-")

    --output-OBI-header|-O     output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header       output FASTA/FASTQ title line annotations follow json format. (default: false)

    --pprof                    Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>    Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>        Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty               Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                   Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>     Path to the taxonomy database. (default: "")

    --update-taxid             Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                  Prints the version and exits. (default: false)
```

## obitools4_obimatrix

### Tool Description
Build a sample by sequence abundance matrix from a merged attribute (for example merged_sample).

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obimatrix [--batch-size <int>] [--debug] [--ecopcr] [--embl] [--fasta]
              [--fastq] [--force-one-cpu] [--genbank] [--help|-h|-?]
              [--input-OBI-header] [--input-json-header] [--map <string>]
              [--max-cpu <int>] [--na-value <string>] [--no-order] [--pprof]
              [--pprof-goroutine <int>] [--pprof-mutex <int>]
              [--sample-name <string>] [--solexa] [--three-columns] [--transpose]
              [--value-name <string>] [--version] [<args>]

OPTIONS:
    --batch-size <int>         Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --debug                    Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                   Read data following the ecoPCR output format. (default: false)

    --embl                     Read data following the EMBL flatfile format. (default: false)

    --fasta                    Read data following the fasta format. (default: false)

    --fastq                    Read data following the fastq format. (default: false)

    --force-one-cpu            Force to use only one cpu core for parallel processing (default: false)

    --genbank                  Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?               (default: false)

    --input-OBI-header         FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header        FASTA/FASTQ title line annotations follow json format. (default: false)

    --map <string>             Which attribute is usd to produce th matrix. (default: "merged_sample")

    --max-cpu <int>            Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --na-value <string>        Value used when the map attribute is not defined for a sequence. (default: "0")

    --no-order                 When several input files are provided, indicates that there is no order among them. (default: false)

    --pprof                    Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>    Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>        Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --sample-name <string>     Name of the coulumn containing the sample names in the three column format. (default: "sample")

    --solexa                   Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --three-columns            Printouts the matrix in tree column format. (default: false)

    --transpose                Printouts the transposed matrix. (default: true)

    --value-name <string>      Name of the coulumn containing the values in the three column format. (default: "count")

    --version                  Prints the version and exits. (default: false)
```

## obitools4_obimicrosat

### Tool Description
Find microsatellite repeats in sequences and annotate their units, lengths and flanking regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obimicrosat [--batch-size <int>] [--compressed|-Z] [--debug] [--ecopcr]
                [--embl] [--fail-on-taxonomy] [--fasta] [--fasta-output]
                [--fastq] [--fastq-output] [--force-one-cpu] [--genbank]
                [--help|-h|-?] [--input-OBI-header] [--input-json-header]
                [--json-output] [--max-cpu <int>] [--max-unit-length|-M <int>]
                [--min-flank-length|-f <int>] [--min-length|-l <int>]
                [--min-unit-count <int>] [--min-unit-length|-m <int>]
                [--no-order] [--no-progressbar] [--not-reoriented|-n]
                [--out|-o <FILENAME>] [--output-OBI-header|-O]
                [--output-json-header] [--paired-with <FILENAME>] [--pprof]
                [--pprof-goroutine <int>] [--pprof-mutex <int>] [--skip-empty]
                [--solexa] [--taxonomy|-t <string>] [--update-taxid] [--version]
                [<args>]

OPTIONS:
    --batch-size <int>             Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                Compress all the result using gzip (default: false)

    --debug                        Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                       Read data following the ecoPCR output format. (default: false)

    --embl                         Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy             Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                        Read data following the fasta format. (default: false)

    --fasta-output                 Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                        Read data following the fastq format. (default: false)

    --fastq-output                 Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                Force to use only one cpu core for parallel processing (default: false)

    --genbank                      Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                   (default: false)

    --input-OBI-header             FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header            FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                  Write sequence in json format. (default: false)

    --max-cpu <int>                Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --max-unit-length|-M <int>     Maximum length of a microsatellite unit. (default: 6)

    --min-flank-length|-f <int>    Minimum length of the flanking sequences. (default: 0)

    --min-length|-l <int>          Minimum length of a microsatellite. (default: 20)

    --min-unit-count <int>         Minumum number of repeated units. (default: 5)

    --min-unit-length|-m <int>     Minimum length of a microsatellite unit. (default: 1)

    --no-order                     When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar               Disable the progress bar printing (default: false)

    --not-reoriented|-n            Do not reorient the microsatellites. (default: false)

    --out|-o <FILENAME>            Filename used for saving the output (default: "-")

    --output-OBI-header|-O         output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header           output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>       Filename containing the paired reads (default: "")

    --pprof                        Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>        Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>            Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                   Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                       Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>         Path to the taxonomy database. (default: "")

    --update-taxid                 Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                      Prints the version and exits. (default: false)
```

## obitools4_obimultiplex

### Tool Description
Demultiplex reads (assign reads to samples) using an NGSFilter file that lists tags and primers for each PCR.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obimultiplex [--allowed-mismatches|-e <int>] [--batch-size <int>]
                 [--compressed|-Z] [--debug] [--ecopcr] [--embl]
                 [--fail-on-taxonomy] [--fasta] [--fasta-output] [--fastq]
                 [--fastq-output] [--force-one-cpu] [--genbank] [--help|-h|-?]
                 [--input-OBI-header] [--input-json-header] [--json-output]
                 [--keep-errors] [--max-cpu <int>] [--no-order]
                 [--no-progressbar] [--out|-o <FILENAME>]
                 [--output-OBI-header|-O] [--output-json-header]
                 [--paired-with <FILENAME>] [--pprof] [--pprof-goroutine <int>]
                 [--pprof-mutex <int>] [--skip-empty] [--solexa]
                 [--tag-list|-s <string>] [--taxonomy|-t <string>] [--template]
                 [--unidentified|-u <string>] [--update-taxid] [--version]
                 [--with-indels] [<args>]

OPTIONS:
    --allowed-mismatches|-e <int>    Used to specify the number of errors allowed for matching primers. (default: -1)

    --batch-size <int>               Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                  Compress all the result using gzip (default: false)

    --debug                          Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                         Read data following the ecoPCR output format. (default: false)

    --embl                           Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy               Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                          Read data following the fasta format. (default: false)

    --fasta-output                   Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                          Read data following the fastq format. (default: false)

    --fastq-output                   Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                  Force to use only one cpu core for parallel processing (default: false)

    --genbank                        Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                     (default: false)

    --input-OBI-header               FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header              FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                    Write sequence in json format. (default: false)

    --keep-errors                    Prints symbol counts. (default: false)

    --max-cpu <int>                  Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                       When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                 Disable the progress bar printing (default: false)

    --out|-o <FILENAME>              Filename used for saving the output (default: "-")

    --output-OBI-header|-O           output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header             output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>         Filename containing the paired reads (default: "")

    --pprof                          Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>          Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>              Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                     Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                         Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --tag-list|-s <string>           File name of the NGSFilter file describing PCRs. (default: "")

    --taxonomy|-t <string>           Path to the taxonomy database. (default: "")

    --template                       Print on the standard output an example of CSV configuration file. (default: false)

    --unidentified|-u <string>       Filename used to store the sequences unassigned to any sample. (default: "")

    --update-taxid                   Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                        Prints the version and exits. (default: false)

    --with-indels                    Allows for indels during the primers matching. (default: false)
```

## obitools4_obipairing

### Tool Description
Align and merge overlapping paired-end reads into consensus sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obipairing --forward-reads|-F <FILENAME_F> --reverse-reads|-R <FILENAME_R>
               [--batch-size <int>] [--compressed|-Z] [--debug]
               [--delta|-D <int>] [--ecopcr] [--embl] [--exact-mode]
               [--fast-absolute] [--fasta] [--fasta-output] [--fastq]
               [--fastq-output] [--force-one-cpu] [--gap-penalty|-G <float64>]
               [--genbank] [--help|-h|-?] [--input-OBI-header]
               [--input-json-header] [--json-output] [--max-cpu <int>]
               [--min-identity|-X <float64>] [--min-overlap <int>] [--no-order]
               [--no-progressbar] [--out|-o <FILENAME>] [--output-OBI-header|-O]
               [--output-json-header] [--penalty-scale <float64>] [--pprof]
               [--pprof-goroutine <int>] [--pprof-mutex <int>] [--skip-empty]
               [--solexa] [--version] [--without-stat|-S] [<args>]

REQUIRED PARAMETERS:
    --forward-reads|-F <FILENAME_F>    The file names containing the forward reads

    --reverse-reads|-R <FILENAME_R>    The file names containing the reverse reads

OPTIONS:
    --batch-size <int>                 Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                    Compress all the result using gzip (default: false)

    --debug                            Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --delta|-D <int>                   Length added to the fast detected overlap for the precise alignement (default: 5)

    --ecopcr                           Read data following the ecoPCR output format. (default: false)

    --embl                             Read data following the EMBL flatfile format. (default: false)

    --exact-mode                       Do not run fast alignment heuristic. (default: false)

    --fast-absolute                    Compute absolute fast score (no action in exact mode). (default: false)

    --fasta                            Read data following the fasta format. (default: false)

    --fasta-output                     Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                            Read data following the fastq format. (default: false)

    --fastq-output                     Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                    Force to use only one cpu core for parallel processing (default: false)

    --gap-penalty|-G <float64>         Gap penaity expressed as the multiply factor applied to the mismatch score between two nucleotides with a quality of 40 (default 2). (default: 2.000000)

    --genbank                          Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                       (default: false)

    --input-OBI-header                 FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header                FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                      Write sequence in json format. (default: false)

    --max-cpu <int>                    Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --min-identity|-X <float64>        Minimum identity between ovelaped regions of the reads to consider the aligment (default: 0.900000)

    --min-overlap <int>                Minimum ovelap between both the reads to consider the aligment (default: 20)

    --no-order                         When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                   Disable the progress bar printing (default: false)

    --out|-o <FILENAME>                Filename used for saving the output (default: "-")

    --output-OBI-header|-O             output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header               output FASTA/FASTQ title line annotations follow json format. (default: false)

    --penalty-scale <float64>          Scale factor applied to the mismatch score and the gap penalty (default 1). (default: 1.000000)

    --pprof                            Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>            Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>                Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                       Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                           Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --version                          Prints the version and exits. (default: false)

    --without-stat|-S                  Remove alignment statistics from the produced consensus sequences. (default: false)
```

## obitools4_obipcr

### Tool Description
In silico PCR: extract the barcode regions that lie between a forward and a reverse primer.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obipcr --forward <string> --max-length|-L <int> --reverse <string>
           [--allowed-mismatches|-e <int>] [--batch-size <int>] [--circular|-c]
           [--compressed|-Z] [--debug] [--delta|-D <int>] [--ecopcr] [--embl]
           [--fail-on-taxonomy] [--fasta] [--fasta-output] [--fastq]
           [--fastq-output] [--force-one-cpu] [--fragmented] [--genbank]
           [--help|-h|-?] [--input-OBI-header] [--input-json-header]
           [--json-output] [--max-cpu <int>] [--min-length|-l <int>] [--no-order]
           [--no-progressbar] [--only-complete-flanking] [--out|-o <FILENAME>]
           [--output-OBI-header|-O] [--output-json-header]
           [--paired-with <FILENAME>] [--pprof] [--pprof-goroutine <int>]
           [--pprof-mutex <int>] [--skip-empty] [--solexa]
           [--taxonomy|-t <string>] [--update-taxid] [--version] [<args>]

REQUIRED PARAMETERS:
    --forward <string>               The forward primer used for the electronic PCR.

    --max-length|-L <int>            Maximum length of the barcode (primers excluded).

    --reverse <string>               The reverse primer used for the electronic PCR.

OPTIONS:
    --allowed-mismatches|-e <int>    Maximum number of mismatches allowed for each primer. (default: 0)

    --batch-size <int>               Number of sequence per batch for paralelle processing (default: 10, env: OBIBATCHSIZE)

    --circular|-c                    Considers that sequences are [c]ircular. (default: false)

    --compressed|-Z                  Compress all the result using gzip (default: false)

    --debug                          Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --delta|-D <int>                 Lenght of the sequence fragment to be added to the barcode extremities. (default: -1)

    --ecopcr                         Read data following the ecoPCR output format. (default: false)

    --embl                           Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy               Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                          Read data following the fasta format. (default: false)

    --fasta-output                   Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                          Read data following the fastq format. (default: false)

    --fastq-output                   Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                  Force to use only one cpu core for parallel processing (default: false)

    --fragmented                     Fragments long sequences in overlaping fragments to speedup computations (default: false)

    --genbank                        Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                     (default: false)

    --input-OBI-header               FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header              FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                    Write sequence in json format. (default: false)

    --max-cpu <int>                  Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --min-length|-l <int>            Minimum length of the barcode (primers excluded). (default: 0)

    --no-order                       When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                 Disable the progress bar printing (default: false)

    --only-complete-flanking         Only fragments with complete flanking sequences are printed. (default: false)

    --out|-o <FILENAME>              Filename used for saving the output (default: "-")

    --output-OBI-header|-O           output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header             output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>         Filename containing the paired reads (default: "")

    --pprof                          Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>          Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>              Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                     Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                         Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>           Path to the taxonomy database. (default: "")

    --update-taxid                   Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                        Prints the version and exits. (default: false)
```

## obitools4_obiscript

### Tool Description
Process sequence records with a Lua script, optionally after selecting records with obigrep-like conditions.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obiscript [--allows-indels] [--approx-pattern <PATTERN>]...
              [--attribute|-a <KEY=VALUE>]... [--batch-size <int>]
              [--compressed|-Z] [--debug] [--definition|-D <PATTERN>]...
              [--ecopcr] [--embl] [--fail-on-taxonomy] [--fasta] [--fasta-output]
              [--fastq] [--fastq-output] [--force-one-cpu] [--genbank]
              [--has-attribute|-A <KEY>]... [--help|-h|-?] [--id-list <FILENAME>]
              [--identifier|-I <PATTERN>]... [--ignore-taxon|-i <TAXID>]...
              [--input-OBI-header] [--input-json-header] [--inverse-match|-v]
              [--json-output] [--max-count|-C <COUNT>] [--max-cpu <int>]
              [--max-length|-L <LENGTH>] [--min-count|-c <COUNT>]
              [--min-length|-l <LENGTH>] [--no-order] [--no-progressbar]
              [--only-forward] [--out|-o <FILENAME>] [--output-OBI-header|-O]
              [--output-json-header]
              [--paired-mode <forward|reverse|and|or|andnot|xor>]
              [--paired-with <FILENAME>] [--pattern-error <int>] [--pprof]
              [--pprof-goroutine <int>] [--pprof-mutex <int>]
              [--predicate|-p <EXPRESSION>]... [--require-rank <RANK_NAME>]...
              [--restrict-to-taxon|-r <TAXID>]... [--script|-S <string>]
              [--sequence|-s <PATTERN>]... [--skip-empty] [--solexa]
              [--taxonomy|-t <string>] [--template] [--update-taxid]
              [--valid-taxid] [--version] [<args>]

OPTIONS:
    --allows-indels                                      Allows for indel during pattern matching (default: false)

    --approx-pattern <PATTERN>                           Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive. (default: [])

    --attribute|-a <KEY=VALUE>                           Regular expression pattern matched against the attributes of the sequence record. the value of this attribute is of the form : key:regular_pattern. The pattern is case sensitive. Several -a options can be used on the same command line and in this last case, the selected sequence records will match all constraints. (default: {})

    --batch-size <int>                                   Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                                      Compress all the result using gzip (default: false)

    --debug                                              Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --definition|-D <PATTERN>                            Regular expression pattern to be tested against the sequence definition. The pattern is case insensitive. (default: [])

    --ecopcr                                             Read data following the ecoPCR output format. (default: false)

    --embl                                               Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy                                   Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                                              Read data following the fasta format. (default: false)

    --fasta-output                                       Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                                              Read data following the fastq format. (default: false)

    --fastq-output                                       Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                                      Force to use only one cpu core for parallel processing (default: false)

    --genbank                                            Read data following the Genbank flatfile format. (default: false)

    --has-attribute|-A <KEY>                             Selects sequence records having an attribute whose key = <KEY>. (default: [])

    --help|-h|-?                                         (default: false)

    --id-list <FILENAME>                                 <FILENAME> points to a text file containing the list of sequence record identifiers to be selected. The file format consists in a single identifier per line. (default: "")

    --identifier|-I <PATTERN>                            Regular expression pattern to be tested against the sequence identifier. The pattern is case insensitive. (default: [])

    --ignore-taxon|-i <TAXID>                            Require that the actual taxon of the sequence doesn't belong the provided taxid. (default: [])

    --input-OBI-header                                   FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header                                  FASTA/FASTQ title line annotations follow json format. (default: false)

    --inverse-match|-v                                   Inverts the sequence record selection. (default: false)

    --json-output                                        Write sequence in json format. (default: false)

    --max-count|-C <COUNT>                               Selects sequence records occuring no more than max count time in the data set. (default: 2000000000)

    --max-cpu <int>                                      Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --max-length|-L <LENGTH>                             Selects sequence records whose sequence length is equal or shorter than lmax. (default: 2000000000)

    --min-count|-c <COUNT>                               Selects sequence records occuring at least min count time in the data set. (default: 1)

    --min-length|-l <LENGTH>                             Selects sequence records whose sequence length is equal or longer than lmin. (default: 1)

    --no-order                                           When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                                     Disable the progress bar printing (default: false)

    --only-forward                                       Look for pattern only on forward strand (default: false)

    --out|-o <FILENAME>                                  Filename used for saving the output (default: "-")

    --output-OBI-header|-O                               output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header                                 output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-mode <forward|reverse|and|or|andnot|xor>    If paired reads are passed to obibrep, that option determines how the conditions are applied to both reads. (default: "forward")

    --paired-with <FILENAME>                             Filename containing the paired reads (default: "")

    --pattern-error <int>                                Maximum number of allowed error during pattern matching (default: 0)

    --pprof                                              Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>                              Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>                                  Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --predicate|-p <EXPRESSION>                          boolean expression to be evaluated for each sequence record. The attribute keys defined for each sequence record can be used in the expression as variable names. An extra variable named ‘sequence’ refers to the sequence record itself. Several -p options can be used on the same command line and in this last case, the selected sequence records will match all constraints. (default: [])

    --require-rank <RANK_NAME>                           Select sequences belonging a taxon with a rank <RANK_NAME> (default: [])

    --restrict-to-taxon|-r <TAXID>                       Require that the actual taxon of the sequence belongs the provided taxid. (default: [])

    --script|-S <string>                                 The script to execute. (default: "")

    --sequence|-s <PATTERN>                              Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive. (default: [])

    --skip-empty                                         Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                                             Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>                               Path to the taxonomy database. (default: "")

    --template                                           Print on the standard output a script template. (default: false)

    --update-taxid                                       Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --valid-taxid                                        Validate the taxonomic classification of the sequences. (default: false)

    --version                                            Prints the version and exits. (default: false)
```

## obitools4_obisplit

### Tool Description
Split sequences into fragments according to a configuration file that describes the patterns to find.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obisplit [--allows-indels] [--batch-size <int>] [--compressed|-Z]
             [--config|-C <string>] [--debug] [--ecopcr] [--embl]
             [--fail-on-taxonomy] [--fasta] [--fasta-output] [--fastq]
             [--fastq-output] [--force-one-cpu] [--genbank] [--help|-h|-?]
             [--input-OBI-header] [--input-json-header] [--json-output]
             [--max-cpu <int>] [--no-order] [--no-progressbar]
             [--out|-o <FILENAME>] [--output-OBI-header|-O]
             [--output-json-header] [--paired-with <FILENAME>]
             [--pattern-error <int>] [--pprof] [--pprof-goroutine <int>]
             [--pprof-mutex <int>] [--skip-empty] [--solexa]
             [--taxonomy|-t <string>] [--template] [--update-taxid] [--version]
             [<args>]

OPTIONS:
    --allows-indels             Allows for indel during pattern matching (default: false)

    --batch-size <int>          Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z             Compress all the result using gzip (default: false)

    --config|-C <string>        The configuration file. (default: "")

    --debug                     Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                    Read data following the ecoPCR output format. (default: false)

    --embl                      Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy          Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                     Read data following the fasta format. (default: false)

    --fasta-output              Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                     Read data following the fastq format. (default: false)

    --fastq-output              Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu             Force to use only one cpu core for parallel processing (default: false)

    --genbank                   Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                (default: false)

    --input-OBI-header          FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header         FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output               Write sequence in json format. (default: false)

    --max-cpu <int>             Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                  When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar            Disable the progress bar printing (default: false)

    --out|-o <FILENAME>         Filename used for saving the output (default: "-")

    --output-OBI-header|-O      output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header        output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>    Filename containing the paired reads (default: "")

    --pattern-error <int>       Maximum number of allowed error during pattern matching (default: 4)

    --pprof                     Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>     Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>         Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                    Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>      Path to the taxonomy database. (default: "")

    --template                  Print on the standard output a script template. (default: false)

    --update-taxid              Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                   Prints the version and exits. (default: false)
```

## obitools4_obisummary

### Tool Description
Print summary statistics of a sequence file (counts, lengths, attributes and map attributes).

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obisummary [--batch-size <int>] [--debug] [--ecopcr] [--embl] [--fasta]
               [--fastq] [--force-one-cpu] [--genbank] [--help|-h|-?]
               [--input-OBI-header] [--input-json-header] [--json-output]
               [--map <string>]... [--max-cpu <int>] [--no-order] [--pprof]
               [--pprof-goroutine <int>] [--pprof-mutex <int>] [--solexa]
               [--version] [--yaml-output] [<args>]

OPTIONS:
    --batch-size <int>         Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --debug                    Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                   Read data following the ecoPCR output format. (default: false)

    --embl                     Read data following the EMBL flatfile format. (default: false)

    --fasta                    Read data following the fasta format. (default: false)

    --fastq                    Read data following the fastq format. (default: false)

    --force-one-cpu            Force to use only one cpu core for parallel processing (default: false)

    --genbank                  Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?               (default: false)

    --input-OBI-header         FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header        FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output              Print results as JSON record. (default: false)

    --map <string>             Name of a map attribute. (default: [])

    --max-cpu <int>            Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                 When several input files are provided, indicates that there is no order among them. (default: false)

    --pprof                    Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>    Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>        Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --solexa                   Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --version                  Prints the version and exits. (default: false)

    --yaml-output              Print results as YAML record. (default: false)
```

## obitools4_obitag

### Tool Description
Assign a taxonomic identification to sequences by comparing them with a reference database that has taxonomic annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obitag --reference-db|-R <FILENAME> [--batch-size <int>] [--compressed|-Z]
           [--debug] [--ecopcr] [--embl] [--fail-on-taxonomy] [--fasta]
           [--fasta-output] [--fastq] [--fastq-output] [--force-one-cpu]
           [--genbank] [--geometric|-G] [--help|-h|-?] [--input-OBI-header]
           [--input-json-header] [--json-output] [--max-cpu <int>] [--no-order]
           [--no-progressbar] [--out|-o <FILENAME>] [--output-OBI-header|-O]
           [--output-json-header] [--paired-with <FILENAME>] [--pprof]
           [--pprof-goroutine <int>] [--pprof-mutex <int>] [--save-db <FILENAME>]
           [--skip-empty] [--solexa] [--taxonomy|-t <string>] [--update-taxid]
           [--version] [<args>]

REQUIRED PARAMETERS:
    --reference-db|-R <FILENAME>    The name of the file containing the reference DB

OPTIONS:
    --batch-size <int>              Number of sequence per batch for paralelle processing (default: 10, env: OBIBATCHSIZE)

    --compressed|-Z                 Compress all the result using gzip (default: false)

    --debug                         Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                        Read data following the ecoPCR output format. (default: false)

    --embl                          Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy              Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                         Read data following the fasta format. (default: false)

    --fasta-output                  Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                         Read data following the fastq format. (default: false)

    --fastq-output                  Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                 Force to use only one cpu core for parallel processing (default: false)

    --genbank                       Read data following the Genbank flatfile format. (default: false)

    --geometric|-G                  Activate the experimental geometric similarity heuristic (default: false)

    --help|-h|-?                    (default: false)

    --input-OBI-header              FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header             FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                   Write sequence in json format. (default: false)

    --max-cpu <int>                 Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-order                      When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                Disable the progress bar printing (default: false)

    --out|-o <FILENAME>             Filename used for saving the output (default: "-")

    --output-OBI-header|-O          output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header            output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>        Filename containing the paired reads (default: "")

    --pprof                         Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>         Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>             Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --save-db <FILENAME>            The name of a file where to save the reference DB with its indices (default: "")

    --skip-empty                    Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                        Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>          Path to the taxonomy database. (default: "")

    --update-taxid                  Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                       Prints the version and exits. (default: false)
```

## obitools4_obitagpcr

### Tool Description
Pair forward and reverse reads, then demultiplex them with an NGSFilter file (obipairing and obimultiplex in one step).

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obitagpcr --forward-reads|-F <FILENAME_F> --reverse-reads|-R <FILENAME_R>
              [--allowed-mismatches|-e <int>] [--batch-size <int>]
              [--compressed|-Z] [--debug] [--delta|-D <int>] [--ecopcr] [--embl]
              [--exact-mode] [--fast-absolute] [--fasta] [--fasta-output]
              [--fastq] [--fastq-output] [--force-one-cpu]
              [--gap-penalty|-G <float64>] [--genbank] [--help|-h|-?]
              [--input-OBI-header] [--input-json-header] [--json-output]
              [--keep-errors] [--max-cpu <int>] [--min-identity|-X <float64>]
              [--min-overlap <int>] [--no-order] [--no-progressbar]
              [--out|-o <FILENAME>] [--output-OBI-header|-O]
              [--output-json-header] [--penalty-scale <float64>] [--pprof]
              [--pprof-goroutine <int>] [--pprof-mutex <int>] [--reorientate]
              [--skip-empty] [--solexa] [--tag-list|-s <string>] [--template]
              [--unidentified|-u <string>] [--version] [--with-indels]
              [--without-stat|-S] [<args>]

REQUIRED PARAMETERS:
    --forward-reads|-F <FILENAME_F>    The file names containing the forward reads

    --reverse-reads|-R <FILENAME_R>    The file names containing the reverse reads

OPTIONS:
    --allowed-mismatches|-e <int>      Used to specify the number of errors allowed for matching primers. (default: -1)

    --batch-size <int>                 Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --compressed|-Z                    Compress all the result using gzip (default: false)

    --debug                            Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --delta|-D <int>                   Length added to the fast detected overlap for the precise alignement (default: 5)

    --ecopcr                           Read data following the ecoPCR output format. (default: false)

    --embl                             Read data following the EMBL flatfile format. (default: false)

    --exact-mode                       Do not run fast alignment heuristic. (default: false)

    --fast-absolute                    Compute absolute fast score (no action in exact mode). (default: false)

    --fasta                            Read data following the fasta format. (default: false)

    --fasta-output                     Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                            Read data following the fastq format. (default: false)

    --fastq-output                     Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                    Force to use only one cpu core for parallel processing (default: false)

    --gap-penalty|-G <float64>         Gap penaity expressed as the multiply factor applied to the mismatch score between two nucleotides with a quality of 40 (default 2). (default: 2.000000)

    --genbank                          Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                       (default: false)

    --input-OBI-header                 FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header                FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                      Write sequence in json format. (default: false)

    --keep-errors                      Prints symbol counts. (default: false)

    --max-cpu <int>                    Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --min-identity|-X <float64>        Minimum identity between ovelaped regions of the reads to consider the aligment (default: 0.900000)

    --min-overlap <int>                Minimum ovelap between both the reads to consider the aligment (default: 20)

    --no-order                         When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                   Disable the progress bar printing (default: false)

    --out|-o <FILENAME>                Filename used for saving the output (default: "-")

    --output-OBI-header|-O             output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header               output FASTA/FASTQ title line annotations follow json format. (default: false)

    --penalty-scale <float64>          Scale factor applied to the mismatch score and the gap penalty (default 1). (default: 1.000000)

    --pprof                            Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>            Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>                Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --reorientate                      Reverse complemente reads if needed to store all the sequences in the same orientation respectively to forward and reverse primers (default: false)

    --skip-empty                       Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                           Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --tag-list|-s <string>             File name of the NGSFilter file describing PCRs. (default: "")

    --template                         Print on the standard output an example of CSV configuration file. (default: false)

    --unidentified|-u <string>         Filename used to store the sequences unassigned to any sample. (default: "")

    --version                          Prints the version and exits. (default: false)

    --with-indels                      Allows for indels during the primers matching. (default: false)

    --without-stat|-S                  Remove alignment statistics from the produced consensus sequences. (default: false)
```

## obitools4_obitaxonomy

### Tool Description
Query, extract, download or dump a taxonomy (NCBI taxdump or a taxonomy extracted from sequences).

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obitaxonomy [--alternative-names|-a] [--batch-size <int>] [--debug]
                [--download-ncbi] [--dump|-D <TAXID>] [--extract-taxonomy]
                [--fail-on-taxonomy] [--fixed|-F] [--force-one-cpu]
                [--help|-h|-?] [--max-cpu <int>] [--no-progressbar]
                [--out|-o <FILENAME>] [--parents|-p <TAXID>] [--pprof]
                [--pprof-goroutine <int>] [--pprof-mutex <int>] [--rank <RANK>]
                [--rank-list|-l] [--raw-taxid]
                [--restrict-to-taxon|-r <string>]... [--solexa]
                [--sons|-s <TAXID>] [--taxonomy|-t <string>] [--update-taxid]
                [--version] [--with-path] [--with-query|-P] [--without-parent]
                [--without-rank|-R] [--without-scientific-name|-S] [<args>]

OPTIONS:
    --alternative-names|-a             Enable the search on all alternative names and not only scientific names. (default: false)

    --batch-size <int>                 Number of sequence per batch for paralelle processing (default: 2000, env: OBIBATCHSIZE)

    --debug                            Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --download-ncbi                    Download the current NCBI taxonomy taxdump (default: false)

    --dump|-D <TAXID>                  Dump a sub-taxonomy corresponding to the precised clade (default: "")

    --extract-taxonomy                 Extract taxonomy from a sequence file (default: false)

    --fail-on-taxonomy                 Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fixed|-F                         Match taxon names using a fixed pattern, not a regular expression (default: false)

    --force-one-cpu                    Force to use only one cpu core for parallel processing (default: false)

    --help|-h|-?                       (default: false)

    --max-cpu <int>                    Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --no-progressbar                   Disable the progress bar printing (default: false)

    --out|-o <FILENAME>                Filename used for saving the output (default: "-")

    --parents|-p <TAXID>               Displays every parental tree's information for the provided taxid. (default: "NA")

    --pprof                            Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>            Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>                Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --rank <RANK>                      Restrict to the given taxonomic rank. (default: "")

    --rank-list|-l                     List every taxonomic rank available in the taxonomy. (default: false)

    --raw-taxid                        Displays the raw taxid for each displayed taxon. (default: false)

    --restrict-to-taxon|-r <string>    Restrict output to some subclades. (default: [])

    --solexa                           Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --sons|-s <TAXID>                  Displays every sons' tree's information for the provided taxid. (default: "NA")

    --taxonomy|-t <string>             Path to the taxonomy database. (default: "")

    --update-taxid                     Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                          Prints the version and exits. (default: false)

    --with-path                        Adds a column containing the full path for each displayed taxon. (default: false)

    --with-query|-P                    Adds a column containing query used to filter taxon name for each displayed taxon. (default: false)

    --without-parent                   Supress the column containing the parent's taxonid from the output. (default: false)

    --without-rank|-R                  Supress the column containing the taxonomic rank from the output. (default: false)

    --without-scientific-name|-S       Supress the column containing the scientific name from the output. (default: false)
```

## obitools4_obiuniq

### Tool Description
Dereplicate sequences: merge identical sequences into one record that carries the count and merged attributes.

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS

### Original Help Text
```text
SYNOPSIS:
    obiuniq [--batch-size <int>] [--category-attribute|-c <CATEGORY>]...
            [--chunk-count <int>] [--compressed|-Z] [--debug] [--ecopcr] [--embl]
            [--fail-on-taxonomy] [--fasta] [--fasta-output] [--fastq]
            [--fastq-output] [--force-one-cpu] [--genbank] [--help|-h|-?]
            [--in-memory] [--input-OBI-header] [--input-json-header]
            [--json-output] [--max-cpu <int>] [--merge|-m <KEY>]...
            [--na-value <NA_NAME>] [--no-order] [--no-progressbar]
            [--no-singleton] [--out|-o <FILENAME>] [--output-OBI-header|-O]
            [--output-json-header] [--paired-with <FILENAME>] [--pprof]
            [--pprof-goroutine <int>] [--pprof-mutex <int>] [--skip-empty]
            [--solexa] [--taxonomy|-t <string>] [--update-taxid] [--version]
            [<args>]

OPTIONS:
    --batch-size <int>                    Number of sequence per batch for paralelle processing (default: 10, env: OBIBATCHSIZE)

    --category-attribute|-c <CATEGORY>    Adds one attribute to the list of attributes used to define sequence groups (this option can be used several times). (default: [])

    --chunk-count <int>                   In how many chunk the dataset is pre-devided for speeding up the process. (default: 100)

    --compressed|-Z                       Compress all the result using gzip (default: false)

    --debug                               Enable debug mode, by setting log level to debug. (default: false, env: OBIDEBUG)

    --ecopcr                              Read data following the ecoPCR output format. (default: false)

    --embl                                Read data following the EMBL flatfile format. (default: false)

    --fail-on-taxonomy                    Make obitools failing on error if a used taxid is not a currently valid one (default: false)

    --fasta                               Read data following the fasta format. (default: false)

    --fasta-output                        Write sequence in fasta format (default if no quality data available). (default: false)

    --fastq                               Read data following the fastq format. (default: false)

    --fastq-output                        Write sequence in fastq format (default if quality data available). (default: false)

    --force-one-cpu                       Force to use only one cpu core for parallel processing (default: false)

    --genbank                             Read data following the Genbank flatfile format. (default: false)

    --help|-h|-?                          (default: false)

    --in-memory                           Use memory instead of disk to store data chunks. (default: false)

    --input-OBI-header                    FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --input-json-header                   FASTA/FASTQ title line annotations follow json format. (default: false)

    --json-output                         Write sequence in json format. (default: false)

    --max-cpu <int>                       Number of parallele threads computing the result (default: 20, env: OBIMAXCPU)

    --merge|-m <KEY>                      Adds a merged attribute containing the list of sequence record ids merged within this group. (default: [])

    --na-value <NA_NAME>                  Value used when the classifier tag is not defined for a sequence. (default: "NA")

    --no-order                            When several input files are provided, indicates that there is no order among them. (default: false)

    --no-progressbar                      Disable the progress bar printing (default: false)

    --no-singleton                        If set, sequences occurring a single time in the data set are discarded. (default: false)

    --out|-o <FILENAME>                   Filename used for saving the output (default: "-")

    --output-OBI-header|-O                output FASTA/FASTQ title line annotations follow OBI format. (default: false)

    --output-json-header                  output FASTA/FASTQ title line annotations follow json format. (default: false)

    --paired-with <FILENAME>              Filename containing the paired reads (default: "")

    --pprof                               Enable pprof server. Look at the log for details. (default: false)

    --pprof-goroutine <int>               Enable profiling of goroutine blocking profile. (default: 6060, env: OBIPPROFGOROUTINE)

    --pprof-mutex <int>                   Enable profiling of mutex lock. (default: 10, env: OBIPPROFMUTEX)

    --skip-empty                          Sequences of length equal to zero are suppressed from the output (default: false)

    --solexa                              Decodes quality string according to the Solexa specification. (default: false, env: OBISOLEXA)

    --taxonomy|-t <string>                Path to the taxonomy database. (default: "")

    --update-taxid                        Make obitools automatically updating the taxid that are declared merged to a newest one. (default: false)

    --version                             Prints the version and exits. (default: false)
```

## Metadata
- **Skill**: generated

## obitools4_obiconvert

### Tool Description
Converts sequence files to different formats (part of OBITools4)

### Metadata
- **Docker Image**: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
- **Homepage**: https://obitools4.metabarcoding.org
- **Package**: https://anaconda.org/channels/bioconda/packages/obitools4/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3489095082: no space left on device
```

