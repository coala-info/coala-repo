cwlVersion: v1.2
class: CommandLineTool
baseCommand: bambamc
label: bambamc
doc: "A tool for processing BAM files (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/gt1/bambamc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bambamc:0.0.50--h577a1d6_9
stdout: bambamc.out
