cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tapestry
  - clean
label: tapestry_clean
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain the help documentation or usage instructions for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/johnomics/tapestry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tapestry:1.0.1--pyhdfd78af_0
stdout: tapestry_clean.out
