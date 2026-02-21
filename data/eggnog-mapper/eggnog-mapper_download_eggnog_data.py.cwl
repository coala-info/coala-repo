cwlVersion: v1.2
class: CommandLineTool
baseCommand: download_eggnog_data.py
label: eggnog-mapper_download_eggnog_data.py
doc: "A script to download the data required by eggNOG-mapper.\n\nTool homepage: https://github.com/jhcepas/eggnog-mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eggnog-mapper:2.1.13--pyhdfd78af_2
stdout: eggnog-mapper_download_eggnog_data.py.out
