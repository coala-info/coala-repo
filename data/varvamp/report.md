# varvamp CWL Generation Report

## varvamp_single

### Tool Description
Performs primer design and amplicon prediction for a single input alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/varvamp:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/jonas-fuchs/varVAMP
- **Package**: https://anaconda.org/channels/bioconda/packages/varvamp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/varvamp/overview
- **Total Downloads**: 20.2K
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/jonas-fuchs/varVAMP
- **Stars**: N/A
### Original Help Text
```text
usage: varvamp single [optional arguments] <alignment> <output dir>

options:
  -h, --help            show this help message and exit
  -a, --n-ambig 2       max number of ambiguous characters in a primer
  -db, --database None  location of the BLAST db
  -th, --threads 1      number of threads
  --name varVAMP        name of the scheme
  --compatible-primers None
                        FASTA primer file with which new primers should not
                        form dimers. Sequences >40 nt are ignored. Can
                        significantly increase runtime.
  -t, --threshold       consensus threshold (0-1) - if not set it will be
                        estimated (higher values result in higher specificity
                        at the expense of found primers)
  -ol, --opt-length 1000
                        optimal length of the amplicons
  -ml, --max-length 1500
                        max length of the amplicons
  -n, --report-n inf    report the top n best hits
```


## varvamp_tiled

### Tool Description
Performs primer design and amplicon tiling for variant calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/varvamp:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/jonas-fuchs/varVAMP
- **Package**: https://anaconda.org/channels/bioconda/packages/varvamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varvamp tiled [optional arguments] <alignment> <output dir>

options:
  -h, --help            show this help message and exit
  -a, --n-ambig 2       max number of ambiguous characters in a primer
  -db, --database None  location of the BLAST db
  -th, --threads 1      number of threads
  --name varVAMP        name of the scheme
  --compatible-primers None
                        FASTA primer file with which new primers should not
                        form dimers. Sequences >40 nt are ignored. Can
                        significantly increase runtime.
  -t, --threshold       consensus threshold (0-1) - if not set it will be
                        estimated (higher values result in higher specificity
                        at the expense of found primers)
  -ol, --opt-length 1000
                        optimal length of the amplicons
  -ml, --max-length 1500
                        max length of the amplicons
  -o, --overlap 25      min overlap of the amplicon inserts
```


## varvamp_qpcr

### Tool Description
Performs qPCR primer and probe design.

### Metadata
- **Docker Image**: quay.io/biocontainers/varvamp:1.3--pyhdfd78af_0
- **Homepage**: https://github.com/jonas-fuchs/varVAMP
- **Package**: https://anaconda.org/channels/bioconda/packages/varvamp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: varvamp qpcr -t <threshold> [optional arguments] <alignment> <output dir>

options:
  -h, --help            show this help message and exit
  -a, --n-ambig 2       max number of ambiguous characters in a primer
  -db, --database None  location of the BLAST db
  -th, --threads 1      number of threads
  --name varVAMP        name of the scheme
  --compatible-primers None
                        FASTA primer file with which new primers should not
                        form dimers. Sequences >40 nt are ignored. Can
                        significantly increase runtime.
  -pa, --pn-ambig 1     max number of ambiguous characters in a probe
  -t, --threshold THRESHOLD
                        consensus threshold (0-1) - higher values result in
                        higher specificity at the expense of found primers
  -n, --test-n 50       test the top n qPCR amplicons for secondary structures
                        at the minimal primer temperature
  -d, --deltaG -3       minimum free energy (kcal/mol/K) cutoff at the lowest
                        primer melting temperature
```


## Metadata
- **Skill**: generated
