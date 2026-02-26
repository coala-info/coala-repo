# mgatk CWL Generation Report

## mgatk_bcall

### Tool Description
mgatk: a mitochondrial genome analysis toolkit. bcall mode is used for mitochondrial genome analysis from single-cell data (e.g., with barcodes).

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/caleblareau/mgatk
- **Stars**: N/A
### Original Help Text
```text
Usage: mgatk [OPTIONS] {bcall|call|tenx|check|support|remove-background}

  mgatk: a mitochondrial genome analysis toolkit.

  MODE = ['bcall', 'call', 'tenx', 'check', 'support', 'remove-background']

  See https://github.com/caleblareau/mgatk/wiki for more details.

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; either directory of singular .bam
                                  file; see documentation. REQUIRED.
                                  [required]
  -o, --output TEXT               Output directory for analysis required for
                                  `call` and `bcall`. Default = mgatk_out
  -n, --name TEXT                 Prefix for project name. Default = mgatk
  -g, --mito-genome TEXT          mitochondrial genome configuration. Choose
                                  hg19, hg38, mm10, (etc.) or a custom .fasta
                                  file; see documentation. Default = rCRS.
                                  [required]
  -c, --ncores TEXT               Number of cores to run the main job in
                                  parallel.
  --cluster TEXT                  Message to send to Snakemake to execute jobs
                                  on cluster interface; see documentation.
  --jobs TEXT                     Max number of jobs to be running
                                  concurrently on the cluster interface.
  -bt, --barcode-tag TEXT         Read tag (generally two letters) to separate
                                  single cells; valid and required only in
                                  `bcall` mode.
  -b, --barcodes TEXT             File path to barcodes that will be
                                  extracted; useful only in `bcall` mode. If
                                  none supplied, mgatk will learn abundant
                                  barcodes from the bam file (threshold
                                  defined by the -mb tag).
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic. Default = 1000.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 1.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 4.
  -kd, --keep-duplicates          Retained dupliate (presumably PCR) reads
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -ho, --handle-overlap           Only count each base in the overlap region
                                  between a pair of reads once
  -lc, --low-coverage-threshold INTEGER
                                  Variant count for each cell will be ignored
                                  below this when calculating VMR
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal per core. Default = 8000m.
  -pp, --proper-pairs             Require reads to be properly paired.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -eb, --emit-base-qualities      Output mean base quality per alt allele as
                                  part of the final output.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; Default = 7000.
                                  Supply 0 to try all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Add this flag to keep all intermediate
                                  files.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file. May be necessary for certain HPC
                                  environments.
  -nfg, --ncells_fg INTEGER       number of "foreground" cells to use for
                                  CellBender. Default = 1000.
  -nbg, --ncells_bg INTEGER       number of "background" cells to use for
                                  CellBender. Default = 20000.
  --help                          Show this message and exit.
```


## mgatk_call

