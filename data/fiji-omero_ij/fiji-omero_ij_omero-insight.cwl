cwlVersion: v1.2
class: CommandLineTool
baseCommand: fiji-omero_ij_omero-insight
label: fiji-omero_ij_omero-insight
doc: "Fiji (ImageJ) with OMERO insight plugin. Note: The provided help text contains
  only system error messages regarding container image conversion and disk space,
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/ome/omero-insight"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiji:20250206--h9ee0642_1
stdout: fiji-omero_ij_omero-insight.out
