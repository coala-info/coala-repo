cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracy
  - decompose
label: tracy_decompose
doc: "Decompose Sanger chromatogram trace files to identify variants or reference
  alignments.\n\nTool homepage: https://github.com/gear-genomics/tracy"
inputs:
  - id: trace_file
    type: File
    doc: Input trace.ab1 file
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - string
    doc: annotate variants 
      [homo_sapiens|homo_sapiens_hg19|mus_musculus|danio_rerio|...]
    inputBinding:
      position: 102
      prefix: --annotate
  - id: call_variants
    type:
      - 'null'
      - boolean
    doc: call variants in trace
    inputBinding:
      position: 102
      prefix: --callVariants
  - id: gapext
    type:
      - 'null'
      - int
    doc: gap extension
    default: -4
    inputBinding:
      position: 102
      prefix: --gapext
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open
    default: -10
    inputBinding:
      position: 102
      prefix: --gapopen
  - id: genome
    type:
      - 'null'
      - File
    doc: (gzipped) fasta or wildtype ab1 file
    inputBinding:
      position: 102
      prefix: --genome
  - id: kmer
    type:
      - 'null'
      - int
    doc: kmer size
    default: 15
    inputBinding:
      position: 102
      prefix: --kmer
  - id: linelimit
    type:
      - 'null'
      - int
    doc: alignment line length
    default: 60
    inputBinding:
      position: 102
      prefix: --linelimit
  - id: match
    type:
      - 'null'
      - int
    doc: match
    default: 3
    inputBinding:
      position: 102
      prefix: --match
  - id: maxindel
    type:
      - 'null'
      - int
    doc: max. indel size in Sanger trace
    default: 1000
    inputBinding:
      position: 102
      prefix: --maxindel
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch
    default: -5
    inputBinding:
      position: 102
      prefix: --mismatch
  - id: pratio
    type:
      - 'null'
      - float
    doc: peak ratio to call base
    default: 0.330000013
    inputBinding:
      position: 102
      prefix: --pratio
  - id: support
    type:
      - 'null'
      - int
    doc: min. kmer support
    default: 3
    inputBinding:
      position: 102
      prefix: --support
  - id: trim
    type:
      - 'null'
      - int
    doc: 'trimming stringency [1:9], 0: use trimLeft and trimRight'
    default: 0
    inputBinding:
      position: 102
      prefix: --trim
  - id: trim_left
    type:
      - 'null'
      - int
    doc: trim size left
    default: 50
    inputBinding:
      position: 102
      prefix: --trimLeft
  - id: trim_right
    type:
      - 'null'
      - int
    doc: trim size right
    default: 50
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