### Tool Description
mgatk: a mitochondrial genome analysis toolkit. Mitochondrial genome analysis for 'call' mode.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mgatk [OPTIONS] {bcall|call|tenx|check|support|remove-background}

  mgatk: a mitochondrial genome analysis toolkit.

  MODE = ['bcall', 'call', 'tenx', 'check', 'support', 'remove-background']

  See https://github.com/caleblareau/mgatk/wiki for more details.

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; either directory of singular .bam
                                  file; see documentation. REQUIRED.
                                  [required]
  -o, --output TEXT               Output directory for analysis required for
                                  `call` and `bcall`. Default = mgatk_out
  -n, --name TEXT                 Prefix for project name. Default = mgatk
  -g, --mito-genome TEXT          mitochondrial genome configuration. Choose
                                  hg19, hg38, mm10, (etc.) or a custom .fasta
                                  file; see documentation. Default = rCRS.
                                  [required]
  -c, --ncores TEXT               Number of cores to run the main job in
                                  parallel.
  --cluster TEXT                  Message to send to Snakemake to execute jobs
                                  on cluster interface; see documentation.
  --jobs TEXT                     Max number of jobs to be running
                                  concurrently on the cluster interface.
  -bt, --barcode-tag TEXT         Read tag (generally two letters) to separate
                                  single cells; valid and required only in
                                  `bcall` mode.
  -b, --barcodes TEXT             File path to barcodes that will be
                                  extracted; useful only in `bcall` mode. If
                                  none supplied, mgatk will learn abundant
                                  barcodes from the bam file (threshold
                                  defined by the -mb tag).
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic. Default = 1000.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 1.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 4.
  -kd, --keep-duplicates          Retained dupliate (presumably PCR) reads
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -ho, --handle-overlap           Only count each base in the overlap region
                                  between a pair of reads once
  -lc, --low-coverage-threshold INTEGER
                                  Variant count for each cell will be ignored
                                  below this when calculating VMR
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal per core. Default = 8000m.
  -pp, --proper-pairs             Require reads to be properly paired.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -eb, --emit-base-qualities      Output mean base quality per alt allele as
                                  part of the final output.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; Default = 7000.
                                  Supply 0 to try all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Add this flag to keep all intermediate
                                  files.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file. May be necessary for certain HPC
                                  environments.
  -nfg, --ncells_fg INTEGER       number of "foreground" cells to use for
                                  CellBender. Default = 1000.
  -nbg, --ncells_bg INTEGER       number of "background" cells to use for
                                  CellBender. Default = 20000.
  --help                          Show this message and exit.
```


## mgatk_tenx

### Tool Description
mgatk: a mitochondrial genome analysis toolkit. Mode: tenx.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mgatk [OPTIONS] {bcall|call|tenx|check|support|remove-background}

  mgatk: a mitochondrial genome analysis toolkit.

  MODE = ['bcall', 'call', 'tenx', 'check', 'support', 'remove-background']

  See https://github.com/caleblareau/mgatk/wiki for more details.

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; either directory of singular .bam
                                  file; see documentation. REQUIRED.
                                  [required]
  -o, --output TEXT               Output directory for analysis required for
                                  `call` and `bcall`. Default = mgatk_out
  -n, --name TEXT                 Prefix for project name. Default = mgatk
  -g, --mito-genome TEXT          mitochondrial genome configuration. Choose
                                  hg19, hg38, mm10, (etc.) or a custom .fasta
                                  file; see documentation. Default = rCRS.
                                  [required]
  -c, --ncores TEXT               Number of cores to run the main job in
                                  parallel.
  --cluster TEXT                  Message to send to Snakemake to execute jobs
                                  on cluster interface; see documentation.
  --jobs TEXT                     Max number of jobs to be running
                                  concurrently on the cluster interface.
  -bt, --barcode-tag TEXT         Read tag (generally two letters) to separate
                                  single cells; valid and required only in
                                  `bcall` mode.
  -b, --barcodes TEXT             File path to barcodes that will be
                                  extracted; useful only in `bcall` mode. If
                                  none supplied, mgatk will learn abundant
                                  barcodes from the bam file (threshold
                                  defined by the -mb tag).
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic. Default = 1000.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 1.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 4.
  -kd, --keep-duplicates          Retained dupliate (presumably PCR) reads
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -ho, --handle-overlap           Only count each base in the overlap region
                                  between a pair of reads once
  -lc, --low-coverage-threshold INTEGER
                                  Variant count for each cell will be ignored
                                  below this when calculating VMR
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal per core. Default = 8000m.
  -pp, --proper-pairs             Require reads to be properly paired.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -eb, --emit-base-qualities      Output mean base quality per alt allele as
                                  part of the final output.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; Default = 7000.
                                  Supply 0 to try all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Add this flag to keep all intermediate
                                  files.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file. May be necessary for certain HPC
                                  environments.
  -nfg, --ncells_fg INTEGER       number of "foreground" cells to use for
                                  CellBender. Default = 1000.
  -nbg, --ncells_bg INTEGER       number of "background" cells to use for
                                  CellBender. Default = 20000.
  --help                          Show this message and exit.
```


