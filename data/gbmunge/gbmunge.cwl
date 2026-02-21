cwlVersion: v1.2
class: CommandLineTool
baseCommand: gbmunge
label: gbmunge
doc: "A tool for munging GenBank files (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/sdwfrost/gbmunge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gbmunge:2018.07.06--h7b50bb2_7
stdout: gbmunge.out
