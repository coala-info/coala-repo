cwlVersion: v1.2
class: CommandLineTool
baseCommand: kompot
label: kompot
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool 'kompot'.\n
  \nTool homepage: https://github.com/settylab/kompot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kompot:0.6.2--pyhdfd78af_0
stdout: kompot.out
