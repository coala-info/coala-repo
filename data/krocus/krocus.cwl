cwlVersion: v1.2
class: CommandLineTool
baseCommand: krocus
label: krocus
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the 'krocus'
  tool. As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/andrewjpage/krocus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krocus:1.0.3--pyhdfd78af_0
stdout: krocus.out
