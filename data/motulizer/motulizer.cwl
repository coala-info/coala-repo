cwlVersion: v1.2
class: CommandLineTool
baseCommand: motulizer
label: motulizer
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation for the tool 'motulizer'. As a result,
  no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/moritzbuck/mOTUlizer/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/motulizer:0.3.2--pyhdfd78af_0
stdout: motulizer.out
