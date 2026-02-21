cwlVersion: v1.2
class: CommandLineTool
baseCommand: tissuumaps
label: tissuumaps
doc: "TissuuMaps is a tool for interactive visualization and analysis of large-scale
  spatial omics data. (Note: The provided text is a container build log and does not
  contain CLI help information; therefore, no arguments could be extracted.)\n\nTool
  homepage: https://tissuumaps.research.it.uu.se/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tissuumaps:3.2.1.14--pyh7e72e81_0
stdout: tissuumaps.out
