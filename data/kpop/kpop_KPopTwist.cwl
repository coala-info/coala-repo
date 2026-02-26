cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopTwist_
label: kpop_KPopTwist
doc: "This is KPopTwist version 20 [29-Feb-2024]\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: fraction
    type:
      - 'null'
      - float
    doc: fraction of the k-mers to be considered and resampled before twisting
    default: '1.'
    inputBinding:
      position: 101
      prefix: --fraction
  - id: input_prefix
    type: string
    doc: "load the specified k-mer database in the register and twist it.\n    File
      extension is automatically determined\n     (will be .KPopCounter).\n    The
      prefix is then re-used for output\n     (and the output files will be given
      extensions\n      .KPopTwister and .KPopTwisted)"
    inputBinding:
      position: 101
      prefix: --input
  - id: keep_temporaries
    type:
      - 'null'
      - boolean
    doc: keep temporary files rather than deleting them in the end
    default: 'false'
    inputBinding:
      position: 101
      prefix: --keep-temporaries
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: whether to normalize spectra after transformation and before twisting
    default: 'true'
    inputBinding:
      position: 101
      prefix: --normalize
  - id: normalize_counts
    type:
      - 'null'
      - boolean
    doc: whether to normalize spectra after transformation and before twisting
    default: 'true'
    inputBinding:
      position: 101
      prefix: --normalize-counts
  - id: output_prefix
    type: string
    doc: "use this prefix when dumping generated twister and twisted sequences.\n\
      \    File extensions are automatically determined\n     (will be .KPopTwister
      and .KPopTwisted)"
    inputBinding:
      position: 101
      prefix: --output
  - id: power
    type:
      - 'null'
      - float
    doc: "raise counts to this power before transforming them.\n    A power of 0 when
      the 'pseudocounts' method is used\n    performs a logarithmic transformation"
    default: '1.'
    inputBinding:
      position: 101
      prefix: --power
  - id: sampling
    type:
      - 'null'
      - float
    doc: fraction of the k-mers to be considered and resampled before twisting
    default: '1.'
    inputBinding:
      position: 101
      prefix: --sampling
  - id: sampling_fraction
    type:
      - 'null'
      - float
    doc: fraction of the k-mers to be considered and resampled before twisting
    default: '1.'
    inputBinding:
      position: 101
      prefix: --sampling-fraction
  - id: threads
    type:
      - 'null'
      - int
    doc: number of concurrent computing threads to be spawned
    default: '20'
    inputBinding:
      position: 101
      prefix: --threads
  - id: threshold_counts
    type:
      - 'null'
      - float
    doc: "set to zero all counts that are less than this threshold\n    before transforming
      them.\n    A fractional threshold between 0. and 1. is taken as a relative one\n\
      \    with respect to the sum of all counts in the spectrum"
    default: '1.'
    inputBinding:
      position: 101
      prefix: --threshold-counts
  - id: threshold_kmers
    type:
      - 'null'
      - int
    doc: "compute the sum of all transformed (and possibly normalized) counts\n  \
      \  for each k-mer, and eliminate k-mers such that the corresponding sum\n  \
      \  is less than the largest sum rescaled by this threshold.\n    This filters
      out k-mers having low frequencies across all spectra"
    default: '0.'
    inputBinding:
      position: 101
      prefix: --threshold-kmers
  - id: transform
    type:
      - 'null'
      - string
    doc: transformation to apply to table elements
    default: power
    inputBinding:
      position: 101
      prefix: --transform
  - id: transformation
    type:
      - 'null'
      - string
    doc: transformation to apply to table elements
    default: power
    inputBinding:
      position: 101
      prefix: --transformation
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set verbose execution
    default: 'false'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopTwist.out
