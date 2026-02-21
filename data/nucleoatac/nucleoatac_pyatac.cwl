cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucleoatac
label: nucleoatac_pyatac
doc: "NucleoATAC is a python package for identifying nucleosome positions and occupancy
  from ATAC-seq data. (Note: The provided help text contains a container execution
  error and does not list specific arguments.)\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27_1
stdout: nucleoatac_pyatac.out
