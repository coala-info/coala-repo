cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pneumo-typer
  - update_mlstdb_cgmlstdb
label: pneumo-typer_update_mlstdb_cgmlstdb
doc: "Update MLST and cgMLST databases for pneumo-typer\n\nTool homepage: https://www.microbialgenomic.cn/Pneumo-Typer.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pneumo-typer:2.0.1--hdfd78af_0
stdout: pneumo-typer_update_mlstdb_cgmlstdb.out
