# virsorter CWL Generation Report

## virsorter_config

### Tool Description
CLI for managing configurations.

### Metadata
- **Docker Image**: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/simroux/VirSorter
- **Package**: https://anaconda.org/channels/bioconda/packages/virsorter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virsorter/overview
- **Total Downloads**: 46.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/simroux/VirSorter
- **Stars**: N/A
### Original Help Text
```text
Usage: virsorter config [OPTIONS]

  CLI for managing configurations.

  There are many configurations kept in "template-config.yaml" in source  code
  directory or "~/.virsorter" (when source code directory is not  writable for
  user). This file can located with  `virsorter config --show-source`. You can
  set the configurations with  `virsorter config --set KEY=VAL`. Alternative,
  you can edit in the  configuration file ("template-config.yaml") directly.

Options:
  --show         show all configuration values
  --show-source  show path of the configuration file
  --init-source  initialize configuration file
  --db-dir PATH  directory for databases; required for --init-source
  --set TEXT     set KEY to VAL with the format: KEY=VAL; for nested dict in
                 YAML use KEY1.KEY2=VAL (e.g. virsorter config --set
                 GROUP_INFO.RNA.MIN_GENOME_SIZE=2000)
  --get TEXT     the value of a KEY (e.g. virsorter config --get
                 GROUP_INFO.RNA.MIN_GENOME_SIZE
  -h, --help     Show this message and exit.
```


## virsorter_run

### Tool Description
Runs the virsorter main function to classify viral sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/simroux/VirSorter
- **Package**: https://anaconda.org/channels/bioconda/packages/virsorter/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virsorter run [OPTIONS] [[all|classify]] [SNAKEMAKE_ARGS]...

  Runs the virsorter main function to classify viral sequences

  This includes 3 steps: 1) preprocess, 2) feature extraction, and 3)
  classify. By default ("all") all steps are executed. The "classify" only run
  the 3) classify step without previous steps that are computationally heavy,
  good for rerunning with different filtering options (--min-score, --high-
  confidence-only, --hallmark-required, --hallmark-required-on-short, --viral-
  gene-required, --exclude-lt2gene). Most snakemake arguments can be appended
  to the command for more  info see 'snakemake --help'.

Options:
  -w, --working-dir PATH        output directory
  -d, --db-dir PATH             database directory, default to the --db-dir
                                set during installation
  -i, --seqfile PATH            sequence file in fa or fq format (could be
                                compressed by gzip or bz2)  [required]
  -l, --label TEXT              add label as prefix to output files; this is
                                useful when re-running classify with different
                                filtering options
  --include-groups TEXT         classifiers of viral groups to included (comma
                                separated and no space in between); available
                                options are:
                                dsDNAphage,NCLDV,RNA,ssDNA,lavidaviridae
                                [default: dsDNAphage,ssDNA]
  -j, --jobs INTEGER            max # of jobs allowed in parallel.  [default:
                                20]
  --min-score FLOAT             minimal score to be identified as viral
                                [default: 0.5]
  --min-length INTEGER          minimal seq length required; all seqs shorter
                                than this will be removed  [default: 0]
  --keep-original-seq           keep the original sequences instead of
                                trimmed; By default, the untranslated regions
                                at both ends of identified viral seqs are
                                trimmed; circular sequences are modified to
                                remove overlap between both ends and adjusted
                                for the gene splitted into two ends;
  --exclude-lt2gene             short seqs (less than 2 genes) does not have
                                any scores, but those with hallmark genes are
                                included as viral by default; use this option
                                to exclude them
  --prep-for-dramv              turn on generating viral seqfile and viral-
                                affi-contigs.tab for DRAMv
  --high-confidence-only        only output high confidence viral sequences;
                                this is equivalent to screening final-viral-
                                score.tsv with the following criteria:
                                (max_score >= 0.9) OR (max_score >=0.7 AND
                                hallmark >= 1)
  --hallmark-required           require hallmark gene on all viral seqs
  --hallmark-required-on-short  require hallmark gene on short viral seqs
                                (length cutoff as "short" were set by
                                "MIN_SIZE_ALLOWED_WO_HALLMARK_GENE" in
                                template-config.yaml file, default 3kbp); this
                                can reduce false positives at reasonable cost
                                of sensitivity
  --viral-gene-required         require viral genes annotated, removing
                                putative viral seqs with no genes annotated;
                                this can reduce false positives at reasonable
                                cost of sensitivity
  --viral-gene-enrich-off       turn off the requirement of more viral than
                                cellular genes for calling full sequence
                                viral; this is useful when only using
                                VirSorter2 to produce DRAMv input with viral
                                sequence identified from other tools, or those
                                trimmed by checkV
  --seqname-suffix-off          turn off adding suffix (||full, ||{i}_partial,
                                ||lt2gene) to sequence names; note that this
                                might cause partial seqs from the same contig
                                to have the same name; this option is could be
                                used when you are sure there is one partial
                                sequence at max from each contig
  --provirus-off                turn off extracting provirus after classifying
                                full contigs; Togetehr with lower --max-orf-
                                per-seq, can speed up a run significantly
  --max-orf-per-seq INTEGER     max # of orf used for computing taxonomic
                                feature; this option can only be used in
                                --provirus-off mode; if # of orf in a seq
                                exceeds the max limit, it is sub-sampled to
                                this # to reduce computation  [default: -1]
  --tmpdir TEXT                 directory name for intermediate files
  --rm-tmpdir                   remove intermediate file directory (--tmpdir);
                                More than 100 intermediate files are created
                                for each run, so this is recommended when 100s
                                of samples are processed to avoid exceeding
                                file # quota for user
  --verbose                     shows detailed rules output
  --profile TEXT                snakemake profile e.g. for cluster execution.
  -n, --dryrun                  Check rules to run and files to produce
  --use-conda-off               Stop using the conda envs (vs2.yaml) that come
                                with this package and use what are installed
                                in current system; Only useful when you want
                                to install dependencies on your own with your
                                own prefer version; this option works with the
                                development version
  -h, --help                    Show this message and exit.
