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
    inputBinding:
      position: 102
      prefix: --accurate
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value cutoff
    inputBinding:
      position: 102
      prefix: --evalue
  - id: incseq
    type:
      - 'null'
      - boolean
    doc: Include FASTA input sequences in GFF output
    inputBinding:
      position: 102
      prefix: --incseq
  - id: kingdom
    type:
      - 'null'
      - string
    doc: "Target kingdom [bac|arc|euk|all]\n                     kingdom='all' is
      available only when set with `--accurate` option"
    inputBinding:
      position: 102
      prefix: --kingdom
  - id: lencutoff
    type:
      - 'null'
      - float
    doc: Proportional length threshold to label as partial
    inputBinding:
      position: 102
      prefix: --lencutoff
  - id: outseq
    type:
      - 'null'
      - File
    doc: Output rRNA hit seqs as fasta file
    inputBinding:
      position: 102
      prefix: --outseq
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No print log on screen
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reject
    type:
      - 'null'
      - float
    doc: Proportional length threshold to reject prediction
    inputBinding:
      position: 102
      prefix: --reject
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
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
