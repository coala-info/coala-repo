cwlVersion: v1.2
class: CommandLineTool
baseCommand: CRISPRessoCompare
label: crispresso_CRISPRessoCompare
doc: "Comparison of two CRISPResso analysis\n\nTool homepage: https://github.com/lucapinello/CRISPResso"
inputs:
  - id: crispresso_output_folder_1
    type: Directory
    doc: First output folder with CRISPResso analysis
    inputBinding:
      position: 1
  - id: crispresso_output_folder_2
    type: Directory
    doc: Second output folder with CRISPResso analysis
    inputBinding:
      position: 2
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder
    inputBinding:
      position: 103
      prefix: --output_folder
  - id: output_name
    type:
      - 'null'
      - string
    doc: Output name
    inputBinding:
      position: 103
      prefix: --name
  - id: sample_1_name
    type:
      - 'null'
      - string
    doc: Sample 1 name
    inputBinding:
      position: 103
      prefix: --sample_1_name
  - id: sample_2_name
    type:
      - 'null'
      - string
    doc: Sample 2 name
    inputBinding:
      position: 103
      prefix: --sample_2_name
  - id: save_also_png
    type:
      - 'null'
      - boolean
    doc: Save also .png images additionally to .pdf files
    inputBinding:
      position: 103
      prefix: --save_also_png
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispresso:1.0.13--py27h470a237_1
stdout: crispresso_CRISPRessoCompare.out
