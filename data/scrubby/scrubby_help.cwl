cwlVersion: v1.2
class: CommandLineTool
baseCommand: scrubby
label: scrubby_help
doc: "Scrubby command-line application\n\nTool homepage: https://github.com/esteinig/scrubby"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to run (e.g., scrub-reads)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrubby:0.2.1--h715e4b3_0
stdout: scrubby_help.out
