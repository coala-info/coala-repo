cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fetchsequence
label: biobasehttptools_FetchSequence
doc: "Fetch sequence information based on gene ID, start, and stop.\n\nTool homepage:
  https://github.com/eggzilla/BiobaseHTTPTools"
inputs:
  - id: geneid
    type:
      - 'null'
      - int
    doc: Gene id
    inputBinding:
      position: 101
      prefix: --geneid
  - id: genestart
    type:
      - 'null'
      - int
    doc: Gene start
    inputBinding:
      position: 101
      prefix: --genestart
  - id: genestop
    type:
      - 'null'
      - int
    doc: Gene stop
    inputBinding:
      position: 101
      prefix: --genestop
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobasehttptools:1.1.0--0
stdout: biobasehttptools_FetchSequence.out
