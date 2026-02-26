# xpore CWL Generation Report

## xpore_dataprep

### Tool Description
Prepares data for xpore analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/GoekeLab/xpore
- **Package**: https://anaconda.org/channels/bioconda/packages/xpore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xpore/overview
- **Total Downloads**: 9.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GoekeLab/xpore
- **Stars**: N/A
### Original Help Text
```text
usage: xpore dataprep [-h] --eventalign EVENTALIGN --out_dir OUT_DIR
                      [--gtf_or_gff GTF_OR_GFF]
                      [--transcript_fasta TRANSCRIPT_FASTA]
                      [--skip_eventalign_indexing] [--genome]
                      [--n_processes N_PROCESSES] [--chunk_size CHUNK_SIZE]
                      [--readcount_min READCOUNT_MIN]
                      [--readcount_max READCOUNT_MAX] [--resume]

required arguments:
  --eventalign EVENTALIGN
                        eventalign filepath, the output from nanopolish.
  --out_dir OUT_DIR     output directory.

optional arguments:
  -h, --help            show this help message and exit
  --gtf_or_gff GTF_OR_GFF
                        GTF or GFF file path.
  --transcript_fasta TRANSCRIPT_FASTA
                        transcript FASTA path.
  --skip_eventalign_indexing
                        skip indexing the eventalign nanopolish output.
  --genome              to run on Genomic coordinates. Without this argument,
                        the program will run on transcriptomic coordinates
  --n_processes N_PROCESSES
                        number of processes to run.
  --chunk_size CHUNK_SIZE
                        number of lines from nanopolish eventalign.txt for
                        processing.
  --readcount_min READCOUNT_MIN
                        minimum read counts per gene.
  --readcount_max READCOUNT_MAX
                        maximum read counts per gene.
  --resume              with this argument, the program will resume from the
                        previous run.
```


## xpore_diffmod

### Tool Description
Performs differential modification analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/GoekeLab/xpore
- **Package**: https://anaconda.org/channels/bioconda/packages/xpore/overview
- **Validation**: PASS

### Original Help Text
```text
usage: xpore diffmod [-h] --config CONFIG [--n_processes N_PROCESSES]
                     [--save_models] [--resume] [--ids [IDS ...]]

required arguments:
  --config CONFIG       YAML configuraion filepath.

optional arguments:
  -h, --help            show this help message and exit
  --n_processes N_PROCESSES
                        number of processes to run.
  --save_models         with this argument, the program will save the model
                        parameters for each id.
  --resume              with this argument, the program will resume from the
                        previous run.
  --ids [IDS ...]       gene or transcript ids to model.
```


## xpore_postprocessing

### Tool Description
Performs postprocessing steps for xpore-diffmod output.

### Metadata
- **Docker Image**: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
- **Homepage**: https://github.com/GoekeLab/xpore
- **Package**: https://anaconda.org/channels/bioconda/packages/xpore/overview
- **Validation**: PASS

### Original Help Text
```text
usage: xpore postprocessing [-h] --diffmod_dir DIFFMOD_DIR

optional arguments:
  -h, --help            show this help message and exit

required arguments:
  --diffmod_dir DIFFMOD_DIR
                        diffmod directory path, the output from xpore-diffmod.
```