## mgatk_check

### Tool Description
mgatk: a mitochondrial genome analysis toolkit. check mode.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mgatk [OPTIONS] {bcall|call|tenx|check|support|remove-background}

  mgatk: a mitochondrial genome analysis toolkit.

  MODE = ['bcall', 'call', 'tenx', 'check', 'support', 'remove-background']

  See https://github.com/caleblareau/mgatk/wiki for more details.

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; either directory of singular .bam
                                  file; see documentation. REQUIRED.
                                  [required]
  -o, --output TEXT               Output directory for analysis required for
                                  `call` and `bcall`. Default = mgatk_out
  -n, --name TEXT                 Prefix for project name. Default = mgatk
  -g, --mito-genome TEXT          mitochondrial genome configuration. Choose
                                  hg19, hg38, mm10, (etc.) or a custom .fasta
                                  file; see documentation. Default = rCRS.
                                  [required]
  -c, --ncores TEXT               Number of cores to run the main job in
                                  parallel.
  --cluster TEXT                  Message to send to Snakemake to execute jobs
                                  on cluster interface; see documentation.
  --jobs TEXT                     Max number of jobs to be running
                                  concurrently on the cluster interface.
  -bt, --barcode-tag TEXT         Read tag (generally two letters) to separate
                                  single cells; valid and required only in
                                  `bcall` mode.
  -b, --barcodes TEXT             File path to barcodes that will be
                                  extracted; useful only in `bcall` mode. If
                                  none supplied, mgatk will learn abundant
                                  barcodes from the bam file (threshold
                                  defined by the -mb tag).
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic. Default = 1000.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 1.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 4.
  -kd, --keep-duplicates          Retained dupliate (presumably PCR) reads
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -ho, --handle-overlap           Only count each base in the overlap region
                                  between a pair of reads once
  -lc, --low-coverage-threshold INTEGER
                                  Variant count for each cell will be ignored
                                  below this when calculating VMR
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal per core. Default = 8000m.
  -pp, --proper-pairs             Require reads to be properly paired.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -eb, --emit-base-qualities      Output mean base quality per alt allele as
                                  part of the final output.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; Default = 7000.
                                  Supply 0 to try all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Add this flag to keep all intermediate
                                  files.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file. May be necessary for certain HPC
                                  environments.
  -nfg, --ncells_fg INTEGER       number of "foreground" cells to use for
                                  CellBender. Default = 1000.
  -nbg, --ncells_bg INTEGER       number of "background" cells to use for
                                  CellBender. Default = 20000.
  --help                          Show this message and exit.