```


## virsorter_setup

### Tool Description
Setup databases and install dependencies.

Executes a snakemake workflow to download reference database files and
validate based on their MD5 checksum, and install dependencies

### Metadata
- **Docker Image**: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/simroux/VirSorter
- **Package**: https://anaconda.org/channels/bioconda/packages/virsorter/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virsorter setup [OPTIONS] [SNAKEMAKE_ARGS]...

  Setup databases and install dependencies.

  Executes a snakemake workflow to download reference database files and
  validate based on their MD5 checksum, and install dependencies

Options:
  -d, --db-dir PATH        diretory path for databases  [required]
  -j, --jobs INTEGER       number of simultaneous downloads  [default: 20]
  -s, --skip-deps-install  skip dependency installation (if you want to
                           install on your own as in development version)
  -h, --help               Show this message and exit.
```


## virsorter_train-feature

### Tool Description
Training features for customized classifier.

Executes a snakemake workflow to do the following: 1) prepare random DNA
fragments from viral and nonviral genome data  2) extract feature from
random DNA fragments to make ftrfile

### Metadata
- **Docker Image**: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/simroux/VirSorter
- **Package**: https://anaconda.org/channels/bioconda/packages/virsorter/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virsorter train-feature [OPTIONS] [SNAKEMAKE_ARGS]...

  Training features for customized classifier.

  Executes a snakemake workflow to do the following: 1) prepare random DNA
  fragments from viral and nonviral genome data  2) extract feature from
  random DNA fragments to make ftrfile

Options:
  -w, --working-dir PATH      output directory  [required]
  --seqfile TEXT              genome sequence file for training; for file
                              pattern globbing, put quotes around the pattern,
                              eg. "fasta-dir/*.fa"  [required]
  --hmm PATH                  customized viral HMMs for training; default to
                              the one used in VirSorter2
  --hallmark PATH             hallmark gene hmm list from -hmm for training (a
                              tab separated file with three columns: 1. hmm
                              name, 2. gene name of hmm, 3. hmm bit score
                              cutoff); default to the one used for dsDNAphage
                              in VirSorter2
  --prodigal-train PATH       customized training db from prodigal; default to
                              the one used in prodigal --meta mode
  --frags-per-genome INTEGER  number of random DNA fragments collected from
                              each genome  [default: 5]
  -j, --jobs INTEGER          max # of jobs in parallel  [default: 20]
  --min-length INTEGER        minimum size of random DNA fragment for training
                              [default: 1000]
  --max-orf-per-seq INTEGER   Max # of orf used for computing taxonomic
                              features; if # of orf in a seq exceeds the max
                              limit, it is sub-sampled to this # to reduce
                              computation; to turn off this, set it to -1
                              [default: 20]
  --genome-as-bin             if applied, each file (genome bin) is a genome
                              in --seqfile, else each sequence is a genome
  --use-conda-off             Stop using the conda envs (vs2.yaml) that come
                              with this package and use what are installed in
                              current system; Only useful when you want to
                              install dependencies on your own with your own
                              preferred versions
  -h, --help                  Show this message and exit.
```


## virsorter_train-model

### Tool Description
Training customized classifier model.

### Metadata
- **Docker Image**: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
- **Homepage**: https://github.com/simroux/VirSorter
- **Package**: https://anaconda.org/channels/bioconda/packages/virsorter/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: virsorter train-model [OPTIONS] [SNAKEMAKE_ARGS]...

  Training customized classifier model.

Options:
  -w, --working-dir PATH   output directory  [required]
  --viral-ftrfile PATH     viral genome feature file for training  [required]
  --nonviral-ftrfile PATH  nonviral genome feature file for training
                           [required]
  -j, --jobs INTEGER       number of threads for classier  [default: 20]
  --balanced               random undersample the larger to the size of the
                           smaller feature file
  --use-conda-off          Stop using the conda envs (vs2.yaml) that come with
                           this package and use what are installed in current
                           system; Only useful when you want to install
                           dependencies on your own with your own prefer
                           versions
  -h, --help               Show this message and exit.
```


## Metadata
- **Skill**: generated
