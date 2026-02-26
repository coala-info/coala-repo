cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-intersect
label: pgscatalog-utils_pgscatalog-intersect
doc: "Program to find matched variants (same strand) between a set of reference and
  target data .pvar/bim files. This also evaluate whether the variants in the TARGET
  are suitable for inclusion in a PCA analysis (excludes strand ambiguous and multi-allelic/INDEL
  variants), and can also uses the .afreq and .vmiss files exclude variants with missingness
  and MAF filters.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of variants processed per batch
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: filter_chrom
    type:
      - 'null'
      - string
    doc: Whether to limit matches to specific chromosome of the reference
    inputBinding:
      position: 101
      prefix: --chrom
  - id: maf_filter
    type:
      - 'null'
      - float
    doc: 'Filter: Minimum minor Allele Frequency for PCA eligibility'
    inputBinding:
      position: 101
      prefix: --maf_target
  - id: reference
    type: File
    doc: path/to/REFERENCE/pvar
    inputBinding:
      position: 101
      prefix: --reference
  - id: target
    type:
      type: array
      items: File
    doc: A list of paths of target genomic variants (.bim/pvar format). The 
      .afreq and .vmiss files are also required for these files.
    inputBinding:
      position: 101
      prefix: --target
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 101
      prefix: --verbose
  - id: vmiss_filter
    type:
      - 'null'
      - float
    doc: 'Filter: Maximum Genotype missingness for PCA eligibility'
    inputBinding:
      position: 101
      prefix: --geno_miss
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
