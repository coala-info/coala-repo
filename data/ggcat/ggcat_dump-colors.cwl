cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ggcat
  - dump-colors
label: ggcat_dump-colors
doc: "Dumps the colors from a colormap file.\n\nTool homepage: https://github.com/algbio/ggcat"
inputs:
  - id: input_colormap
    type: File
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ggcat:2.0.0--ha96b9cd_0
