cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirmachine
label: mirmachine
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the tool 'mirmachine'.\n
  \nTool homepage: https://github.com/sinanugur/MirMachine"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirmachine:0.3.0.2--pyhdfd78af_0
stdout: mirmachine.out
