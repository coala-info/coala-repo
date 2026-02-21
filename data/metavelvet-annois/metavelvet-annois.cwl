cwlVersion: v1.2
class: CommandLineTool
baseCommand: metavelvet-annois
label: metavelvet-annois
doc: 'MetaVelvet-Annois (Note: The provided text contains container runtime error
  messages rather than tool help text, so no arguments could be extracted).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet-annois:0.2.01--pl526_1
stdout: metavelvet-annois.out
