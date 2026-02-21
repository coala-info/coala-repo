cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsort
label: gsort
doc: "A tool for sorting genomic files (Note: The provided text is a system error
  log and does not contain usage information or argument definitions).\n\nTool homepage:
  https://github.com/brentp/gsort"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsort:0.1.5--he881be0_0
stdout: gsort.out
