cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - filter
label: scarap_filter
doc: "Filter the genomes or orthogroups in a pangenome.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
inputs:
  - id: pangenome
    type: File
    doc: "Input file with pangenome"
    inputBinding:
      position: 1
  - id: outfolder_path
    type: string
    doc: "Output folder"
    inputBinding:
      position: 2
  - id: genomes
    type:
      - 'null'
      - File
    doc: "Input file with genomes to extract from pangenome"
    inputBinding:
      position: 101
      prefix: --genomes
  - id: orthogroups
    type:
      - 'null'
      - File
    doc: "Input file with orthogroups to extract from pangenome"
    inputBinding:
      position: 102
      prefix: --orthogroups
  - id: cont
    type:
      - 'null'
      - boolean
    doc: "Continue in existing output folder"
    inputBinding:
      position: 102
      prefix: --cont
outputs:
  - id: outfolder
    type: Directory
    doc: "Output folder with the filtered pangenome"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
