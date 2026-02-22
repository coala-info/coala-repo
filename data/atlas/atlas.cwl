cwlVersion: v1.2
class: CommandLineTool
baseCommand: atlas
label: atlas
doc: "Metagenome atlas: a three-command pipeline for assembly, annotation, and genomic
  binning of metagenomes.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas.out
