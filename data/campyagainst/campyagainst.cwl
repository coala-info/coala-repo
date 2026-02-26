cwlVersion: v1.2
class: CommandLineTool
baseCommand: campyagainst
label: campyagainst
doc: "Classify genomes based on ANI values against a reference database.\n\nTool homepage:
  https://github.com/LanLab/campyagainst"
inputs:
  - id: query_folder
    type: Directory
    doc: folder for the query genomes
    inputBinding:
      position: 101
      prefix: --query
  - id: thread
    type:
      - 'null'
      - int
    doc: number of thread to run fastANI
    default: 4
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: output_file
    type: File
    doc: tabular output file with classifications for each genome in query 
      folder
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/campyagainst:0.1.0--pyhdfd78af_0
