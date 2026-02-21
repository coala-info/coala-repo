cwlVersion: v1.2
class: CommandLineTool
baseCommand: ft
label: fibertools-rs_ft
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/mrvollger/fibertools-rs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fibertools-rs:0.8.1--h3b373d1_0
stdout: fibertools-rs_ft.out
