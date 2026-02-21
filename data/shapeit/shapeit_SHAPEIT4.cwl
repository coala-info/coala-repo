cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeit4
label: shapeit_SHAPEIT4
doc: "The provided text does not contain help information for the tool, but rather
  an error log regarding a container build failure (no space left on device). No arguments
  could be extracted.\n\nTool homepage: https://github.com/odelaneau/shapeit4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeit:2.r837--h09b0a5c_1
stdout: shapeit_SHAPEIT4.out
