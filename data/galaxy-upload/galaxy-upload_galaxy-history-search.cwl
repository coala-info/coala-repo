cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - galaxy-upload
  - galaxy-history-search
label: galaxy-upload_galaxy-history-search
doc: "Search Galaxy history\n\nTool homepage: https://github.com/galaxyproject/galaxy-upload"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-upload:1.0.1--pyhdfd78af_0
stdout: galaxy-upload_galaxy-history-search.out
