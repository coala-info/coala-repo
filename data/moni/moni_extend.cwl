cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - moni
  - extend
label: moni_extend
doc: "Extend query patterns against a reference index.\n\nTool homepage: https://github.com/maxrossi91/moni"
inputs:
  - id: batch
    type:
      - 'null'
      - int
    doc: number of reads per thread batch
    inputBinding:
      position: 101
      prefix: --batch
  - id: extl
    type:
      - 'null'
      - int
    doc: length of reference substring for extension
    inputBinding:
      position: 101
      prefix: --extl
  - id: gape
    type:
      - 'null'
      - string
    doc: coma separated gap extension penalty values
    inputBinding:
      position: 101
      prefix: --gape
  - id: gapo
    type:
      - 'null'
      - string
    doc: coma separated gap open penalty values
    inputBinding:
      position: 101
      prefix: --gapo
  - id: grammar
    type:
      - 'null'
      - string
    doc: select the grammar [plain, shaped]
    inputBinding:
      position: 101
      prefix: --grammar
  - id: index
    type: string
    doc: reference index prefix (the files written by moni build, for example
      sars-cov2 for sars-cov2.plain.slp, sars-cov2.thrbv.ms and sars-cov2.idx)
    inputBinding:
      position: 101
      prefix: --index
  - id: index_files
    type:
      type: array
      items: File
    doc: The index files written by moni build (.plain.slp, .thrbv.ms, .idx). They
      are staged in the working directory.
  - id: pattern
    type: File
    doc: the input query
    inputBinding:
      position: 101
      prefix: --pattern
  - id: smatch
    type:
      - 'null'
      - int
    doc: match score value
    inputBinding:
      position: 101
      prefix: --smatch
  - id: smismatch
    type:
      - 'null'
      - int
    doc: mismatch penalty value
    inputBinding:
      position: 101
      prefix: --smismatch
  - id: threads
    type:
      - 'null'
      - int
    doc: number of helper threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_path
    outputBinding:
      glob: $(inputs.output_path)*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.index_files)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
