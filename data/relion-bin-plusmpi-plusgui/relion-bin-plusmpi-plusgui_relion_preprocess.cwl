cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_preprocess
label: relion-bin-plusmpi-plusgui_relion_preprocess
doc: "Provide either --o or --operate_on\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: operate_on
    type:
      - 'null'
      - File
    doc: File to operate on
    inputBinding:
      position: 101
      prefix: --operate_on
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusmpi-plusgui:v1.4dfsg-4-deb_cv1
