cwlVersion: v1.2
class: CommandLineTool
baseCommand: ltr_finder
label: ltr_finder
doc: "LTR_FINDER is a tool for finding full-length LTR retrotransposons in genome
  sequences. (Note: The provided help text contains only system error messages and
  no command-line argument definitions.)\n\nTool homepage: https://github.com/NBISweden/LTR_Finder/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ltr_harvest_parallel:1.2--hdfd78af_2
stdout: ltr_finder.out
