cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - bpovl
label: truvari_anno_bpovl
doc: "Creates intersection of features in an annotation file with SVs' breakpoints and overlap\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: anno
    type: File
    doc: Tab-delimited annotation file
    inputBinding:
      position: 1
      prefix: "-a"
  - id: output
    type:
      - 'null'
      - string
    default: bpovl.jl
    doc: Output joblib DataFrame
    inputBinding:
      position: 1
      prefix: "-o"
  - id: sizemin
    type:
      - 'null'
      - int
    doc: Minimum size of variant to annotate (50)
    inputBinding:
      position: 1
      prefix: "--sizemin"
  - id: spanmax
    type:
      - 'null'
      - int
    doc: Maximum span of SVs to annotate (50000)
    inputBinding:
      position: 1
      prefix: "--spanmax"
  - id: preset
    type:
      - 'null'
      - type: enum
        symbols:
          - bed
          - gff
    doc: Annotation format. This option overwrites -s, -b, -e, -c and -1 (None)
    inputBinding:
      position: 1
      prefix: "-p"
  - id: comment
    type:
      - 'null'
      - string
    doc: "Skip lines started with character. (#)"
    inputBinding:
      position: 1
      prefix: "-c"
  - id: sequence
    type:
      - 'null'
      - int
    doc: Column of sequence/chromosome name. (0)
    inputBinding:
      position: 1
      prefix: "-s"
  - id: begin
    type:
      - 'null'
      - int
    doc: Column of start chromosomal position. (1)
    inputBinding:
      position: 1
      prefix: "-b"
  - id: end
    type:
      - 'null'
      - int
    doc: Column of end chromosomal position. (2)
    inputBinding:
      position: 1
      prefix: "-e"
  - id: one_based
    type:
      - 'null'
      - boolean
    doc: The position in the anno file is 1-based rather than 0-based. (False)
    inputBinding:
      position: 1
      prefix: "--one-based"
  - id: input
    type: File
    doc: VCF to annotate (stdin in the tool; a file here)
    inputBinding:
      position: 2
outputs:
  - id: output_joblib
    type: File
    doc: Joblib DataFrame of breakpoint/overlap annotations
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
