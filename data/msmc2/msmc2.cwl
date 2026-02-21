cwlVersion: v1.2
class: CommandLineTool
baseCommand: msmc2
label: msmc2
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/stschiff/msmc2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msmc2:2.1.4--hdfd78af_0
stdout: msmc2.out
