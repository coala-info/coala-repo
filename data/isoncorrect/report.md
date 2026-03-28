# isoncorrect CWL Generation Report

## isoncorrect_isONcorrect

### Tool Description
De novo error correction of long-read transcriptome reads

### Metadata
- **Docker Image**: quay.io/biocontainers/isoncorrect:0.1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/ksahlin/isONcorrect
- **Package**: https://anaconda.org/channels/bioconda/packages/isoncorrect/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isoncorrect/overview
- **Total Downloads**: 15.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ksahlin/isONcorrect
- **Stars**: N/A
### Original Help Text
```text
usage: isONcorrect [-h] [--version] [--fastq FASTQ] [--k K] [--w W]
                   [--xmin XMIN] [--xmax XMAX] [--T T] [--exact]
                   [--disable_numpy] [--max_seqs_to_spoa MAX_SEQS_TO_SPOA]
                   [--max_seqs MAX_SEQS] [--use_racon]
                   [--exact_instance_limit EXACT_INSTANCE_LIMIT]
                   [--set_w_dynamically] [--verbose] [--randstrobes]
                   [--layers LAYERS] [--set_layers_manually] [--compression]
                   [--outfolder OUTFOLDER]

De novo error correction of long-read transcriptome reads

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --fastq FASTQ         Path to input fastq file with reads (default: False)
  --k K                 Kmer size (default: 9)
  --w W                 Window size (default: 20)
  --xmin XMIN           Lower interval length (default: 18)
  --xmax XMAX           Upper interval length (default: 80)
  --T T                 Minimum fraction keeping substitution (default: 0.1)
  --exact               Get exact solution for WIS for evary read
                        (recalculating weights for each read (much slower but
                        slightly more accuracy, not to be used for clusters
                        with over ~500 reads) (default: False)
  --disable_numpy       Do not require numpy to be installed, but this version
                        is about 1.5x slower than with numpy. (default: False)
  --max_seqs_to_spoa MAX_SEQS_TO_SPOA
                        Maximum number of seqs to spoa (default: 200)
  --max_seqs MAX_SEQS   Maximum number of seqs to correct at a time (in case
                        of large clusters). (default: 2000)
  --use_racon           Use racon to polish consensus after spoa (more time
                        consuming but higher accuracy). (default: False)
  --exact_instance_limit EXACT_INSTANCE_LIMIT
                        Activates slower exact mode for instance smaller than
                        this limit (default: 0)
  --set_w_dynamically   Set w = k + max(2*k, floor(cluster_size/1000)).
                        (default: False)
  --verbose             Print various developer stats. (default: False)
  --randstrobes         EXPERIMENTAL PARAMETER: IsONcorrect uses paired
                        minimizers (described in isONcorrect paper). This
                        experimental option uses randstrobes instead of paired
                        minimizers to find shared regions. Randstrobes reduces
                        memory footprint substantially (and runtime) with only
                        slight increase in post correction quality. (default:
                        False)
  --layers LAYERS       EXPERIMENTAL PARAMETER: Active when --randstrobes
                        specified. How many "layers" with randstrobes we want
                        per sequence to sample. More layers gives more
                        accureate results but is more memory consuming and
                        slower. It is not reccomended to specify more than 5.
  --set_layers_manually
                        EXPERIMENTAL PARAMETER: By default isONcorrect sets
                        layers = 1 if nr seqs in batch to be corrected is >=
                        1000, else layers = 2. This command will manually pick
                        the number of layers specified with the --layers
                        parameter. (default: False)
  --compression         Use homopolymenr compressed reads. (Deprecated,
                        because we will have fewer minmimizer combinations to
                        span regions in homopolymenr dense regions. Solution
                        could be to adjust upper interval legnth dynamically
                        to guarantee a certain number of spanning intervals.
                        (default: False)
  --outfolder OUTFOLDER
                        A fasta file with transcripts that are shared between
                        samples and have perfect illumina support. (default:
                        None)
```


