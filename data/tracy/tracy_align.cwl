cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracy
  - align
label: tracy_align
doc: "Align Sanger trace files to a reference genome or wildtype trace\n\nTool homepage:
  https://github.com/gear-genomics/tracy"
inputs:
  - id: trace_file
    type: File
    doc: Sanger trace file (e.g., trace.ab1)
    inputBinding:
      position: 1
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
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size to anchor trace
    inputBinding:
      position: 102
      prefix: --kmer
  - id: linelimit
    type:
      - 'null'
      - int
    doc: alignment line length
    inputBinding:
      position: 102
      prefix: --linelimit
  - id: match
    type:
      - 'null'
      - int
    doc: match
    inputBinding:
      position: 102
      prefix: --match
  - id: maxindel
    type:
      - 'null'
      - int
    doc: max. indel size in Sanger trace
    inputBinding:
      position: 102
      prefix: --maxindel
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
    type: File
    doc: (gzipped) fasta or wildtype ab1 file
    inputBinding:
      position: 102
      prefix: --reference
  - id: support
    type:
      - 'null'
      - int
    doc: min. kmer support
    inputBinding:
      position: 102
      prefix: --support
  - id: trim
    type:
      - 'null'
      - int
    doc: 'trimming stringency [1:9], 0: use trimLeft and trimRight'
    inputBinding:
      position: 102
      prefix: --trim
  - id: trim_left
    type:
      - 'null'
      - int
    doc: trim size left
    inputBinding:
      position: 102
      prefix: --trimLeft
  - id: trim_right
    type:
      - 'null'
      - int
    doc: trim size right
    inputBinding:
      position: 102
      prefix: --trimRight
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
