# minibusco CWL Generation Report

## minibusco_download

### Tool Description
Download BUSCO lineage datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
- **Homepage**: https://github.com/huangnengCSU/minibusco
- **Package**: https://anaconda.org/channels/bioconda/packages/minibusco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minibusco/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/huangnengCSU/minibusco
- **Stars**: N/A
### Original Help Text
```text
usage: minibusco download [-h] [-L LIBRARY_PATH] lineages [lineages ...]

positional arguments:
  lineages              Specify the names of the BUSCO lineages to be
                        downloaded. (e.g. eukaryota, primates, saccharomycetes
                        etc.)

optional arguments:
  -h, --help            show this help message and exit
  -L LIBRARY_PATH, --library_path LIBRARY_PATH
                        The destination folder to store the downloaded lineage
                        files.If not specified, a folder named "mb_downloads"
                        will be created on the current running path.
```


## minibusco_list

### Tool Description
List BUSCO lineages

### Metadata
- **Docker Image**: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
- **Homepage**: https://github.com/huangnengCSU/minibusco
- **Package**: https://anaconda.org/channels/bioconda/packages/minibusco/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minibusco list [-h] [--remote] [--local] [-L LIBRARY_PATH]

optional arguments:
  -h, --help            show this help message and exit
  --remote              List remote BUSCO lineages
  --local               List local BUSCO lineages
  -L LIBRARY_PATH, --library_path LIBRARY_PATH
                        Folder path to stored lineages.
```


## minibusco_miniprot

### Tool Description
Miniprot alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
- **Homepage**: https://github.com/huangnengCSU/minibusco
- **Package**: https://anaconda.org/channels/bioconda/packages/minibusco/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minibusco miniprot [-h] -a ASSEMBLY -p PROTEIN -o OUTDIR [-t THREADS]
                          [--outs OUTS]
                          [--miniprot_execute_path MINIPROT_EXECUTE_PATH]

optional arguments:
  -h, --help            show this help message and exit
  -a ASSEMBLY, --assembly ASSEMBLY
                        Input genome file in FASTA format
  -p PROTEIN, --protein PROTEIN
                        Input protein file
  -o OUTDIR, --outdir OUTDIR
                        Miniprot alignment output directory
  -t THREADS, --threads THREADS
                        Number of threads to use
  --outs OUTS           output if score at least FLOAT*bestScore [0.95]
  --miniprot_execute_path MINIPROT_EXECUTE_PATH
                        Path to miniprot executable
```


## minibusco_analyze

### Tool Description
Miniprot output gff file

### Metadata
- **Docker Image**: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
- **Homepage**: https://github.com/huangnengCSU/minibusco
- **Package**: https://anaconda.org/channels/bioconda/packages/minibusco/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minibusco analyze [-h] -g GFF -l LINEAGE -o OUTPUT_DIR [-t THREADS]
                         [-L LIBRARY_PATH] [-m {lite,busco}]
                         [--hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH]
                         [--specified_contigs SPECIFIED_CONTIGS [SPECIFIED_CONTIGS ...]]
                         [--min_diff MIN_DIFF] [--min_identity MIN_IDENTITY]
                         [--min_length_percent MIN_LENGTH_PERCENT]
                         [--min_complete MIN_COMPLETE] [--min_rise MIN_RISE]

