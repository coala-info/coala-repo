cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmfinder
label: cmfinder
doc: "CMfinder is a tool for RNA motif discovery. (Note: The provided input text appears
  to be a container runtime error log rather than help text, so no arguments could
  be extracted.)\n\nTool homepage: https://sourceforge.net/projects/weinberg-cmfinder/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmfinder:0.4.1.9--pl5.22.0_1
stdout: cmfinder.out
