cwlVersion: v1.2
class: CommandLineTool
baseCommand: fiji
label: fiji-omero_ij
doc: "Fiji (ImageJ) distribution with OMERO plugins. Note: The provided help text
  contains system error logs regarding container image building and does not list
  command-line arguments.\n\nTool homepage: https://github.com/ome/omero-insight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiji:20250206--h9ee0642_1
stdout: fiji-omero_ij.out
