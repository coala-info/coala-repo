cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtnucratio
label: mtnucratio
doc: "A tool for calculating the mitochondrial to nuclear DNA ratio. (Note: The provided
  help text contains only container runtime error messages and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/apeltzer/MTNucRatioCalculator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtnucratio:0.7.1--hdfd78af_0
stdout: mtnucratio.out
