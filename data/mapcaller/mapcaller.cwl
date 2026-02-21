cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapcaller
label: mapcaller
doc: "A tool for variant calling and read mapping (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/hsinnan75/MapCaller"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapcaller:0.9.9.41--h13024bc_6
stdout: mapcaller.out
