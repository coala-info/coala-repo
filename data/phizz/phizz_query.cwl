cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phizz
  - query
label: phizz_query
doc: "Query the hpo database.\n  Print the result in csv format as default.\n\nTool
  homepage: https://github.com/moonso/phizz"
inputs:
  - id: chrom
    type:
      - 'null'
      - string
    doc: The chromosome
    inputBinding:
      position: 101
      prefix: --chrom
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file path
    inputBinding:
      position: 101
      prefix: --config
  - id: hpo_term
    type:
      - 'null'
      - string
    doc: Specify a hpo term
    inputBinding:
      position: 101
      prefix: --hpo_term
  - id: mim_term
    type:
      - 'null'
      - string
    doc: Specify a omim id
    inputBinding:
      position: 101
      prefix: --mim_term
  - id: start
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --stop
  - id: to_json
    type:
      - 'null'
      - boolean
    doc: If output should be in json format
    inputBinding:
      position: 101
      prefix: --to_json
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify path to outfile
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
