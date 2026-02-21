cwlVersion: v1.2
class: CommandLineTool
baseCommand: msproteomicstools
label: msproteomicstools
doc: "A python library and collection of tools for Mass Spectrometry (MS) proteomics
  data analysis.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h8b767f7_4
stdout: msproteomicstools.out
