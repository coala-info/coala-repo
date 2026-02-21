cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - ice
label: sga_ice
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build or run a container due to
  lack of disk space.\n\nTool homepage: https://github.com/hillerlab/IterativeErrorCorrection"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_ice.out
