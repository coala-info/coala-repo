# maegatk CWL Generation Report

## maegatk_bcall

### Tool Description
a Maester genome toolkit.

### Metadata
- **Docker Image**: quay.io/biocontainers/maegatk:0.2.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/maegatk
- **Package**: https://anaconda.org/channels/bioconda/packages/maegatk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/maegatk/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/caleblareau/maegatk
- **Stars**: N/A
### Original Help Text
```text
Usage: maegatk [OPTIONS] {bcall|support}

  maegatk: a Maester genome toolkit.

  MODE = ['bcall', 'support']

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; a singular, indexed bam file.
                                  [required]
  -o, --output TEXT               Output directory for genotypes.
  -n, --name TEXT                 Prefix for project name
  -g, --mito-genome TEXT          mitochondrial genome configuration. Requires
                                  bwa indexed fasta file or `rCRS` (built-in)
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
                                  extracted; useful only in `bcall` mode.
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 2.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 15.
  -mr, --min-reads INTEGER        Minimum number of supporting reads to call a
                                  consensus UMI/rread. Default = 1.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal. Default = 4000m.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; default is all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Keep all intermediate files.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -sb, --skip-barcodesplit        Skip the time consuming barcode-splitting
                                  step if it finished successfully before
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file.
  --help                          Show this message and exit.
```


## maegatk_support

### Tool Description
a Maester genome toolkit.

### Metadata
- **Docker Image**: quay.io/biocontainers/maegatk:0.2.0--pyhdfd78af_2
- **Homepage**: https://github.com/caleblareau/maegatk
- **Package**: https://anaconda.org/channels/bioconda/packages/maegatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: maegatk [OPTIONS] {bcall|support}

  maegatk: a Maester genome toolkit.

  MODE = ['bcall', 'support']

Options:
  --version                       Show the version and exit.
  -i, --input TEXT                Input; a singular, indexed bam file.
                                  [required]
  -o, --output TEXT               Output directory for genotypes.
  -n, --name TEXT                 Prefix for project name
  -g, --mito-genome TEXT          mitochondrial genome configuration. Requires
                                  bwa indexed fasta file or `rCRS` (built-in)
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
                                  extracted; useful only in `bcall` mode.
  -mb, --min-barcode-reads INTEGER
                                  Minimum number of mitochondrial reads for a
                                  barcode to be genotyped; useful only in
                                  `bcall` mode; will not overwrite the
                                  `--barcodes` logic.
  --NHmax INTEGER                 Maximum number of read alignments allowed as
                                  governed by the NH flag. Default = 2.
  --NMmax INTEGER                 Maximum number of paired mismatches allowed
                                  represented by the NM/nM tags. Default = 15.
  -mr, --min-reads INTEGER        Minimum number of supporting reads to call a
                                  consensus UMI/rread. Default = 1.
  -qc, --keep-qc-bams             Add this flag to keep the quality-controlled
                                  bams after processing.
  -ub, --umi-barcode TEXT         Read tag (generally two letters) to specify
                                  the UMI tag when removing duplicates for
                                  genotyping.
  -jm, --max-javamem TEXT         Maximum memory for java for running
                                  duplicate removal. Default = 4000m.
  -q, --base-qual INTEGER         Minimum base quality for inclusion in the
                                  genotype count. Default = 0.
  -aq, --alignment-quality INTEGER
                                  Minimum alignment quality to include read in
                                  genotype. Default = 0.
  -ns, --nsamples INTEGER         The number of samples / cells to be
                                  processed per iteration; default is all.
  -k, --keep-samples TEXT         Comma separated list of sample names to
                                  keep; ALL (special string) by default.
                                  Sample refers to basename of .bam file
  -x, --ignore-samples TEXT       Comma separated list of sample names to
                                  ignore; NONE (special string) by default.
                                  Sample refers to basename of .bam file
  -z, --keep-temp-files           Keep all intermediate files.
  -sr, --skip-R                   Generate plain-text only output. Otherwise,
                                  this generates a .rds obejct that can be
                                  immediately read into R for downstream
                                  analysis.
  -sb, --skip-barcodesplit        Skip the time consuming barcode-splitting
                                  step if it finished successfully before
  -so, --snake-stdout             Write snakemake log to sdout rather than a
                                  file.
  --help                          Show this message and exit.
```


## Metadata
- **Skill**: generated