```


## mgatk_support

### Tool Description
mgatk: a mitochondrial genome analysis toolkit. Support mode for mitochondrial genome analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mgatk [OPTIONS] {bcall|call|tenx|check|support|remove-background}

  mgatk: a mitochondrial genome analysis toolkit.

  MODE = ['bcall', 'call', 'tenx', 'check', 'support', 'remove-background']

  See https://github.com/caleblareau/mgatk/wiki for more details.

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; either directory of singular .bam
                                  file; see documentation. REQUIRED.
                                  [required]
  -o, --output TEXT               Output directory for analysis required for
                                  `call` and `bcall`. Default = mgatk_out
  -n, --name TEXT                 Prefix for project name. Default = mgatk
  -g, --mito-genome TEXT          mitochondrial genome configuration. Choose
                                  hg19, hg38, mm10, (etc.) or a custom .fasta
                                  file; see documentation. Default = rCRS.
                                  [required]
  -c, --ncores TEXT               Number of cores to run the main job in
                                  parallel.
  --cluster TEXT                  Message to send to Snakemake to execute jobs
                                  on cluster interface; see documentation.
  --jobs TEXT                     Max number of jobs to be running
                                  concurrently on the cluster interface.
  -bt, --barcode-tag TEXT         Read tag (generally two letters) to separate
                                  single cells; valid and required only in
                                  `bcall` mode.
  -b, --barcodes TEXT             File path to barcodes that will be
                                  extracted; useful only in `bcall` mode. If
                                  none supplied, mgatk will learn abundant
                                  barcodes from the bam file (threshold
                                  defined by the -mb tag).
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic. Default = 1000.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 1.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 4.
  -kd, --keep-duplicates          Retained dupliate (presumably PCR) reads
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -ho, --handle-overlap           Only count each base in the overlap region
                                  between a pair of reads once
  -lc, --low-coverage-threshold INTEGER
                                  Variant count for each cell will be ignored
                                  below this when calculating VMR
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal per core. Default = 8000m.
  -pp, --proper-pairs             Require reads to be properly paired.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -eb, --emit-base-qualities      Output mean base quality per alt allele as
                                  part of the final output.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; Default = 7000.
                                  Supply 0 to try all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Add this flag to keep all intermediate
                                  files.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file. May be necessary for certain HPC
                                  environments.
  -nfg, --ncells_fg INTEGER       number of "foreground" cells to use for
                                  CellBender. Default = 1000.
  -nbg, --ncells_bg INTEGER       number of "background" cells to use for
                                  CellBender. Default = 20000.
  --help                          Show this message and exit.
```


## mgatk_remove-background

### Tool Description
mgatk: a mitochondrial genome analysis toolkit. remove-background mode.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mgatk [OPTIONS] {bcall|call|tenx|check|support|remove-background}

  mgatk: a mitochondrial genome analysis toolkit.

  MODE = ['bcall', 'call', 'tenx', 'check', 'support', 'remove-background']

  See https://github.com/caleblareau/mgatk/wiki for more details.

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; either directory of singular .bam
                                  file; see documentation. REQUIRED.
                                  [required]
  -o, --output TEXT               Output directory for analysis required for
                                  `call` and `bcall`. Default = mgatk_out
  -n, --name TEXT                 Prefix for project name. Default = mgatk
  -g, --mito-genome TEXT          mitochondrial genome configuration. Choose
                                  hg19, hg38, mm10, (etc.) or a custom .fasta
                                  file; see documentation. Default = rCRS.
                                  [required]
  -c, --ncores TEXT               Number of cores to run the main job in
                                  parallel.
  --cluster TEXT                  Message to send to Snakemake to execute jobs
                                  on cluster interface; see documentation.
  --jobs TEXT                     Max number of jobs to be running
                                  concurrently on the cluster interface.
  -bt, --barcode-tag TEXT         Read tag (generally two letters) to separate
                                  single cells; valid and required only in
                                  `bcall` mode.
  -b, --barcodes TEXT             File path to barcodes that will be
                                  extracted; useful only in `bcall` mode. If
                                  none supplied, mgatk will learn abundant
                                  barcodes from the bam file (threshold
                                  defined by the -mb tag).
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic. Default = 1000.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 1.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 4.
  -kd, --keep-duplicates          Retained dupliate (presumably PCR) reads
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -ho, --handle-overlap           Only count each base in the overlap region
                                  between a pair of reads once
  -lc, --low-coverage-threshold INTEGER
                                  Variant count for each cell will be ignored
                                  below this when calculating VMR
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal per core. Default = 8000m.
  -pp, --proper-pairs             Require reads to be properly paired.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -eb, --emit-base-qualities      Output mean base quality per alt allele as
                                  part of the final output.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; Default = 7000.
                                  Supply 0 to try all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Add this flag to keep all intermediate
                                  files.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file. May be necessary for certain HPC
                                  environments.
  -nfg, --ncells_fg INTEGER       number of "foreground" cells to use for
                                  CellBender. Default = 1000.
  -nbg, --ncells_bg INTEGER       number of "background" cells to use for
                                  CellBender. Default = 20000.
  --help                          Show this message and exit.
```


## Metadata
- **Skill**: not generated