optional arguments:
  -h, --help            show this help message and exit
  -g GFF, --gff GFF     Miniprot output gff file
  -l LINEAGE, --lineage LINEAGE
                        BUSCO lineage name
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output analysis folder
  -t THREADS, --threads THREADS
                        Number of threads to use
  -L LIBRARY_PATH, --library_path LIBRARY_PATH
                        Folder path to stored lineages.
  -m {lite,busco}, --mode {lite,busco}
                        The mode of evaluation. dafault mode: busco. lite:
                        Without using hmmsearch to filtering protein
                        alignment. busco: Using hmmsearch on all candidate
                        protein alignment to purify the miniprot alignment to
                        imporve accuracy.
  --hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH
                        Path to hmmsearch executable
  --specified_contigs SPECIFIED_CONTIGS [SPECIFIED_CONTIGS ...]
                        Specify the contigs to be evaluated, e.g. chr1 chr2
                        chr3. If not specified, all contigs will be evaluated.
  --min_diff MIN_DIFF   The thresholds for the best matching and second best
                        matching.
  --min_identity MIN_IDENTITY
                        The identity threshold for valid mapping results. [0,
                        1]
  --min_length_percent MIN_LENGTH_PERCENT
                        The fraction of protein for valid mapping results.
  --min_complete MIN_COMPLETE
                        The length threshold for complete gene.
  --min_rise MIN_RISE   Minimum length threshold to make dupicate take
                        precedence over single or fragmented over
                        single/duplicate.
```


## minibusco_run

### Tool Description
Run BUSCO analysis with Minibosco

### Metadata
- **Docker Image**: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
- **Homepage**: https://github.com/huangnengCSU/minibusco
- **Package**: https://anaconda.org/channels/bioconda/packages/minibusco/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minibusco run [-h] -a ASSEMBLY_PATH -o OUTPUT_DIR [-t THREADS]
                     [-l LINEAGE] [-L LIBRARY_PATH] [-m {lite,busco}]
                     [--specified_contigs SPECIFIED_CONTIGS [SPECIFIED_CONTIGS ...]]
                     [--outs OUTS]
                     [--miniprot_execute_path MINIPROT_EXECUTE_PATH]
                     [--hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH]
                     [--autolineage] [--sepp_execute_path SEPP_EXECUTE_PATH]
                     [--min_diff MIN_DIFF] [--min_identity MIN_IDENTITY]
                     [--min_length_percent MIN_LENGTH_PERCENT]
                     [--min_complete MIN_COMPLETE] [--min_rise MIN_RISE]

optional arguments:
  -h, --help            show this help message and exit
  -a ASSEMBLY_PATH, --assembly_path ASSEMBLY_PATH
                        Input genome file in FASTA format.
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        The output folder.
  -t THREADS, --threads THREADS
                        Number of threads to use
  -l LINEAGE, --lineage LINEAGE
                        Specify the name of the BUSCO lineage to be used.
                        (e.g. eukaryota, primates, saccharomycetes etc.)
  -L LIBRARY_PATH, --library_path LIBRARY_PATH
                        Folder path to download lineages or already downloaded
                        lineages. If not specified, a folder named
                        "mb_downloads" will be created on the current running
                        path by default to store the downloaded lineage files.
  -m {lite,busco}, --mode {lite,busco}
                        The mode of evaluation. dafault mode: busco. lite:
                        Without using hmmsearch to filtering protein
                        alignment. busco: Using hmmsearch on all candidate
                        protein alignment to purify the miniprot alignment to
                        imporve accuracy.
  --specified_contigs SPECIFIED_CONTIGS [SPECIFIED_CONTIGS ...]
                        Specify the contigs to be evaluated, e.g. chr1 chr2
                        chr3. If not specified, all contigs will be evaluated.
  --outs OUTS           output if score at least FLOAT*bestScore [0.99]
  --miniprot_execute_path MINIPROT_EXECUTE_PATH
                        Path to miniprot executable
  --hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH
                        Path to hmmsearch executable
  --autolineage         Automatically search for the best matching lineage
                        without specifying lineage file.
  --sepp_execute_path SEPP_EXECUTE_PATH
                        Path to run_sepp.py executable
  --min_diff MIN_DIFF   The thresholds for the best matching and second best
                        matching.
  --min_identity MIN_IDENTITY
                        The identity threshold for valid mapping results.
  --min_length_percent MIN_LENGTH_PERCENT
                        The fraction of protein for valid mapping results.
  --min_complete MIN_COMPLETE
                        The length threshold for complete gene.
  --min_rise MIN_RISE   Minimum length threshold to make dupicate take
                        precedence over single or fragmented over
                        single/duplicate.
```


## Metadata
- **Skill**: generated
