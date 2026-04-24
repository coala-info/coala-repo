cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracy
  - assemble
label: tracy_assemble
doc: "Assemble trace files into a consensus sequence, optionally guided by a reference.\n\
  \nTool homepage: https://github.com/gear-genomics/tracy"
inputs:
  - id: traces
    type:
      type: array
      items: File
    doc: Trace files to assemble (e.g., .ab1 files)
    inputBinding:
      position: 1
  - id: called
    type:
      - 'null'
      - float
    doc: fraction of traces required for consensus
    inputBinding:
      position: 102
      prefix: --called
  - id: format
    type:
      - 'null'
      - string
    doc: consensus output format [fasta|fastq]
    inputBinding:
      position: 102
      prefix: --format
  - id: fracmatch
    type:
      - 'null'
      - float
    doc: min. fraction of matches [0:1]
    inputBinding:
      position: 102
      prefix: --fracmatch
  - id: gapext
    type:
      - 'null'
      - int
    doc: gap extension
    inputBinding:
      position: 102
      prefix: --gapext
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open
    inputBinding:
      position: 102
      prefix: --gapopen
  - id: inccons
    type:
      - 'null'
      - boolean
    doc: include consensus in FASTA align
    inputBinding:
      position: 102
      prefix: --inccons
  - id: incref
    type:
      - 'null'
      - boolean
    doc: include reference in consensus computation (req. --reference)
    inputBinding:
      position: 102
      prefix: --incref
  - id: match
    type:
      - 'null'
      - int
    doc: match
    inputBinding:
      position: 102
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: pratio
    type:
      - 'null'
      - float
    doc: peak ratio to call base
    inputBinding:
      position: 102
      prefix: --pratio
  - id: reference
    type:
      - 'null'
      - File
    doc: reference-guided assembly (optional)
    inputBinding:
      position: 102
      prefix: --reference
  - id: trim
    type:
      - 'null'
      - int
    doc: 'trimming stringency [1:9], 0: disable trimming'
    inputBinding:
      position: 102
      prefix: --trim
outputs:
  - id: outprefix
    type:
      - 'null'
      - File
    doc: output prefix
    outputBinding:
      glob: $(inputs.outprefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracy:0.8.1--h4d20210_0
