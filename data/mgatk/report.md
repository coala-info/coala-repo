# mgatk CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mgatk_bcall | PASS | 3 cell barcodes from the mgatk test BAM; per-barcode mean depth 142.2, 178.2 and 206.5 match samtools depth; barcode tag made required and BAM index staged |
| mgatk_call | PASS | 2 human mito BAMs from the mgatk tests give base count tables; depthTable 58 and 63 reads depth, 82 and 105 with filters off vs samtools 76 and 97; input now accepts a directory |
| mgatk_mgatk-del | PASS | new CWL; Pearson syndrome test BAMs give the known del6073-13095 at 25 and 31 percent heteroplasmy |
| mgatk_mgatk-del-find | PASS | new CWL; clip and SA tables written (16569 positions, junctions 6073 and 13095 among the top clipped sites); the plot step prints an R error because ggrepel is missing in the image |
| mgatk_remove-background | Failed | image problem: cellbender and the R packages hdf5r, optparse and tidyr are missing |
| mgatk_tenx | Failed | image problem: matplotlib is missing so variant_stats, cell_heteroplasmic_df and the VMR plot are not written (mgatk still exits 0) |

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


## mgatk_mgatk-del

### Tool Description
Quantify deletion heteroplasmy in mtDNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mgatk-del [OPTIONS]

  mgatk-del: quantify deletion heteroplasmy in mtDNA.

Options:
  --version                      Show the version and exit.
  -i, --input TEXT               Input; either directory of singular .bam
                                 file; see wiki  [required]
  -o, --output TEXT              Output directory for analysis.
  -n, --name TEXT                Prefix for project name
  -mc, --mito-chromosome TEXT    Mitochondria chromosome name; see wiki
                                 [required]
  -c, --ncores TEXT              Number of cores to run the main job in
                                 parallel.
  --cluster TEXT                 Message to send to Snakemake to execute jobs
                                 on cluster interface; see wiki.
  --jobs TEXT                    Max number of jobs to be running concurrently
                                 on the cluster interface.
  -lc, --left-coordinates TEXT   Comma separated values for right coordinate
                                 of deletions; see wiki
  -rc, --right-coordinates TEXT  Comma separated values for right coordinate
                                 of deletions; see wiki
  -rl, --read-length TEXT        Expected length of a single read from the
                                 .bam file
  -wo, --window-outer TEXT       Number of bases from the start of each read
                                 mates ("outer" part of read) ignored for
                                 estimating heteroplasmy.
  -wi, --window-inner TEXT       Number of bases near the insert of the read
                                 mates ("outer" part of read) ignored for
                                 estimating heteroplasmy.
  -z, --keep-temp-files          Keep all intermediate files.
  -so, --snake-stdout            Write snakemake log to sdout rather than a
                                 file.
  --help                         Show this message and exit.
```

## mgatk_mgatk-del-find

### Tool Description
Detect possible deletion junctions from bam files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mgatk:0.7.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/mgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/mgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: mgatk-del-find [OPTIONS]

  mgatk-del-find: detect possible deletion junctions from bam files.

  See: `mgatk-del-find --help`

Options:
  --version                    Show the version and exit.
  -i, --input TEXT             Input; a single .bam file of reads to be
                               processed.  [required]
  -mc, --mito-chromosome TEXT  Name of mtDNA chromosome in bam file (e.g. chrM
                               or MT)  [required]
  -o, --output TEXT            Name of output files prefix  [required]
  --help                       Show this message and exit.
```

## Metadata
- **Skill**: generated
