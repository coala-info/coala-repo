cwlVersion: v1.2
class: CommandLineTool
baseCommand: smartmap_SmartMapPrep
label: smartmap_SmartMapPrep
doc: "A tool for SmartMap preparation. (Note: The provided text contains only system
  logs and error messages regarding a container build failure and does not list specific
  command-line arguments.)\n\nTool homepage: http://shah-rohan.github.io/SmartMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartmap:1.0.0--h077b44d_4
stdout: smartmap_SmartMapPrep.out
