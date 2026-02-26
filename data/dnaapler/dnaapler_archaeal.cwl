cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaapler
label: dnaapler_archaeal
doc: "A tool for analyzing and annotating archaeal genomes.\n\nTool homepage: https://github.com/gbouras13/dnaapler"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., 'archaeal', 'eukaryotic', 'prokaryotic')
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
stdout: dnaapler_archaeal.out
