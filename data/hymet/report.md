# hymet CWL Generation Report

## hymet_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Total Downloads**: 230
- **Last updated**: 2026-02-14
- **GitHub**: https://github.com/inesbmartins02/HYMET
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: hymet version [-h]

options:
  -h, --help  show this help message and exit
```


## hymet_init

### Tool Description
Initialize hymet project

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hymet init [-h] [--quiet] [--skip-taxonomy]

options:
  -h, --help       show this help message and exit
  --quiet, -q      Don't exit with error on missing files
  --skip-taxonomy  Skip automatic NCBI taxonomy download
```


## hymet_run

### Tool Description
Run HYMET with specified inputs and options.

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hymet run [-h] (--contigs CONTIGS | --reads READS) --out OUT
                 [--cand-max CAND_MAX] [--species-dedup]
                 [--assembly-summary-dir ASSEMBLY_SUMMARY_DIR]
                 [--threads THREADS] [--cache-root CACHE_ROOT]
                 [--force-download] [--keep-work] [--dry-run]

options:
  -h, --help            show this help message and exit
  --contigs CONTIGS     Input contigs FASTA
  --reads READS         Input reads FASTQ/FASTA
  --out OUT             Output directory
  --cand-max CAND_MAX   Maximum Mash candidates (CAND_MAX)
  --species-dedup       Enable species-level candidate deduplication
  --assembly-summary-dir ASSEMBLY_SUMMARY_DIR
                        Directory holding assembly_summary files
  --threads THREADS     Thread count to pass to HYMET
  --cache-root CACHE_ROOT
                        Override cache root (CACHE_ROOT)
  --force-download      Set FORCE_DOWNLOAD=1 for HYMET runs
  --keep-work           Set KEEP_HYMET_WORK=1 to retain intermediates
  --dry-run             Show commands without executing them
```


## hymet_bench

### Tool Description
Run the HYMET benchmark pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hymet bench [-h] [--manifest MANIFEST] [--tools TOOLS]
                   [--max-samples MAX_SAMPLES] [--no-build] [--resume]
                   [--no-publish] [--threads THREADS]
                   [--cache-root CACHE_ROOT] [--force-download] [--keep-work]
                   [--dry-run]
                   ...

positional arguments:
  extra                 Extra args forwarded to run_all_cami.sh

options:
  -h, --help            show this help message and exit
  --manifest MANIFEST   Manifest TSV (default bench/cami_manifest.tsv)
  --tools TOOLS         Comma-separated tool list
  --max-samples MAX_SAMPLES
                        Limit number of samples processed
  --no-build            Skip database build step
  --resume              Resume without clearing runtime log
  --no-publish          Skip publishing under results/
  --threads THREADS     Thread count to pass to HYMET
  --cache-root CACHE_ROOT
                        Override cache root (CACHE_ROOT)
  --force-download      Set FORCE_DOWNLOAD=1 for HYMET runs
  --keep-work           Set KEEP_HYMET_WORK=1 to retain intermediates
  --dry-run             Show commands without executing them
```


## hymet_case

### Tool Description
Run a case study with HYMET.

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hymet case [-h] [--manifest MANIFEST] [--out OUT] [--threads THREADS]
                  [--cache-root CACHE_ROOT] [--force-download] [--keep-work]
                  [--dry-run]
                  ...

positional arguments:
  extra                 Extra args forwarded to run_case.sh

options:
  -h, --help            show this help message and exit
  --manifest MANIFEST   Manifest TSV (default case/manifest.tsv)
  --out OUT             Output root directory
  --threads THREADS     Thread count to pass to HYMET
  --cache-root CACHE_ROOT
                        Override cache root (CACHE_ROOT)
  --force-download      Set FORCE_DOWNLOAD=1 for HYMET runs
  --keep-work           Set KEEP_HYMET_WORK=1 to retain intermediates
  --dry-run             Show commands without executing them
```


## hymet_ablation

### Tool Description
Ablate samples using HYMET

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hymet ablation [-h] [--sample SAMPLE] [--taxa TAXA] [--levels LEVELS]
                      [--seqmap SEQMAP] [--fasta FASTA] [--out OUT]
                      [--threads THREADS] [--cache-root CACHE_ROOT]
                      [--force-download] [--keep-work] [--dry-run]
                      ...

positional arguments:
  extra                 Extra args forwarded to run_ablation.sh

options:
  -h, --help            show this help message and exit
  --sample SAMPLE       Sample ID to ablate
  --taxa TAXA           Comma-separated TaxIDs to remove at each level
  --levels LEVELS       Comma-separated ablation fractions (e.g. 0,0.5,1.0)
  --seqmap SEQMAP       Sequence-to-taxid map
  --fasta FASTA         Reference FASTA to ablate
  --out OUT             Output directory for ablation results
  --threads THREADS     Thread count to pass to HYMET
  --cache-root CACHE_ROOT
                        Override cache root (CACHE_ROOT)
  --force-download      Set FORCE_DOWNLOAD=1 for HYMET runs
  --keep-work           Set KEEP_HYMET_WORK=1 to retain intermediates
  --dry-run             Show commands without executing them
```


## hymet_truth

### Tool Description
Build Zymo mock community truth tables

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hymet truth [-h] {build-zymo} ...

positional arguments:
  {build-zymo}
    build-zymo  Build Zymo mock community truth tables

options:
  -h, --help    show this help message and exit
```


## hymet_legacy

### Tool Description
HYMET now ships with a unified CLI (bin/hymet). For batch runs try:
       bin/hymet run --contigs /path/to/sample.fna --out /path/to/out --threads 8
       bin/hymet bench --manifest bench/cami_manifest.tsv

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
[FYI] HYMET now ships with a unified CLI (bin/hymet). For batch runs try:
       bin/hymet run --contigs /path/to/sample.fna --out /path/to/out --threads 8
       bin/hymet bench --manifest bench/cami_manifest.tsv

Please enter the path to the input directory (containing .fna files): [hymet] (/usr/local/share/hymet) $ perl /usr/local/share/hymet/main.pl
```


## hymet_artifacts

### Tool Description
Show commands without executing them

### Metadata
- **Docker Image**: quay.io/biocontainers/hymet:1.3.0--hdfd78af_0
- **Homepage**: https://github.com/inesbmartins02/HYMET
- **Package**: https://anaconda.org/channels/bioconda/packages/hymet/overview
- **Validation**: PASS

### Original Help Text
```text
usage: hymet artifacts [-h] [--dry-run]

options:
  -h, --help  show this help message and exit
  --dry-run   Show commands without executing them
```

