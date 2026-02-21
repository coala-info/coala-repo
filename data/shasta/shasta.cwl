cwlVersion: v1.2
class: CommandLineTool
baseCommand: shasta
label: shasta
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or command-line arguments for the shasta tool.\n
  \nTool homepage: https://github.com/chanzuckerberg/shasta"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shasta:0.14.0--h9948957_0
stdout: shasta.out
