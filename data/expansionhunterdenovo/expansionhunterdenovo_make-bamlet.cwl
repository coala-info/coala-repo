cwlVersion: v1.2
class: CommandLineTool
baseCommand: expansionhunterdenovo_make-bamlet
label: expansionhunterdenovo_make-bamlet
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image creation (no space
  left on device).\n\nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h0cd1d96_4
stdout: expansionhunterdenovo_make-bamlet.out
