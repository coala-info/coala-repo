cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cameo
  - search
label: cameo_search
doc: "Search for available products.\n\nTool homepage: http://cameo.bio"
inputs:
  - id: product
    type: string
    doc: The target product. You can search by name, InChI, and metanetx ID.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cameo:0.13.6--pyhdfd78af_0
stdout: cameo_search.out
