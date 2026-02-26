# lemur CWL Generation Report

## lemur

### Tool Description
Lemur example: lemur -i <input> -o <output_dir> -t <threads>

### Metadata
- **Docker Image**: quay.io/biocontainers/lemur:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/treangenlab/lemur
- **Package**: https://anaconda.org/channels/bioconda/packages/lemur/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lemur/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/treangenlab/lemur
- **Stars**: N/A
### Original Help Text
```text
usage: lemur [-h] [-v] -i INPUT [-o OUTPUT] [-d DB_PREFIX]
             [--tax-path TAX_PATH] [-t NUM_THREADS]
             [--aln-score {AS,edit,markov}] [--aln-score-gene] [-r RANK]
             [--min-aln-len-ratio MIN_ALN_LEN_RATIO]
             [--min-fidelity MIN_FIDELITY] [--ref-weight REF_WEIGHT]
             [--mm2-N MM2_N] [--mm2-K MM2_K]
             [--mm2-type {map-ont,map-hifi,map-pb,sr}] [--keep-alignments]
             [-e LOG_FILE] [--sam-input SAM_INPUT] [--verbose]
             [--save-intermediate-profile] [--width-filter] [--gid-name]

Lemur example: lemur -i <input> -o <output_dir> -t <threads>

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

Main Mob arguments:
  -i INPUT, --input INPUT
                        Input FASTQ file for the analysis
  -o OUTPUT, --output OUTPUT
                        Folder where the Mob output will be stored
  -d DB_PREFIX, --db-prefix DB_PREFIX
                        Path to the folder with individual Emu DBs for each
                        marker gene
  --tax-path TAX_PATH   Path to the taxonomy.tsv file (common for all DBs)
  -t NUM_THREADS, --num-threads NUM_THREADS
                        Number of threads you want to use
  --aln-score {AS,edit,markov}, --aln-score {AS,edit,markov}
                        AS: Use SAM AS tag for score, edit: Use edit-type
                        distribution for score, markov: Score CIGAR as markov
                        chain
  --aln-score-gene
  -r RANK, --rank RANK
  --min-aln-len-ratio MIN_ALN_LEN_RATIO
  --min-fidelity MIN_FIDELITY
  --ref-weight REF_WEIGHT

minimap2 arguments:
  --mm2-N MM2_N         minimap max number of secondary alignments per read
                        [50]
  --mm2-K MM2_K         minibatch size for minimap2 mapping [500M]
  --mm2-type {map-ont,map-hifi,map-pb,sr}
                        ONT: map-ont [map-ont], PacBio (hifi): map-hifi,
                        PacBio (CLR): map-pb, short-read: sr

Miscellaneous arguments:
  --keep-alignments     Keep SAM files after the mapping (might require a lot
                        of disk space)
  -e LOG_FILE, --log-file LOG_FILE
                        File for logging [default: stdout]
  --sam-input SAM_INPUT
  --verbose             Enable DEBUG level logging
  --save-intermediate-profile
                        Will save abundance profile at every EM step
  --width-filter        Apply width filter
  --gid-name
```

