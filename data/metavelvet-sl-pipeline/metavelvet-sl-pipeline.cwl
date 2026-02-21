cwlVersion: v1.2
class: CommandLineTool
baseCommand: metavelvet-sl-pipeline
label: metavelvet-sl-pipeline
doc: 'MetaVelvet-SL: an extension of MetaVelvet using supervised learning for metagenomic
  assembly.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet-sl-pipeline:1.0--pl5.22.0_0
stdout: metavelvet-sl-pipeline.out
