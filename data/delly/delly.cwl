cwlVersion: v1.2
class: CommandLineTool
baseCommand: delly
label: delly
doc: "The provided text does not contain help information for the tool 'delly'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: https://github.com/dellytools/delly"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delly:1.7.2--h4d20210_0
stdout: delly.out
