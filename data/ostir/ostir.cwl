cwlVersion: v1.2
class: CommandLineTool
baseCommand: ostir
label: ostir
doc: "The provided text does not contain help information for the tool 'ostir'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to pull the tool's image due to lack of disk space.\n\nTool homepage: https://github.com/barricklab/rbs-calculator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ostir:1.1.2--pyhdfd78af_0
stdout: ostir.out
