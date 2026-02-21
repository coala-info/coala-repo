cwlVersion: v1.2
class: CommandLineTool
baseCommand: samap_map_genes.sh
label: samap_map_genes.sh
doc: "Map genes across species using SAMap. Note: The provided text contains container
  runtime logs and error messages rather than tool usage instructions.\n\nTool homepage:
  https://github.com/atarashansky/SAMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samap:1.0.15--pyhdfd78af_0
stdout: samap_map_genes.sh.out
