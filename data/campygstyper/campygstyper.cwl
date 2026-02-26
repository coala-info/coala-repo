cwlVersion: v1.2
class: CommandLineTool
baseCommand: campygstyper
label: campygstyper
doc: "CampyGStyper: a tool for rapid and accurate genome-wide SNP calling and cgMLST
  typing of Campylobacter jejuni.\n\nTool homepage: https://github.com/LanLab/campygstyper"
inputs:
  - id: query
    type: Directory
    doc: folder for the query genomes
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type: Directory
    doc: folder for the 60 medoid genomes
    inputBinding:
      position: 101
      prefix: --reference
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
  - id: output
    type: File
    doc: CampyGStyper output csv file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/campygstyper:0.1.1--pyhdfd78af_0
