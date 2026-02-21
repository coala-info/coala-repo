cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - simba_pbg
  - torchbiggraph_import_from_tsv
label: simba_pbg_torchbiggraph_import_from_tsv
doc: "Import data from TSV format for TorchBigGraph within the SIMBA PBG framework.\n
  \nTool homepage: https://github.com/pinellolab/simba_pbg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simba_pbg:1.2--py310h1425a21_0
stdout: simba_pbg_torchbiggraph_import_from_tsv.out
