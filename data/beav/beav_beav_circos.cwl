cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - beav
  - circos
label: beav_beav_circos
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or extract a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/weisberglab/beav"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beav:1.4.0--hdfd78af_1
stdout: beav_beav_circos.out
