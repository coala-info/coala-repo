cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybedtools
label: pybedtools
doc: "A Python wrapper for the BEDTools suite of programs, used for genomic interval
  manipulation.\n\nTool homepage: https://github.com/daler/pybedtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybedtools:0.12.0--py310h275bdba_0
stdout: pybedtools.out
