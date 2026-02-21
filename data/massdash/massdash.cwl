cwlVersion: v1.2
class: CommandLineTool
baseCommand: massdash
label: massdash
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/Roestlab/massdash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massdash:0.1.1--pyhdfd78af_0
stdout: massdash.out
