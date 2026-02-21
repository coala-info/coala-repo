cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioprov
label: bioprov
doc: "BioProv is a library for managing bioinformatics provenance. (Note: The provided
  help text contains a system error/traceback and does not list available command-line
  arguments.)\n\nTool homepage: https://github.com/vinisalazar/BioProv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0
stdout: bioprov.out
