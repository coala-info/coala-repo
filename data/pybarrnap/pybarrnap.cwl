cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybarrnap
label: pybarrnap
doc: "Python implementation of barrnap (Bacterial ribosomal RNA predictor)\n\nTool
  homepage: https://github.com/moshi4/pybarrnap/"
inputs:
  - id: fasta
    type: File
    doc: Input fasta file (or stdin)
    inputBinding:
      position: 1
  - id: accurate
    type:
      - 'null'
      - boolean
    doc: Use cmscan instead of pyhmmer.nhmmer
    default: false
    inputBinding:
      position: 102
      prefix: --accurate
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value cutoff
    default: '1e-06'
    inputBinding:
      position: 102
      prefix: --evalue
  - id: incseq
    type:
      - 'null'
      - boolean
    doc: Include FASTA input sequences in GFF output
    default: false
    inputBinding:
      position: 102
      prefix: --incseq
  - id: kingdom
    type:
      - 'null'
      - string
    doc: "Target kingdom [bac|arc|euk|all]\n                     kingdom='all' is
      available only when set with `--accurate` option"
    default: bac
    inputBinding:
      position: 102
      prefix: --kingdom
  - id: lencutoff
    type:
      - 'null'
      - float
    doc: Proportional length threshold to label as partial
    default: 0.8
    inputBinding:
      position: 102
      prefix: --lencutoff
  - id: outseq
    type:
      - 'null'
      - File
    doc: Output rRNA hit seqs as fasta file
    default: None
    inputBinding:
      position: 102
      prefix: --outseq
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No print log on screen
    default: false
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reject
    type:
      - 'null'
      - float
    doc: Proportional length threshold to reject prediction
    default: 0.25
    inputBinding:
      position: 102
      prefix: --reject
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybarrnap:0.5.1--pyhdfd78af_0
stdout: pybarrnap.out
