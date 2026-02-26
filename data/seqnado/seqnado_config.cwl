cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqnado config
label: seqnado_config
doc: "Configure seqnado settings.\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: assay
    type:
      - 'null'
      - string
    doc: The assay to configure.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
stdout: seqnado_config.out
