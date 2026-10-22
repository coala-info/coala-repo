cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tgv
  - list
label: tgv_list
doc: "List reference genomes on UCSC\n\nTool homepage: https://github.com/zeqianli/tgv"
inputs:
  - id: more
    type:
      - 'null'
      - boolean
    doc: List more reference genomes (UCSC common genomes (stored locally) and UCSC
      assemblies)
    inputBinding:
      position: 101
      prefix: --more
  - id: all
    type:
      - 'null'
      - boolean
    doc: List all reference genomes (UCSC common genomes (stored locally), UCSC
      assemblies, and all UCSC accessions)
    inputBinding:
      position: 101
      prefix: --all
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgv:0.1.0--h521fa98_0
stdout: tgv_list.out
