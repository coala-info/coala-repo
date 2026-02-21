cwlVersion: v1.2
class: CommandLineTool
baseCommand: simba_pbg
label: simba_pbg
doc: "SIMBA (Single-cell Multi-omics Bioinformatics Analysis) PBG component. Note:
  The provided text appears to be a container build log rather than CLI help text;
  therefore, no arguments could be extracted.\n\nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba_pbg:1.2--py310h1425a21_0
stdout: simba_pbg.out
