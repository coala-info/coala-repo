cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phizz
  - query
label: phizz_query
doc: "Query the hpo database.\n  Print the result in csv format as default.\n\nTool
  homepage: https://github.com/moonso/phizz"
inputs:
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
      - type: array
        items: string
        inputBinding:
          prefix: --hpo_term
    doc: Specify a hpo term
  - id: mim_term
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --mim_term
    doc: Specify a omim id
  - id: to_json
    type:
      - 'null'
      - boolean
    doc: If output should be in json format
    inputBinding:
      position: 101
      prefix: --to_json
  - id: chrom
    type:
      - 'null'
      - string
    doc: The chromosome
    inputBinding:
      position: 101
      prefix: --chrom
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
  - id: outfile_path
    type: string
    doc: Specify path to outfile
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Specify path to outfile
    outputBinding:
      glob: $(inputs.outfile_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phizz:0.2.3--py_0
