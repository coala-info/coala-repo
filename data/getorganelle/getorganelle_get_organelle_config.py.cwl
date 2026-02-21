cwlVersion: v1.2
class: CommandLineTool
baseCommand: getorganelle_get_organelle_config.py
label: getorganelle_get_organelle_config.py
doc: "A script to manage and download configurations and database files for GetOrganelle.\n
  \nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_get_organelle_config.py.out
