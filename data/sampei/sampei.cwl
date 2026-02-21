cwlVersion: v1.2
class: CommandLineTool
baseCommand: sampei
label: sampei
doc: "A tool for SAM/BAM/CRAM file processing (Note: The provided text is a container
  execution log and does not contain specific help documentation or argument details).\n
  \nTool homepage: https://github.com/FenyoLab/SAMPEI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sampei:0.0.9--py_0
stdout: sampei.out
