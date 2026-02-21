cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmlst_api
label: rmlst_api
doc: "Ribosomal MLST (rMLST) API tool for species identification and typing.\n\nTool
  homepage: pypi.org/project/rmlst-api"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmlst_api:0.1.8--pyhdfd78af_0
stdout: rmlst_api.out
