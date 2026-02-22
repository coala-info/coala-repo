cwlVersion: v1.2
class: CommandLineTool
baseCommand: pango-designation
label: pango-designation
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a container runtime failure (no
  space left on device).\n\nTool homepage: https://github.com/cov-lineages/pango-designation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pango-designation:1.37--pyh2628382_0
stdout: pango-designation.out
