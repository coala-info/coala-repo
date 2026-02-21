cwlVersion: v1.2
class: CommandLineTool
baseCommand: smoove
label: smoove
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a system error log from a container runtime (Singularity/Apptainer)
  failing to fetch or build the tool's image.\n\nTool homepage: https://github.com/brentp/smoove"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smoove:0.2.8--h9ee0642_1
stdout: smoove.out
