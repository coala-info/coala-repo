# tides-ml CWL Generation Report

## tides-ml_tides

### Tool Description
TIdeS (Transcript Isoform Discovery and Expression Simulator)

### Metadata
- **Docker Image**: quay.io/biocontainers/tides-ml:1.3.5--pyhdfd78af_0
- **Homepage**: https://github.com/xxmalcala/TIdeS
- **Package**: https://anaconda.org/channels/bioconda/packages/tides-ml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tides-ml/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/xxmalcala/TIdeS
- **Stars**: N/A
### Original Help Text
```text
_____ ___    _     ___
     |_   _|_ _|__| |___/ __|
       | |  | |/ _` / -_)__ \
       |_| |___\__,_\___|___/

     Version 1.3.5
    
Usage:
    tides.py [options] --fin [FASTA file] --taxon [taxon name]

General Options:
  --fin (-i)            input file in FASTA format
  --taxon (-o)          taxon or output name
  --threads (-t)        number of CPU threads (default = 1)
  --train-only          run TIdeS through training (no predictions)
  --no-filter           skip the rRNA and transcript clustering steps
  --model (-m)          previously trained TIdeS model (".pkl" file)
  --kmer                kmer size for generating sequence features (default = 3)
  --overlap             permit overlapping kmers (see --kmer)
  --step                step-size for overlapping kmers
                        (default is kmer-length/2)
  --clean               remove intermediate filter-step files
  --quiet (-q)          no console output
  --gzip (-gz)          tar and gzip TIdeS output
  --help (-h)           show this help message and exit

ORF-Calling Options:
  --db (-d)             protein database (FASTA or DIAMOND format)
  --partial (-p)        evaluate partial ORFs as well
  --id (-id)            minimum % identity to remove redundant transcripts
                        (default = 97)
  --memory              memory limit (MB) for CD-HIT (default = 2000, unlimited = 0)
  --min-orf (-l)        minimum ORF length (bp) to evaluate (default = 300)
  --max-orf (-ml)       maximum ORF length (bp) to evaluate (default = 10000)
  --evalue (-e)         maximum e-value to infer reference ORFs
                        (default = 1e-10)
  --gencode (-g)        genetic code to use to translate ORFs
  --strand (-s)         query strands to call ORFs
                        (both/minus/plus, default = both)

Contamination-Calling Options:
  --contam (-c)         table of annotated sequences
  --kraken (-k)         kraken2 database to identify and filter
                        non-eukaryotic sequences
```

