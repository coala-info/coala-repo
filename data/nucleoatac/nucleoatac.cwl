cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucleoatac
label: nucleoatac
doc: "NucleoATAC is a package for identifying nucleosome positions and occupancy from
  ATAC-seq data. (Note: The provided text is a system error log and does not contain
  help information or argument definitions).\n\nTool homepage: http://nucleoatac.readthedocs.io/en/latest/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucleoatac:0.3.4--py27_1
stdout: nucleoatac.out
