cwlVersion: v1.2
class: CommandLineTool
baseCommand: slow5curl
label: slow5curl
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) failing
  to fetch the tool's image.\n\nTool homepage: https://github.com/BonsonW/slow5curl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slow5curl:0.3.0--h86e5fe9_0
stdout: slow5curl.out
