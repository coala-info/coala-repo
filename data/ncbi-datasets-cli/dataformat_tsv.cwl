cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dataformat
  - tsv
label: dataformat_tsv
doc: Convert data to TSV format.
inputs:
  - id: command
    type: string
    doc: The report type to convert (e.g., genome, gene, virus-genome, etc.)
    inputBinding:
      position: 1
  - id: elide_header
    type:
      - 'null'
      - boolean
    doc: Do not output header
    inputBinding:
      position: 102
      prefix: --elide-header
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force dataformat to run without type check prompt
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: ensemblorg/datasets-cli:latest
stdout: dataformat_tsv.out
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
