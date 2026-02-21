cwlVersion: v1.2
class: CommandLineTool
baseCommand: lumpyexpress
label: lumpy-sv-minimal_lumpyexpress
doc: "A structural variant discovery tool. (Note: The provided help text contains
  only system error messages regarding container execution and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv-minimal:0.3.1--h5ca1c30_7
stdout: lumpy-sv-minimal_lumpyexpress.out
