cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecko_frags2align.sh
label: gecko_frags2align.sh
doc: "A tool for processing fragments and alignments (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/otorreno/gecko"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
stdout: gecko_frags2align.sh.out
