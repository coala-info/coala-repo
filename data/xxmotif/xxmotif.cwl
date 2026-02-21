cwlVersion: v1.2
class: CommandLineTool
baseCommand: xxmotif
label: xxmotif
doc: "A tool for exhaustive evaluation of motifs (Note: The provided text contains
  system logs and error messages rather than help documentation, so no arguments could
  be extracted).\n\nTool homepage: https://github.com/soedinglab/xxmotif"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xxmotif:1.6--0
stdout: xxmotif.out
