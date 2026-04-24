cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgscatalog-matchmerge
label: pgscatalog.match_pgscatalog-matchmerge
doc: "Match and merge score files with target genomic datasets.\n\nTool homepage:
  https://github.com/PGScatalog/pygscatalog"
inputs:
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Cleanup intermediate files
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: combined
    type:
      - 'null'
      - boolean
    doc: Write scorefiles in combined format?
    inputBinding:
      position: 101
      prefix: --combined
  - id: dataset
    type: string
    doc: Label for target genomic dataset
    inputBinding:
      position: 101
      prefix: --dataset
  - id: filter_ids
    type:
      - 'null'
      - File
    doc: Path to file containing list of variant IDs that can be included in the
      final scorefile.[useful for limiting scoring files to variants present in 
      multiple datasets]
    inputBinding:
      position: 101
      prefix: --filter_IDs
  - id: ignore_strand_flips
    type:
      - 'null'
      - boolean
    doc: Flag to not consider matched variants that may be reported on the 
      opposite strand. Default behaviour is to flip/complement unmatched 
      variants and check if they match.
    inputBinding:
      position: 101
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
      position: 101
      prefix: --keep_ambiguous
  - id: keep_first_match
    type:
      - 'null'
      - boolean
    doc: "If multiple match candidates for a variant exist that can't be prioritised,
      keep the first match candidate (default: drop all candidates)"
    inputBinding:
      position: 101
      prefix: --keep_first_match
  - id: keep_multiallelic
    type:
      - 'null'
      - boolean
    doc: 'Flag to allow matching to multiallelic variants (default: false).'
    inputBinding:
      position: 101
      prefix: --keep_multiallelic
  - id: matches
    type:
      type: array
      items: File
    doc: List of match files
    inputBinding:
      position: 101
      prefix: --matches
  - id: min_overlap
    type: float
    doc: Minimum proportion of variants to match before error
    inputBinding:
      position: 101
      prefix: --min_overlap
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Do not cleanup intermediate files
    inputBinding:
      position: 101
      prefix: --no-cleanup
  - id: outdir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: scorefile
    type:
      type: array
      items: File
    doc: Path to scorefile. Multiple paths supported
    inputBinding:
      position: 101
      prefix: --scorefile
  - id: split
    type:
      - 'null'
      - boolean
    doc: Write scorefiles split per chromosome?
    inputBinding:
      position: 101
      prefix: --split
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Extra logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgscatalog.match:0.4.0--pyhdfd78af_0
stdout: pgscatalog.match_pgscatalog-matchmerge.out