## isoncorrect_run_isoncorrect

### Tool Description
De novo clustering of long-read transcriptome reads

### Metadata
- **Docker Image**: quay.io/biocontainers/isoncorrect:0.1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/ksahlin/isONcorrect
- **Package**: https://anaconda.org/channels/bioconda/packages/isoncorrect/overview
- **Validation**: PASS

### Original Help Text
```text
usage: run_isoncorrect [-h] [--version] [--fastq_folder FASTQ_FOLDER]
                       [--t NR_CORES] [--k K] [--w W] [--xmin XMIN]
                       [--xmax XMAX] [--T T]
                       [--exact_instance_limit EXACT_INSTANCE_LIMIT]
                       [--keep_old] [--set_w_dynamically]
                       [--max_seqs MAX_SEQS] [--use_racon]
                       [--split_mod SPLIT_MOD] [--residual RESIDUAL]
                       [--split_wrt_batches] [--outfolder OUTFOLDER]
                       [--randstrobes] [--layers LAYERS]
                       [--set_layers_manually]

De novo clustering of long-read transcriptome reads

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --fastq_folder FASTQ_FOLDER
                        Path to input fastq folder with reads in clusters
                        (default: False)
  --t NR_CORES          Number of cores allocated for clustering (default: 8)
  --k K                 Kmer size (default: 9)
  --w W                 Window size (default: 20)
  --xmin XMIN           Lower interval length (default: 18)
  --xmax XMAX           Upper interval length (default: 80)
  --T T                 Minimum fraction keeping substitution (default: 0.1)
  --exact_instance_limit EXACT_INSTANCE_LIMIT
                        Do exact correction for clusters under this threshold
                        (default: 50)
  --keep_old            Do not recompute previous results if
                        corrected_reads.fq is found and has the smae number of
                        reads as input file (i.e., is complete). (default:
                        False)
  --set_w_dynamically   Set w = k + max(2*k, floor(cluster_size/1000)).
                        (default: False)
  --max_seqs MAX_SEQS   Maximum number of seqs to correct at a time (in case
                        of large clusters). (default: 2000)
  --use_racon           Use racon to polish consensus after spoa (more time
                        consuming but higher accuracy). (default: False)
  --split_mod SPLIT_MOD
                        Splits cluster ids in n (default=1) partitions by
                        computing residual of cluster_id divided by n. this
                        parameter needs to be combined with --residual to take
                        effect. (default: 1)
  --residual RESIDUAL   Run isONcorrect on cluster ids with residual (default
                        0) of cluster_id divided by --split_mod. (default: 0)
  --split_wrt_batches   Process reads per batch (of max_seqs sequences)
                        instead of per cluster. Significantly decrease runtime
                        when few very large clusters are less than the number
                        of cores used. (default: False)
  --outfolder OUTFOLDER
                        Outfolder with all corrected reads. (default: None)
  --randstrobes         EXPERIMENTAL PARAMETER: IsONcorrect uses paired
                        minimizers (described in isONcorrect paper). This
                        experimental option uses randstrobes instead of paired
                        minimizers to find shared regions. Randstrobes reduces
                        memory footprint substantially (and runtime) with only
                        slight increase in post correction quality. (default:
                        False)
  --layers LAYERS       EXPERIMENTAL PARAMETER: Active when --randstrobes
                        specified. How many "layers" with randstrobes we want
                        per sequence to sample. More layers gives more
                        accureate results but is more memory consuming and
                        slower. It is not reccomended to specify more than 5.
  --set_layers_manually
                        EXPERIMENTAL PARAMETER: By default isONcorrect sets
                        layers = 1 if nr seqs in batch to be corrected is >=
                        1000, else layers = 2. This command will manually pick
                        the number of layers specified with the --layers
                        parameter. (default: False)
```


## Metadata
- **Skill**: generated
