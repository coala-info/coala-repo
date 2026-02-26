# compleasm CWL Generation Report

## compleasm_download

### Tool Description
Download BUSCO lineages.

### Metadata
- **Docker Image**: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
- **Homepage**: https://github.com/huangnengCSU/compleasm
- **Package**: https://anaconda.org/channels/bioconda/packages/compleasm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/compleasm/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-09-08
- **GitHub**: https://github.com/huangnengCSU/compleasm
- **Stars**: N/A
### Original Help Text
```text
usage: compleasm download [-h] [-L LIBRARY_PATH] [--odb ODB]
                          lineages [lineages ...]

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
  --odb ODB             OrthoDB version, default: odb12
```


## compleasm_list

### Tool Description
List BUSCO lineages

### Metadata
- **Docker Image**: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
- **Homepage**: https://github.com/huangnengCSU/compleasm
- **Package**: https://anaconda.org/channels/bioconda/packages/compleasm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compleasm list [-h] [--remote] [--local] [--odb ODB] [-L LIBRARY_PATH]

optional arguments:
  -h, --help            show this help message and exit
  --remote              List remote BUSCO lineages
  --local               List local BUSCO lineages
  --odb ODB             OrthoDB version, default: odb12
  -L LIBRARY_PATH, --library_path LIBRARY_PATH
                        Folder path to stored lineages.
```


## compleasm_protein

### Tool Description
Compleasm protein analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
- **Homepage**: https://github.com/huangnengCSU/compleasm
- **Package**: https://anaconda.org/channels/bioconda/packages/compleasm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compleasm protein [-h] -p PROTEINS -l LINEAGE -o OUTDIR [-t THREADS]
                         [-L LIBRARY_PATH] [--odb ODB]
                         [--hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH]

optional arguments:
  -h, --help            show this help message and exit
  -p PROTEINS, --proteins PROTEINS
                        Input protein file
  -l LINEAGE, --lineage LINEAGE
                        BUSCO lineage name
  -o OUTDIR, --outdir OUTDIR
                        Output analysis folder
  -t THREADS, --threads THREADS
                        Number of threads to use
  -L LIBRARY_PATH, --library_path LIBRARY_PATH
                        Folder path to stored lineages.
  --odb ODB             OrthoDB version, default: odb12
  --hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH
                        Path to hmmsearch executable
```


## compleasm_miniprot

### Tool Description
Miniprot alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
- **Homepage**: https://github.com/huangnengCSU/compleasm
- **Package**: https://anaconda.org/channels/bioconda/packages/compleasm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compleasm miniprot [-h] -a ASSEMBLY -p PROTEIN -o OUTDIR [-t THREADS]
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


## compleasm_analyze

### Tool Description
Analyze Miniprot output with BUSCO lineages.

### Metadata
- **Docker Image**: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
- **Homepage**: https://github.com/huangnengCSU/compleasm
- **Package**: https://anaconda.org/channels/bioconda/packages/compleasm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compleasm analyze [-h] -g GFF -l LINEAGE -o OUTPUT_DIR [-t THREADS]
                         [-L LIBRARY_PATH] [--odb ODB]
                         [--hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH]
                         [--specified_contigs SPECIFIED_CONTIGS [SPECIFIED_CONTIGS ...]]
                         [--retrocopy] [--min_diff MIN_DIFF]
                         [--min_identity MIN_IDENTITY]
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
  --odb ODB             OrthoDB version, default: odb12
  --hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH
                        Path to hmmsearch executable
  --specified_contigs SPECIFIED_CONTIGS [SPECIFIED_CONTIGS ...]
                        Specify the contigs to be evaluated, e.g. chr1 chr2
                        chr3. If not specified, all contigs will be evaluated.
  --retrocopy           Separate retrocopy genes from duplicated genes.
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


## compleasm_run

### Tool Description
Run the compleasm analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/compleasm:0.2.7--pyh7e72e81_1
- **Homepage**: https://github.com/huangnengCSU/compleasm
- **Package**: https://anaconda.org/channels/bioconda/packages/compleasm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: compleasm run [-h] -a ASSEMBLY_PATH -o OUTPUT_DIR [-t THREADS]
                     [-l LINEAGE] [-L LIBRARY_PATH] [--odb ODB]
                     [--specified_contigs SPECIFIED_CONTIGS [SPECIFIED_CONTIGS ...]]
                     [--outs OUTS]
                     [--miniprot_execute_path MINIPROT_EXECUTE_PATH]
                     [--hmmsearch_execute_path HMMSEARCH_EXECUTE_PATH]
                     [--autolineage] [--retrocopy]
                     [--sepp_execute_path SEPP_EXECUTE_PATH]
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
  --odb ODB             OrthoDB version, default: odb12
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
  --retrocopy           Separate retrocopy genes from duplicated genes.
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

