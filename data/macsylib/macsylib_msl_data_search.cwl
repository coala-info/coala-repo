cwlVersion: v1.2
class: CommandLineTool
baseCommand: [msl_data, search]
label: macsylib_msl_data_search
doc: "Searches for model packages matching a pattern\n\nTool homepage: https://github.com/gem-pasteur/macsylib"
inputs:
  - id: org
    type:
      - 'null'
      - string
    doc: "The name of Model organization (default macsy-models)"
    inputBinding:
      position: 1
      prefix: --org
  - id: careful
    type:
      - 'null'
      - boolean
    doc: "Careful search (-S)"
    inputBinding:
      position: 2
      prefix: -S
  - id: match_case
    type:
      - 'null'
      - boolean
    doc: "Match the case of the pattern"
    inputBinding:
      position: 3
      prefix: --match-case
  - id: pattern
    type: string
    doc: "Searches for packages matching the pattern."
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsylib:1.0.4--pyhdfd78af_1
stdout: macsylib_msl_data_search.out
