cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dataformat
  - excel
label: dataformat_excel
doc: Convert data into an Excel workbook.
inputs:
  - id: command
    type: string
    doc: The report command to run (genome, genome-seq, gene, gene-product, 
      virus-genome, virus-annotation, microbigge, prok-gene, prok-gene-location,
      or feature)
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Excel workbook file
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force dataformat to run without type check prompt
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: output_output_file
    type:
      - 'null'
      - File
    doc: Excel workbook file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: ensemblorg/datasets-cli:latest
s:url: https://github.com/metagenlab/assembly_finder
$namespaces:
  s: https://schema.org/
