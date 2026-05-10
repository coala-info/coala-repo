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
    inputBinding:
      position: 101
      prefix: --thread
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: CampyGStyper output csv file
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/campygstyper:0.1.1--pyhdfd78af_0
