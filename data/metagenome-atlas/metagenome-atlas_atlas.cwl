cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas
label: metagenome-atlas_atlas
doc: "Metagenome-atlas: a three-command pipeline for metagenome analysis.\n\nTool
  homepage: https://github.com/metagenome-atlas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metagenome-atlas:19.0.1--pyhdfd78af_0
stdout: metagenome-atlas_atlas.out
