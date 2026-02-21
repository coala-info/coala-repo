cwlVersion: v1.2
class: CommandLineTool
baseCommand: pscan-chip
label: pscan-chip
doc: 'Pscan-ChIP is a tool for finding over-represented transcription factor binding
  sites in ChIP-Seq data. (Note: The provided help text contains only container execution
  errors and no usage information.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pscan-chip:v1.1-2-deb_cv1
stdout: pscan-chip.out
