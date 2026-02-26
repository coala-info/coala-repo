cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-match
label: pgscatalog-utils_pgscatalog-match
doc: "Match variants from a combined scoring file against a set of target genomes
  from the same fileset, and output scoring files compatible with the plink2 --score
  function.\n\nTool homepage: https://github.com/PGScatalog/pygscatalog"
inputs:
  - id: target
    type:
      type: array
      items: File
    doc: A list of paths of target genomic variants (.bim format)
    inputBinding:
      position: 1
  - id: chrom
    type:
      - 'null'
      - string
    doc: Set which chromosome is in the target variant file to speed up matching
    inputBinding:
      position: 102
      prefix: --chrom
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Enable cleanup
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: combined
    type:
      - 'null'
      - boolean
    doc: Write scorefiles in combined format?
    inputBinding:
      position: 102
      prefix: --combined
  - id: dataset
    type: string
    doc: Label for target genomic dataset
    inputBinding:
      position: 102
      prefix: --dataset
  - id: filter_ids
    type:
      - 'null'
      - File
    doc: Path to file containing list of variant IDs that can be included in the
      final scorefile.[useful for limiting scoring files to variants present in 
      multiple datasets]
    inputBinding:
      position: 102
      prefix: --filter_IDs
  - id: ignore_strand_flips
    type:
      - 'null'
      - boolean
    doc: Flag to not consider matched variants that may be reported on the 
      opposite strand. Default behaviour is to flip/complement unmatched 
      variants and check if they match.
    inputBinding:
      position: 102
      prefix: --ignore_strand_flips
  - id: keep_ambiguous
    type:
      - 'null'
      - boolean
    doc: 'Flag to force the program to keep variants with ambiguous alleles, (e.g.
      A/T and G/C SNPs), which are normally excluded (default: false). In this case
      the program proceeds assuming that the genotype data is on the same strand as
      the GWAS whose summary statistics were used to construct the score.'
    inputBinding:
      position: 102
      prefix: --keep_ambiguous
  - id: keep_first_match
    type:
      - 'null'
      - boolean
    doc: "If multiple match candidates for a variant exist that can't be prioritised,
      keep the first match candidate (default: drop all candidates)"
    inputBinding:
      position: 102
      prefix: --keep_first_match
  - id: keep_multiallelic
    type:
      - 'null'
      - boolean
    doc: 'Flag to allow matching to multiallelic variants (default: false).'
    inputBinding:
      position: 102
      prefix: --keep_multiallelic
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: Minimum proportion of variants to match before error
    inputBinding:
      position: 102
      prefix: --min_overlap
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Disable cleanup
    inputBinding:
      position: 102
      prefix: --no-cleanup
  - id: only_match
    type:
      - 'null'
      - boolean
    doc: Only match, then write intermediate files, don't make scoring files
    inputBinding:
      position: 102
      prefix: --only_match
  - id: scorefile
    type: File
    doc: Combined scorefile path (output of read_scorefiles.py)
    inputBinding:
      position: 102
      prefix: --scorefiles
  - id: split
    type:
      - 'null'
      - boolean
    doc: Split scorefile per chromosome?
    inputBinding:
      position: 102
      prefix: --split
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0
