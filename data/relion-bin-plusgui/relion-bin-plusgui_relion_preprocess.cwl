cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion-bin-plusgui_relion_preprocess
label: relion-bin-plusgui_relion_preprocess
doc: "Provide either --o or --operate_on\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: operate_on
    type:
      - 'null'
      - File
    doc: Input file to operate on
    inputBinding:
      position: 101
      prefix: --operate_on
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin-plusgui:v1.4dfsg-4-deb_cv1
stdout: relion-bin-plusgui_relion_preprocess.out
