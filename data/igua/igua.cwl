cwlVersion: v1.2
class: CommandLineTool
baseCommand: igua
label: igua
doc: "The provided text contains fatal error messages related to a container execution
  environment (Singularity/Apptainer) rather than the help documentation for the 'igua'
  tool itself. As a result, no arguments or tool-specific descriptions could be extracted.\n
  \nTool homepage: https://github.com/zellerlab/IGUA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igua:0.1.0--py39h5b94c0b_0
stdout: igua.out
