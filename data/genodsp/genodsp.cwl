cwlVersion: v1.2
class: CommandLineTool
baseCommand: genodsp
label: genodsp
doc: "Genomic Digital Signal Processing tool. (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/rsharris/genodsp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genodsp:0.0.10--h7b50bb2_1
stdout: genodsp.out
