cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scarap
  - checkgroups
label: scarap_checkgroups
doc: "Assess the orthogroups in a core genome.\n\nTool homepage: https://github.com/SWittouck/SCARAP"
inputs:
  - id: coregenome
    type: File
    doc: "Input file with a core genome"
    inputBinding:
      position: 1
  - id: outfolder_path
    type: string
    doc: "Output folder"
    inputBinding:
      position: 2
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
    doc: "Output folder with the orthogroup assessment"
    outputBinding:
      glob: "$(inputs.outfolder_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarap:1.0.2--pyhdfd78af_0
