cwlVersion: v1.2
class: CommandLineTool
baseCommand: KPopTwist
label: kpop_KPopTwist
doc: "Generates an unsupervised coordinate transformation (twister) from a database of k-mer spectra and the twisted spectra.\n\nTool homepage: https://github.com/PaoloRibeca/KPop"
inputs:
  - id: input_db
    type: File
    doc: k-mer database (file with extension .KPopCounter) to twist.
    inputBinding:
      position: 1
      prefix: '-i'
      valueFrom: '${ return self.path.replace(/\.KPopCounter$/, ""); }'
  - id: output_prefix
    type: string
    doc: Prefix for the generated twister and twisted files (extensions
      .KPopTwister and .KPopTwisted).
    inputBinding:
      position: 2
      prefix: '-o'
  - id: fraction
    type:
      - 'null'
      - float
    doc: Fraction of the k-mers to be considered and resampled before twisting
      (default 1).
    inputBinding:
      position: 3
      prefix: '-f'
  - id: threshold_counts
    type:
      - 'null'
      - float
    doc: Set to zero all counts that are less than this threshold before
      transforming them (default 1).
    inputBinding:
      position: 4
      prefix: '--threshold-counts'
  - id: power
    type:
      - 'null'
      - float
    doc: Raise counts to this power before transforming them (default 1).
    inputBinding:
      position: 5
      prefix: '--power'
  - id: transform
    type:
      - 'null'
      - string
    doc: "Transformation applied to table elements: binary, power, pseudocounts
      or clr (default power)."
    inputBinding:
      position: 6
      prefix: '--transform'
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Whether to normalize spectra after transformation and before twisting
      (default true).
    inputBinding:
      position: 7
      prefix: '--normalize'
      valueFrom: '${ return self ? "true" : "false"; }'
  - id: threshold_kmers
    type:
      - 'null'
      - float
    doc: Eliminate k-mers whose summed transformed counts are below the largest
      sum rescaled by this threshold (default 0).
    inputBinding:
      position: 8
      prefix: '--threshold-kmers'
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of concurrent computing threads to be spawned.
    inputBinding:
      position: 9
      prefix: '-T'
  - id: keep_temporaries
    type:
      - 'null'
      - boolean
    doc: Keep temporary files rather than deleting them in the end.
    inputBinding:
      position: 10
      prefix: '--keep-temporaries'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set verbose execution.
    inputBinding:
      position: 11
      prefix: '-v'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: twister
    type: File
    doc: Twister (coordinate transformation)
    outputBinding:
      glob: '$(inputs.output_prefix).KPopTwister'
  - id: twisted
    type: File
    doc: Twisted spectra
    outputBinding:
      glob: '$(inputs.output_prefix).KPopTwisted'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kpop:1.1.1--h9ee0642_1
stdout: kpop_KPopTwist.out
