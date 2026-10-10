cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - moni
  - mems
label: moni_mems
doc: "Find maximal exact matches (MEMs) between a query and a reference genome.\n\n\
  Tool homepage: https://github.com/maxrossi91/moni"
inputs:
  - id: extended_output
    type:
      - 'null'
      - boolean
    doc: output MEM occurrence in the reference
    inputBinding:
      position: 101
      prefix: --extended-output
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
  - id: minimum_mem_length
    type:
      - 'null'
      - int
    doc: minimum MEM length
    inputBinding:
      position: 101
      prefix: --minimum-MEM-length
  - id: output
    type:
      - 'null'
      - string
    doc: output file prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: pattern
    type: File
    doc: the input query
    inputBinding:
      position: 101
      prefix: --pattern
  - id: sam_output
    type:
      - 'null'
      - boolean
    doc: output MEM in a SAM formatted file.
    inputBinding:
      position: 101
      prefix: --sam-output
  - id: threads
    type:
      - 'null'
      - int
    doc: number of helper threads
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output
    outputBinding:
      glob: $(inputs.output)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moni:0.2.2--py312h9b99d9e_0
stdout: moni_mems.out
